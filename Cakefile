{spawn, exec} = require 'child_process'
fs            = require 'fs'
path          = require 'path'

option '-p', '--prefix [DIR]', 'set the installation prefix for `cake install`'
option '-w', '--watch', 'continually build the funcco library'
option '-l', '--layout [LAYOUT]', 'specify the layout for Funcco\'s docs'

task 'build', 'build the funcco library', (options) ->
  coffee = spawn 'coffee', ['-c' + (if options.watch then 'w' else ''), '.']
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
  coffee.stderr.on 'data', (data) -> console.log data.toString().trim()

task 'install', 'install the `funcco` command into /usr/local (or --prefix)', (options) ->
  base = options.prefix or '/usr/local'
  lib  = base + '/lib/funcco'
  exec([
    'mkdir -p ' + lib + ' ' + base + '/bin'
    'cp -rf bin README resources ' + lib
    'ln -sf ' + lib + '/bin/funcco ' + base + '/bin/funcco'
  ].join(' && '), (err, stdout, stderr) ->
   if err then console.error stderr
  )

task 'doc', 'rebuild the Funcco documentation', (options) ->
  layout = options.layout or 'linear'
  exec([
    "bin/funcco --layout #{layout} funcco.litcoffee"
    "sed \"s/docco.css/resources\\/#{layout}\\/docco.css/\" < docs/funcco.html > index.html"
    'rm -r docs'
  ].join(' && '), (err) ->
    throw err if err
  )

task 'loc', 'count the lines of code in Funcco', ->
  code = fs.readFileSync('funcco.litcoffee').toString()
  lines = code.split('\n').filter (line) -> /^    /.test line
  console.log "Funcco LOC: #{lines.length}"
