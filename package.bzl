"External workspace requirements for rules_svelte"

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

def rules_svelte_dependencies():
    http_archive(
        name = "build_bazel_rules_nodejs",
        sha256 = "452bef42c4b2fbe0f509a2699ffeb3ae2c914087736b16314dbd356f3641d7e5",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/2.3.0/rules_nodejs-2.3.0.tar.gz"],
    )

    yarn_install(
        name = "build_bazel_rules_svelte_deps",
        package_json = "@build_bazel_rules_svelte//internal:package.json",
        yarn_lock = "@build_bazel_rules_svelte//internal:yarn.lock",
    )
