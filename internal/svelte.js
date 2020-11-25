const fs = require("fs");
const worker = require('@bazel/worker');
const svelte = require("svelte/compiler");

async function compileSvelte(args) {
  const input = args[0]
  const outputJs = args[1]

  const source = await readFile(input);
  const result = svelte.compile(source, {
    format: "esm",
    generate: "dom",
    filename: outputJs
  });

  await writeFile(outputJs, result.js.code);

  return true;
}

function writeFile(file, data) {
  return new Promise((resolve, reject) => {
    fs.writeFile(file, data, (err) => {
      if (err) {
        reject(err);
        return
      }
      resolve();
    });
  });
}

function readFile(file) {
  return new Promise((resolve, reject) => {
    fs.readFile(file, 'utf8' , (err, data) => {
      if (err) {
        reject(err);
        return
      } 
      resolve(data);
    });
  });
}

function main(args) {
  if (worker.runAsWorker(process.argv)) {
    worker.log('Svelte running as a Bazel worker');
    worker.runWorkerLoop(compileSvelte);
  }
  else {
    const paramFile = process.argv[2].replace(/^@/, '');
    const commandLineArgs = require('fs').readFileSync(paramFile, 'utf-8').trim().split('\n');
    console.log('Svelte running as a standalone process');
    compileSvelte(commandLineArgs);
  }
}

if (require.main === module) {
  main(process.argv.slice(2));
  process.exitCode = 0;
}