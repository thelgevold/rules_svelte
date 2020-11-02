const ClosureCompiler = require('google-closure-compiler').compiler;
const fs = require("fs");
const findUp = require('find-up');

const root = `${process.argv[3]}build-output`;
const javaPath = findUp.sync(process.argv[4]);
const appFolder = process.argv[5];

ClosureCompiler.prototype.javaPath = javaPath;

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

js = config.node_modules.concat(standardDeps).map(m => `${root}/node_modules/${m}`)
js.push(`${root}/src/${appFolder}**.js`);

async function optimize() {
  const closureCompiler = new ClosureCompiler({
    js,
    entry_point: `${root}/src/${appFolder}${config.entry_point}`,

    compilation_level: "ADVANCED",
    language_in: "ECMASCRIPT_2020",
    language_out: "ECMASCRIPT_2015",
    process_common_js_modules: true,
    module_resolution: "node",
    package_json_entry_names: ["es2015,module,jsnext:main"],
    jscomp_off: "checkVars",
    warning_level: "QUIET",
  });

  return new Promise((resolve, reject) => {
    closureCompiler.run((exitCode, stdOut, stdErr) => {
      if (stdErr) {
        console.error(`Exit code: ${exitCode}`, stdErr);
        reject();
      }
      else {
        console.log(`Creating ${process.argv[2]}`);
        fs.writeFileSync(process.argv[2], stdOut);
        resolve();
      }
    });
  });
}

optimize();