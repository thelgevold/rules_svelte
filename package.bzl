"External workspace requirements for rules_svelte"

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

def rules_svelte_dependencies():
    http_archive(
        name = "build_bazel_rules_nodejs",
        sha256 = "10fffa29f687aa4d8eb6dfe8731ab5beb63811ab00981fc84a93899641fd4af1",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/2.0.3/rules_nodejs-2.0.3.tar.gz"],
    )

    yarn_install(
        name = "build_bazel_rules_svelte_deps",
        package_json = "@build_bazel_rules_svelte//internal:package.json",
        yarn_lock = "@build_bazel_rules_svelte//internal:yarn.lock",
    )
