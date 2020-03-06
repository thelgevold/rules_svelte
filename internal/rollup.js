const rollup = require("rollup");
const path = require("path");
const input = process.argv[2];
const file = process.argv[3];
const binFolder = process.argv[4];

const resolve = require('@rollup/plugin-node-resolve');
const commonjs = require('@rollup/plugin-commonjs');

class ResolveInternal {
  resolveId(importee) {
    let parts = importee.split("/");

    if (parts[0] === "svelte") {

      let subpackage = parts.length == 2 ? parts[1] : "internal";

      return path.join(
        __dirname,
        "../..",
        `build_bazel_rules_svelte_deps/node_modules/svelte/${subpackage}/index.mjs`
      );
    }

    if (parts.indexOf('node_modules') > -1) {
      let base = path.join(
        __dirname,
        '../../../../../../../../../'  //TODO Fix this path
      ) + binFolder;

      let node_parts = importee.split("/node_modules")
      return base + 'node_modules/' + node_parts[1];
    }
  }
}

async function build() {
  const inputOptions = { input, plugins: [new ResolveInternal(), resolve(), commonjs()] };
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
