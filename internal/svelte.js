const fs = require("fs");

const outputJs = process.argv[3];
const input = process.argv[2];

const svelte = require("svelte/compiler");

const source = fs.readFileSync(input, "utf8");
const result = svelte.compile(source, {
  format: "esm",
  generate: "dom",
  filename: outputJs
});

fs.writeFileSync(outputJs, result.js.code);
