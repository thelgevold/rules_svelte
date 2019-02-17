def get_files(ctx):
  files = []
  root = ctx.file.entry_point.path.replace(ctx.file.entry_point.basename, "")

  for dep in ctx.attr.deps:
    for file in dep.files:
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
