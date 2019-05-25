const rollup = require("rollup");
const path = require("path");
const input = process.argv[2];
const file = process.argv[3];

class ResolveInternal {
  resolveId(importee) {
    if (importee === "svelte/internal" || importee === "svelte") {
      const newPath = path.join(
        __dirname,
        "../..",
        "build_bazel_rules_svelte_deps/node_modules/svelte/internal.mjs"
      );
      return newPath;
    }
  }
}

async function build() {
  const inputOptions = { input, plugins: [new ResolveInternal()] };
  const outputOptions = {
    file,
    format: "iife",
    name: "svelte_app",
    sourcemap: true
  };
  const bundle = await rollup.rollup(inputOptions);

  await bundle.write(outputOptions);
}

build();
