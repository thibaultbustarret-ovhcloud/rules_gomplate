GomplateInfo = provider(
    doc = "Information about how to invoke Gomplate.",
    fields = ["binary"],
)

def _gomplate_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        runtime = GomplateInfo(
            binary = ctx.file.binary,
        ),
    )
    return [toolchain_info]

gomplate_toolchain = rule(
    implementation = _gomplate_toolchain_impl,
    attrs = {
        "binary": attr.label(
            mandatory = True,
            allow_single_file = True,
            executable = True,
            cfg = "target",
        ),
    },
)

def _download_impl(ctx):
    ctx.report_progress("Downloading gomplate")

    ctx.template(
        "BUILD",
        Label("@rules_gomplate//gomplate/toolchains/gomplate:gomplate.toolchain.tpl"),
        executable = False,
        substitutions = {
            "{version}": ctx.attr.version,
            "{os}": ctx.attr.os,
            "{arch}": ctx.attr.arch,
        },
    )

    url_template = "https://github.com/hairyhenderson/gomplate/releases/download/v{version}/gomplate_{os}-{arch}"
    url = url_template.format(version = ctx.attr.version, os = ctx.attr.os, arch = ctx.attr.arch)

    if not ctx.download(
        url = url,
        sha256 = ctx.attr.sha256,
        output = "gomplate",
     ):
        fail("could not dl toolchain")

    return {
        "version": ctx.attr.version,
        "sha256": ctx.attr.sha256,
        "os": ctx.attr.os,
        "arch": ctx.attr.arch,
        "name": ctx.attr.name,
    }

gomplate_download = repository_rule(
    implementation = _download_impl,
    attrs = {
        "version": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "os": attr.string(mandatory = True),
        "arch": attr.string(mandatory = True),
    },
)
