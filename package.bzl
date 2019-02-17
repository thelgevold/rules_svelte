load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@build_bazel_rules_nodejs//:defs.bzl", "yarn_install")

def rules_svelte_dependencies():
  http_archive(
    name = "build_bazel_rules_nodejs",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/0.18.6/rules_nodejs-0.18.6.tar.gz"],
    sha256 = "1416d03823fed624b49a0abbd9979f7c63bbedfd37890ddecedd2fe25cccebc6",
  )  
  
  yarn_install(
    name = "build_bazel_rules_svelte_deps",
    package_json = "@build_bazel_rules_svelte//internal:package.json",
    yarn_lock = "@build_bazel_rules_svelte//internal:yarn.lock",
  )



 
