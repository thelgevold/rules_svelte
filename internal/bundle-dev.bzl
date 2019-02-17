load("//internal:get-files.bzl", "get_files")

def _bundle_dev(ctx):
  files = get_files(ctx)
      
  args = ctx.actions.args()
  args.add(["--input", ctx.bin_dir.path + "/" + ctx.file.entry_point.path])
  args.add(["--output.file", ctx.outputs.build.path])
  args.add(["--output.format", "iife"])
  args.add("--no-treeshake")
  args.add("--no-indent")

  ctx.action(
      executable = ctx.executable._rollup,
      inputs = files,
      outputs = [ctx.outputs.build],
      arguments = [args]
  )
 
bundle_dev = rule(
  implementation = _bundle_dev,
  attrs = {
    "deps": attr.label_list(),
    "entry_point": attr.label(allow_files = True, single_file = True),
    "_rollup": attr.label(
        executable = True,
        cfg="host",
        default = Label("@build_bazel_rules_nodejs//internal/rollup:rollup")),
    },
    outputs = {"build": "%{name}.es6.js", "css": "%{name}.css"}
)
