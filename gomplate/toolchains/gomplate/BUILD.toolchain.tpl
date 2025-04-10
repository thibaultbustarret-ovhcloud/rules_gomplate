package(default_visibility = ["//visibility:public"])

filegroup(
    name = "binary_{os}_{arch}",
    srcs = ["gomplate/binary_v{version}_{os}_{arch}"],
    visibility = ["//visibility:public"]
)
