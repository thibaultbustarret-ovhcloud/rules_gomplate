# Copyright 2019 The Codelogia Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
This module exports the repositories required by the gomplate rules.
"""

def gomplate_repositories(**kwargs):
    _gomplate_binary(
        name = "gomplate",
        **kwargs
    )

def _gomplate_binary_impl(ctx):
    info = None
    if ctx.os.name == "mac os x":
        info = ctx.attr.darwin
    elif ctx.os.name == "linux":
        info = ctx.attr.linux
    elif ctx.os.name == "windows":
        info = ctx.attr.windows
    else:
        fail("Unsupported operating system: {}".format(ctx.os.name))

    ctx.download(
        output = ctx.attr.name,
        executable = True,
        **info
    )

    build_contents = 'package(default_visibility = ["//visibility:public"])\n'
    build_contents += 'exports_files(["{name}"])\n'.format(name = ctx.attr.name)
    ctx.file("BUILD.bazel", build_contents)

_gomplate_binary = repository_rule(
    implementation = _gomplate_binary_impl,
    attrs = {
        "darwin": attr.string_dict(
            default = {
                "sha256": "e5e5d87f9298542f9717ab66ca07d9abf0b4721fde7238c0d6af8b17b414deb4",
                "url": "https://github.com/hairyhenderson/gomplate/releases/download/v4.3.1/gomplate_darwin-amd64",
            },
        ),
        "linux": attr.string_dict(
            default = {
                "sha256": "9f6c008a8ffa2574ce404acd31dd4efbdbde7aeaa867f0b8fd8dccd298cd282e",
                "url": "https://github.com/hairyhenderson/gomplate/releases/download/v4.3.1/gomplate_linux-amd64",
            },
        ),
        "windows": attr.string_dict(
            default = {
                "sha256": "1bcd40bc3e181c0bc7287881192025cf49e77f51e0761c941809a467aa81ded7",
                "url": "https://github.com/hairyhenderson/gomplate/releases/download/v4.3.1/gomplate_windows-amd64.exe",
            },
        ),
    },
)
