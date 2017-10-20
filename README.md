# vim
This repository contains my `~/.vimrc` file for Vim running on my Linux machines. The [`mock`](https://github.com/fusion809/vim/tree/mock) branch also contains packaging files for building a Vim RPM package for Fedora.

To set this up quickly run:

```bash
/bin/bash -c "$(wget -cqO- https://git.io/vS5Ng)"
```

or:

```bash
/bin/bash -c "$(curl -sL https://git.io/vS5Ng)"
```

Several plugins I have deleted as they simply did not work or they slowed it down too much or they weren't used enough to justify keeping them. They include (listed in Vim script format with the Vundle plugin manager to simplify adding them, should the need arise):

```vim
""" git manager
Plugin 'tpope/vim-fugitive'
""" Commit browser
Plugin 'junegunn/gv.vim'
" YouCompleteMe auto-complete
Plugin 'Valloric/YouCompleteMe'
""" Markdown Preview
Plugin 'JamshedVesuna/vim-markdown-preview'
""" Vala syntax-highlighting plugin, seemingly unmaintained since 7 Sep 2012
Plugin 'tkztmk/vim-vala'
"" Gnuplot
Plugin 'mdlerch/vim-gnuplot'
""" Python linting, syntax-highlighting, code-completion, go-to-definition, etc.
Plugin 'klen/python-mode'
""" CoffeeScript mode
Plugin 'kchmck/vim-coffee-script'
" Julia support
Plugin 'JuliaEditorSupport/julia-vim'
" Go support
Plugin 'fatih/vim-go'
" TOML support -- useful for Hugo
Plugin 'cespare/vim-toml'
" PyMOL support
Plugin 'PyMol-syntax'
" Linter support
Plugin 'vim-syntastic/syntastic'
" tabulous, add tabs to Vim -- doesn't seem to work, no tabs are shown.
Plugin 'webdevel/tabulous'
let loadTabulous = 0
let tabulousLabelLeftStr = ' '
```

