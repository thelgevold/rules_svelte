"Implementation of bundle_prod rule."

load("//internal:get-files.bzl", "get_files")
load("//internal:get-config.bzl", "get_config")

def _bundle_prod(ctx):
    files = get_files(ctx)

    config = get_config(ctx)
    files.append(config)

    args = ctx.actions.args()
    args.add_all(["--config", config.path])
    args.add_all(["--input", ctx.bin_dir.path + "/" + ctx.file.entry_point.path])
    args.add_all(["--file", ctx.outputs.build_es6.path])

    ctx.actions.run(
        executable = ctx.executable._rollup,
        inputs = files,
        outputs = [ctx.outputs.build_es6],
        arguments = [args],
    )

    args_ts = ["--target", "es5"]
    args_ts.append("--allowJS")
    args_ts.append(ctx.outputs.build_es6.path)
    args_ts += ["--outFile", ctx.outputs.build_es5.path]

    ctx.actions.run(
        executable = ctx.executable._typescript,
        inputs = [ctx.outputs.build_es6],
        outputs = [ctx.outputs.build_es5],
        arguments = args_ts,
    )

    args_uglify = [ctx.outputs.build_es5.path]
    args_uglify += ["--output", ctx.outputs.build_es5_min.path]

    ctx.actions.run(
        executable = ctx.executable._uglify,
        inputs = [ctx.outputs.build_es5],
        outputs = [ctx.outputs.build_es5_min],
        arguments = args_uglify,
    )

bundle_prod = rule(
    implementation = _bundle_prod,
    attrs = {
        "deps": attr.label_list(),
        "entry_point": attr.label(allow_single_file = True),
        "_typescript": attr.label(executable = True, cfg = "host", default = Label("//internal:typescript")),
        "_rollup": attr.label(executable = True, cfg = "host", default = Label("//internal:rollup_bin")),
        "_uglify": attr.label(executable = True, cfg = "host", default = Label("//internal:uglify")),
        "_config": attr.label(
            executable = True,
            cfg = "host",
            default = Label("//internal:create_config"),
        ),
    },
    outputs = {"build_es6": "%{name}.es6.js", "build_es5": "%{name}.es5.js", "build_es5_min": "%{name}.es5.min.js"},
)
