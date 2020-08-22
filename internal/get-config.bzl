def get_config(ctx):
    config = ctx.actions.declare_file("rollup_config.js")

    args_config = ctx.actions.args()
    args_config.add(config.path)
    args_config.add(ctx.executable._rollup.dirname.replace("bazel-out/", "") + "/" + "rollup_bin.sh.runfiles/build_bazel_rules_svelte_deps")
    args_config.add(ctx.bin_dir.path)

    ctx.actions.run(
        executable = ctx.executable._config,
        outputs = [config],
        arguments = [args_config],
    )

    return config
