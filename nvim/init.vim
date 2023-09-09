set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:loaded_python_provider = 0
let g:python3_host_prog = '/opt/homebrew/bin/python3'
" Python LSP
lua << EOF
require'lspconfig'.pylsp.setup{}
EOF
source ~/.vimrc
