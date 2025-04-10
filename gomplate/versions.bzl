VERSIONS = {
    "linux_amd64":{
        "version": "4.3.1",
        "sha256": "9f6c008a8ffa2574ce404acd31dd4efbdbde7aeaa867f0b8fd8dccd298cd282e",
        "os" : "linux",
        "arch": "amd64",
        "exec_compatible_with": [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
        "target_compatible_with" : [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
    },
    "linux_arm64":{
        "sha256": "214aa853c42d344254da15cf2e163217a033e08fc0d3a7c3654f1775dc6e3c15",
        "version": "4.3.1",
        "os" : "linux",
        "arch": "amd64",
        "exec_compatible_with": [
            "@platforms//os:linux",
            "@platforms//cpu:arm64",
        ],
        "target_compatible_with" : [
            "@platforms//os:linux",
            "@platforms//cpu:arm64",
        ],
    },
    "darwin_amd64":{
        "version": "4.3.1",
        "sha256": "e5e5d87f9298542f9717ab66ca07d9abf0b4721fde7238c0d6af8b17b414deb4",
        "os" : "darwin",
        "arch": "amd64",
        "exec_compatible_with": [
            "@platforms//os:osx",
            "@platforms//cpu:x86_64",
        ],
        "target_compatible_with" : [
            "@platforms//os:osx",
            "@platforms//cpu:x86_64",
        ],
    },
    "darwin_arm64":{
        "version": "4.3.1",
        "sha256": "60ed24f0d1cbc861da6aac7ebc09898ca5951f4be7df5401298b7563ab2162ba",
        "os" : "darwin",
        "arch": "arm64",
        "exec_compatible_with": [
            "@platforms//os:osx",
            "@platforms//cpu:aarch64",
        ],
        "target_compatible_with" : [
            "@platforms//os:osx",
            "@platforms//cpu:aarch64",
        ],
    },
}
