load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

def rules_svelte_dependencies():
  http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "2eca5b934dee47b5ff304f502ae187c40ec4e33e12bcbce872a2eeb786e23269",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/1.4.1/rules_nodejs-1.4.1.tar.gz"],
  )
  
  yarn_install(
    name = "build_bazel_rules_svelte_deps",
    package_json = "@build_bazel_rules_svelte//internal:package.json",
    yarn_lock = "@build_bazel_rules_svelte//internal:yarn.lock",
  )



 
