Experimental rules for building Svelte components with Bazel

## Quickstart

### Dependencies

1. Install WORKSPACE dependencies

```python
http_archive(
    name = "build_bazel_rules_svelte",
    url = "https://github.com/thelgevold/rules_svelte/archive/0.13.zip",
    strip_prefix = "rules_svelte-0.13",
    sha256 = "a18a7f39b2db007e711615b20582da79512fea1b62aaaf02d84a87aa5c6c5e86"
) 

load("@build_bazel_rules_svelte//:defs.bzl", "rules_svelte_dependencies")
rules_svelte_dependencies()
```

### Rules

1. Compiling components using svelte

```python
load("@build_bazel_rules_svelte//:defs.bzl", "svelte")

svelte(
   name = "comments",
   srcs = [
      "main.js",
      "comment-service.js"
   ],
   entry_point = "Comments.svelte",
   deps = [
      ":other_svelte_rules"
   ]
)
```

2. Bundle components using bundle_prod or bundle_dev

```python
load("@build_bazel_rules_svelte//:defs.bzl", "bundle_prod")

bundle_prod(
name = "comments_bundle",
   entry_point = "main.js",
   deps = [
      ":comments",
      "@npm//my-npm-dep"
   ],
)

bundle_dev(
   name = "comments_bundle",
   entry_point = "main.js",
   deps = [
      ":comments",
      "@npm//my-npm-dep"
   ],
)
```

Example Project: https://github.com/thelgevold/svelte-bazel-example

Blog Posts:

http://www.syntaxsuccess.com/viewarticle/svelte-bazel-build

http://www.syntaxsuccess.com/viewarticle/svelte-bazel-seed

http://www.syntaxsuccess.com/viewarticle/remote-build-execution-with-bazel-and-svelte
