load("@rules_gomplate//gomplate/toolchains/gomplate:toolchain.bzl", "gomplate_toolchain")
load("@rules_gomplate//gomplate:versions.bzl", "VERSIONS")

def register_toolchains():
    toolchain_typename = "toolchain_type"

    native.toolchain_type(
        name = toolchain_typename,
        visibility = ["//visibility:public"],
    )

    for version in VERSIONS:
        toolchain_name = "{}_toolchain".format(version)
        gomplate_toolchain(
            name = "{}_impl".format(version),
            binary = "@gomplate_{}//:binary_{}".format(version, version),
        )

        native.toolchain(
            name = toolchain_name,
            exec_compatible_with = VERSIONS[version]["exec_compatible_with"],
            target_compatible_with = VERSIONS[version]["exec_compatible_with"],
            toolchain = ":{}_impl".format(version),
            toolchain_type = ":{}".format(toolchain_typename),
            visibility = ["//visibility:public"],
        )
