load("@rules_gomplate//gomplate/rules:binary.bzl", _gomplate_binary = "gomplate_binary")

BZL_FILES = [
    "**/*.bazel",
    "**/WORKSPACE*",
    "**/BUILD",
]

gomplate_binary = _gomplate_binary