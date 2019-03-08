Experimental rules for building Svelte components with Bazel

## Quickstart

### Dependencies

1. Install WORKSPACE dependencies

   ```python
    http_archive(
       name = "build_bazel_rules_svelte",
       url = "https://github.com/thelgevold/rules_svelte/archive/0.1.zip",
       strip_prefix = "rules_svelte-0.1",
       sha256 = "700a19d6d503500bd8dc190d7e29588c16867c2e163d7c8a883879ff602ef527"
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
      entry_point = "Comments.html",
      deps = [
        ":add-comment",
        ":comment",
        ":comment-tree"
      ]
   )
   ```
2. Add styles using SASS

  ```pythin
  load("@io_bazel_rules_sass//sass:sass.bzl", "sass_binary")

  sass_binary(
     name = "styles",
     src = "comments.scss", 
  )
  ```

3. Bundle components using bundle_prod or bundle_dev 

    ```python
   load("@build_bazel_rules_svelte//:defs.bzl", "bundle_prod")
   
   bundle_prod(
      name = "comments_bundle",
      entry_point = "main.js",
      deps = [
        ":comments",
        ":styles"
      ],
   )
   
   bundle_dev(
      name = "comments_bundle",
      entry_point = "main.js",
      deps = [
        ":comments",
        ":styles"
      ],
   )
    ```

Blog Posts:

http://www.syntaxsuccess.com/viewarticle/svelte-bazel-build

http://www.syntaxsuccess.com/viewarticle/svelte-bazel-seed
