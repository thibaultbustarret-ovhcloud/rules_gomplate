package(default_visibility = ["//visibility:public"])

filegroup(
    name = "binary_{os}_{arch}",
    srcs = ["gomplate"],
    visibility = ["//visibility:public"]
)
