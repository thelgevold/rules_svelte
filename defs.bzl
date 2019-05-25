load("//internal:bundle-dev.bzl", _bundle_dev = "bundle_dev")
load("//internal:bundle-prod.bzl", _bundle_prod = "bundle_prod")
load("//internal:svelte.bzl", _svelte = "svelte")

load("//:package.bzl", _rules_svelte_dependencies = "rules_svelte_dependencies")

svelte = _svelte
bundle_prod = _bundle_prod
bundle_dev = _bundle_dev
rules_svelte_dependencies = _rules_svelte_dependencies