load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@build_bazel_rules_nodejs//:defs.bzl", "yarn_install")

def rules_svelte_dependencies():
  http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "abcf497e89cfc1d09132adfcd8c07526d026e162ae2cb681dcb896046417ce91",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/0.30.1/rules_nodejs-0.30.1.tar.gz"],
 )
  
  yarn_install(
    name = "build_bazel_rules_svelte_deps",
    package_json = "@build_bazel_rules_svelte//internal:package.json",
    yarn_lock = "@build_bazel_rules_svelte//internal:yarn.lock",
  )



 
