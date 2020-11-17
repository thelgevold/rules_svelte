load("@build_bazel_rules_nodejs//:providers.bzl", "NpmPackageInfo")

def copy_files(ctx):
    files = []
    entryPoint = []
    
    for svelteFile in ctx.attr._svelte_deps.files.to_list():
        f = ctx.actions.declare_file("build-output/" + svelteFile.path.replace("external/build_bazel_rules_svelte/internal", ""))
        ctx.actions.expand_template(
                output = f,
                template = svelteFile,
                substitutions = {"/internal';": "/internal/index.mjs';"},
            )
        files.append(f)    

    if hasattr(ctx.attr, "closure_config") and not ctx.file.closure_config == None:
        f = ctx.actions.declare_file("build-output/" + ctx.file.closure_config.path)
        ctx.actions.expand_template(
                output = f,
                template = ctx.file.closure_config,
                substitutions = {
                    
                },
        )
        files.append(f)

    for dep in ctx.attr.deps:
        if NpmPackageInfo in dep:
            for npm in dep[NpmPackageInfo].sources.to_list():
                
                if npm.extension == "js" or npm.basename == "package.json":
                    npm_parts = npm.path.split("node_modules", 1)
                
                    f = ctx.actions.declare_file("build-output/node_modules/" + npm_parts[1])
                    ctx.actions.expand_template(
                        output = f,
                        template = npm,
                        substitutions = {},
                    )
                    files.append(f)
        else:
            
            for file in dep.files.to_list():
                f = ctx.actions.declare_file("build-output/src/" + file.path.replace(ctx.bin_dir.path, ""))
                ctx.actions.expand_template(
                    output = f,
                    template = file,
                    substitutions = {},
                )
                if file.path == ctx.file.entry_point.path:
                    entryPoint.append(f)
                else:
                    files.append(f)

    files.extend(entryPoint)
    
    return files

