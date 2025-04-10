def _gomplate_binary_impl(ctx):

    output = ctx.actions.declare_file(ctx.attr.out)

    # define args to be passed to gomplate command
    arguments = ctx.actions.args()
    arguments.add("--file", ctx.file.template)
    arguments.add("--out", output)

    if ctx.file.config:
        arguments.add("--config", ctx.file.config)

    if ctx.attr.experimental:
        arguments.add("--experimental")

    for datasource, name in ctx.attr.datasources.items():
        files = datasource[DefaultInfo].files.to_list()
        if len(files) != 1:
            fail("Target passed as datasource cannot contain more than 1 file")
        file = files[0]
        arguments.add(
            "--datasource",
            "{name}={datasource}".format(
                name = name,
                datasource = file.path,
            ),
        )

    for context, name in ctx.attr.context.items():
        files = context[DefaultInfo].files.to_list()
        if len(files) != 1:
            fail("Target passed as context cannot contain more than 1 file")
        file = files[0]
        arguments.add(
            "--context",
            "{name}={context}".format(
                name = name if len(name) > 0 else ".", # '.' addds to context without prefix
                context = file.path,
            ),
        )

    if ctx.attr.left_delim != "":
        arguments.add("--left-delim", ctx.attr.left_delim)
    if ctx.attr.right_delim != "":
        arguments.add("--right-delim", ctx.attr.right_delim)

    ctx.actions.run(
        executable = ctx.toolchains["@rules_gomplate//:toolchain_type"].runtime.binary,
        arguments = [arguments],
        inputs = [
            ctx.file.template,
            # _data,
            # _tools,
        ] + ctx.files.datasources
          + ctx.files.context,
        outputs = [output],
    )

    return [DefaultInfo(
        executable = output,
    )]

gomplate_binary = rule(
    implementation = _gomplate_binary_impl,
    toolchains = ["@rules_gomplate//:toolchain_type"],
    attrs = {
        "out": attr.string(),
        "datasources": attr.label_keyed_string_dict(
            allow_files = True,
            doc = "A set of 'file: name' datasources to be passed in default context to gomplate",
        ),
        "context": attr.label_keyed_string_dict(
            allow_files = True,
            doc = "A set of 'file: name' datasources to be passed to gomplate",
        ),
        "left_delim": attr.string(
            default = "",
            doc = "The left delimiter to be used with gomplate",
        ),
        "right_delim": attr.string(
            default = "",
            doc = "The right delimiter to be used with gomplate",
        ),
        "template": attr.label(
            allow_single_file = True,
            doc = "The template to be rendered using gomplate",
            mandatory = True,
        ),
        "experimental": attr.bool(
            default = False,
            doc = "Enable experimental features",
        ),
        "config": attr.label(
            allow_single_file = True,
            doc = "A file to be used as a gomplate config file",
        ),
    },
    executable = True,
)
