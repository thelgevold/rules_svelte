load("@build_bazel_rules_nodejs//:providers.bzl", "NpmPackageInfo")

def get_files(ctx):
  files = []
  root = ctx.file.entry_point.path.replace(ctx.file.entry_point.basename, "")
  for dep in ctx.attr.deps:
    if NpmPackageInfo in dep:
      for npm in dep[NpmPackageInfo].sources.to_list():
        npmParts = npm.path.split("node_modules");
        f = ctx.actions.declare_file("node_modules/" + npmParts[1])
        ctx.actions.expand_template(
          output = f,
          template =  npm,
          substitutions = {}
        )
        files.append(f)
    else: 
      for file in dep.files.to_list():
        if(file.is_source == False):
          if(file.path.endswith(".css")):
            css = ctx.actions.declare_file(ctx.outputs.css.basename)
            ctx.actions.expand_template(
              output = ctx.outputs.css,
              template =  file,
              substitutions = {}
            )
            files.append(css)
          else:
            files.append(file)
        if(file.is_source):
          f = ctx.actions.declare_file(file.path.replace(root, ""))
          ctx.actions.expand_template(
            output = f,
            template =  file,
            substitutions = {}
          )
          files.append(f)
  return files
