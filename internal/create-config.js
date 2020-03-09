const fs = require('fs');

const output = process.argv[2];
const hostPath = process.argv[3];

const config = `const resolve = require('@rollup/plugin-node-resolve');
const commonjs = require('@rollup/plugin-commonjs');
const path = require("path");

class ResolveInternal {
  resolveId(importee) {
    let parts = importee.split("/");

    if (parts[0] === "svelte") {

      let subpackage = parts.length == 2 ? parts[1] : "internal";

      return path.join(
        __dirname,
        "../../",
        \`__HOST_PATH__/node_modules/svelte/\${subpackage}/index.mjs\`
      );
    }
  }
}

module.exports = {
  output: {
    format: 'iife',
    sourcemap: true,
    name: 'svelte_app'
  },
  plugins: [new ResolveInternal(), resolve(), commonjs()]
};`;

fs.writeFileSync(output, config.replace('__HOST_PATH__', hostPath), 'utf8');