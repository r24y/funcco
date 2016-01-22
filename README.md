     _____
    |  ___|   _ _ __   ___ ___ ___
    | |_ | | | | '_ \ / __/ __/ _ \
    |  _|| |_| | | | | (_| (_| (_) |
    |_|   \__,_|_| |_|\___\___\___/

Funcco is a fork of [Docco][1], the quick-and-dirty, hundred-line-long, literate-programming-style
documentation generator. Funcco adds the capability to add Haskell-style type annotations to your code.

## Installation

    sudo npm install -g funcco

## Usage

      funcco [options] FILES

    Options:

      -h, --help             output usage information
      -V, --version          output the version number
      -l, --layout [layout]  choose a built-in layouts (parallel, linear)
      -c, --css [file]       use a custom css file
      -o, --output [path]    use a custom output path
      -t, --template [file]  use a custom .jst template
      -e, --extension [ext]  use the given file extension for all inputs
      -L, --languages [file] use a custom languages.json
      -m, --marked [file]    use custom marked options

  [1]: http://jashkenas.github.com/docco/
