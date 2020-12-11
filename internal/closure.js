const ClosureCompiler = require('google-closure-compiler').compiler;
const fs = require("fs");
const findUp = require('find-up');

const root = `${process.argv[3]}build-output`;
const javaPath = findUp.sync(process.argv[4]);
const appFolder = process.argv[5];

ClosureCompiler.prototype.javaPath = javaPath;

const bundleOutputFolder = process.argv[2];

let standardDeps = [
  `svelte/package.json`,
  `svelte/index.mjs`,
  'svelte/internal/package.json',
  'svelte/internal/index.mjs',
  'svelte/store/package.json',
  'svelte/store/index.mjs',
  'svelte/transition/package.json',
  'svelte/transition/index.mjs',
  'svelte/easing/package.json',
  'svelte/easing/index.mjs'
]; 

var config = JSON.parse(fs.readFileSync(`${root}/${appFolder}closure-config.json`, 'utf8'));

let closureConfig = {
  compilation_level: "ADVANCED",
  language_in: "ECMASCRIPT_2020",
  language_out: "ECMASCRIPT_2015",
  process_common_js_modules: true,
  module_resolution: "node",
  package_json_entry_names: ["es2015,module,jsnext:main"],
  jscomp_off: "checkVars",
  warning_level: "QUIET",
  chunk_output_path_prefix: `${bundleOutputFolder}/`
};

if(config.entry_point) {
  let js = config.node_modules.concat(standardDeps).map(m => `${root}/node_modules/${m}`)
  js.push(`${root}/src/${appFolder}**.js`);
  closureConfig = {...closureConfig, js, entry_point: `${root}/src/${appFolder}${config.entry_point}`, js_output_file: `${bundleOutputFolder}/bundle.min.js`};
}

if(config.chunks) {
  let js = config['dependency-ordered-js'].map(m => {
    if(m.indexOf('node_modules') === -1) {
      return `${root}/src/${m}`;
    }
    return `${root}/${m}`;
  });
  closureConfig = {...closureConfig, js, chunk: config.chunks}
}

async function optimize(closureFlags) {
  return new Promise((resolve, reject) => {
    const closureCompiler = new ClosureCompiler(closureFlags);
    
    closureCompiler.run((exitCode, stdOut, stdErr) => {
      if (stdErr) {
        console.error(`Exit code: ${exitCode}`, stdErr);
        reject();
      }
      else {
        resolve();
      }
    });
  });
}

optimize(closureConfig);