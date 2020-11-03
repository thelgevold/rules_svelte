"Implementation of bundle_prod rule."

load("//internal:get-files.bzl", "copy_files")
load("//internal:get-config.bzl", "get_config")

def _bundle_prod(ctx):
    if not ctx.file.closure_config == None:
        rootFolder = ctx.file.entry_point.path.replace(ctx.file.entry_point.basename, "")

        argsClosure = [ctx.outputs.bundle.path]
        argsClosure.append(ctx.bin_dir.path + "/" + rootFolder)
        argsClosure.append(ctx.attr._java[java_common.JavaRuntimeInfo].java_executable_exec_path)
        argsClosure.append(rootFolder)
        
        closure_files = copy_files(ctx)
    
        ctx.actions.run(
            executable = ctx.executable._closure,
            inputs = closure_files,
            outputs = [ctx.outputs.bundle],
            arguments = argsClosure,
        )
    else:    
        files = copy_files(ctx)

        config = get_config(ctx)
        files.append(config)

        bundle = ctx.actions.declare_file("temp.js")

        args = ctx.actions.args()
        args.add_all(["--config", config.path])
        print(ctx.build_file_path)
        args.add_all(["--input", ctx.bin_dir.path + "/" + ctx.build_file_path.replace("BUILD.bazel", "") + "/build-output/src/" + ctx.file.entry_point.path])
        args.add_all(["--file", bundle])

        ctx.actions.run(
            executable = ctx.executable._rollup,
            inputs = files,
            outputs = [bundle],
            arguments = [args],
        )

        args_terser = [bundle.path]
        args_terser += ["--output", ctx.outputs.bundle.path]

        ctx.actions.run(
            executable = ctx.executable._terser,
            inputs = [bundle],
            outputs = [ctx.outputs.bundle],
            arguments = args_terser,
        )


bundle_prod = rule(
    implementation = _bundle_prod,
    attrs = {
        "deps": attr.label_list(),
        "entry_point": attr.label(allow_single_file = True),
        "closure_config": attr.label(allow_single_file = True),
        "_java": attr.label(executable = False, allow_files = True, default = Label("@bazel_tools//tools/jdk:current_java_runtime")), 
        "_svelte_deps": attr.label(executable = False, allow_files = True, default = Label("//internal:svelte_deps")),
        "_rollup": attr.label(executable = True, cfg = "host", default = Label("//internal:rollup_bin")),
        "_closure": attr.label(executable = True, cfg = "host", default = Label("//internal:closure_bin")),
        "_terser": attr.label(executable = True, cfg = "host", default = Label("//internal:terser")),
        "_config": attr.label(
            executable = True,
            cfg = "host",
            default = Label("//internal:create_config"),
        )
      
    },
    
    outputs = {"bundle": "%{name}.min.js"},
)
