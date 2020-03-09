load("//internal:get-files.bzl", "get_files")
load("//internal:get-config.bzl", "get_config")

def _bundle_dev(ctx):
  files = get_files(ctx)

  config = get_config(ctx)
  files.append(config)

  args = ctx.actions.args()
  args.add_all(["--config", config.path])
  args.add_all(["--input", ctx.bin_dir.path + "/" + ctx.file.entry_point.path])
  args.add_all(["--file", ctx.outputs.build.path])

  ctx.actions.run(
      executable = ctx.executable._rollup,
      inputs = files,
      outputs = [ctx.outputs.build, ctx.outputs.map],
      arguments = [args]
  )
 
bundle_dev = rule(
  implementation = _bundle_dev,
  attrs = {
    "deps": attr.label_list(),
    "entry_point": attr.label(allow_single_file = True),
    "_rollup": attr.label(
        executable = True,
        cfg="host",
        default = Label("//internal:rollup_bin")),
    "_config": attr.label(
        executable = True,
        cfg="host",
        default = Label("//internal:create_config"))
    },
    outputs = {"build": "%{name}.es6.js", "map": "%{name}.es6.js.map"}
)
