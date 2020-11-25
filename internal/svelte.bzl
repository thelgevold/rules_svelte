"Implementation of the svelte rule"
load("@build_bazel_rules_nodejs//:providers.bzl", "run_node")
SvelteFilesInfo = provider("transitive_sources")

def get_transitive_srcs(srcs, deps):
    return depset(
        srcs,
        transitive = [dep[SvelteFilesInfo].transitive_sources for dep in deps],
    )

def _svelte(ctx):
    args = ctx.actions.args()

    args.use_param_file("@%s", use_always = True)
    args.set_param_file_format("multiline")
    
    args.add(ctx.file.entry_point.path)
    args.add(ctx.outputs.build.path)

    run_node(
        ctx,
        execution_requirements = {"supports-workers": "1"},
        executable = "_svelte_bin",
        outputs = [ctx.outputs.build],
        inputs = [ctx.file.entry_point],
        mnemonic = "SvelteCompile",
        arguments = [args],
    )

    trans_srcs = get_transitive_srcs(ctx.files.srcs + [ctx.outputs.build], ctx.attr.deps)

    return [
        SvelteFilesInfo(transitive_sources = trans_srcs),
        DefaultInfo(files = trans_srcs),
    ]

svelte = rule(
    implementation = _svelte,
    attrs = {
        "entry_point": attr.label(allow_single_file = True),
        "deps": attr.label_list(),
        "srcs": attr.label_list(allow_files = True),
        "_svelte_bin": attr.label(
            default = Label("//internal:svelte_bin"),
            executable = True,
            cfg = "host",
        ),
    },
    outputs = {
        "build": "%{name}.svelte.js",
    },
)
