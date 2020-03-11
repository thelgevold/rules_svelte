const fs = require('fs');

const output = process.argv[2];
const hostPath = process.argv[3];
const bin = process.argv[4];

const config = `const resolve = require('@rollup/plugin-node-resolve');
const commonjs = require('@rollup/plugin-commonjs');
const path = require("path");

class ResolveInternal {
  resolveId(importee) {
    let parts = importee.split("/");

    if (parts[0] === "svelte") {

      let subpackage = parts.length == 2 ? parts[1] : "internal";
      
      let hostPath = \`${hostPath}\`;
      let bin = \`${bin}\`;
    
      var p = __dirname.split(bin)[0] + '/bazel-out/' + '__HOST_PATH__';

      return path.join(
        p,
        \`node_modules/svelte/\${subpackage}/index.mjs\`
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