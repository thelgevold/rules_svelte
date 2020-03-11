def get_config(ctx):
  config = ctx.actions.declare_file("rollup_config.js")

  argsConfig = ctx.actions.args()
  argsConfig.add(config.path)
  argsConfig.add(ctx.executable._rollup.dirname.replace("bazel-out/", "") + "/" + "rollup_bin.sh.runfiles/build_bazel_rules_svelte_deps")
  argsConfig.add(ctx.bin_dir.path)
  
  ctx.actions.run(
      executable = ctx.executable._config,
      outputs = [config],
      arguments = [argsConfig]
  )

  return config

