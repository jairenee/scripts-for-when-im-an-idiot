if has('python3')
endif
let g:syntastic_python_checkers = [ 'flake8' ]
let g:syntastic_sh_checkers = [ 'shellcheck' ]
let b:shell = "bash"
let g:markdown_syntax_conceal = 0

set list
set listchars=tab:>-

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:AutoPairs = {}

map <silent> <leader>nn :NERDTree<cr>
map <silent> <leader>nc :NERDTreeClose<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <silent> <leader>jh :JSHint<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent><leader>od m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><leader>Od m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><leader>oa m`o<Esc>``
nnoremap <silent><leader>Oa m`O<Esc>``

set rnu 
highlight LineNr ctermfg=red

set nofoldenable
set spellfile=~/.vim/spell/en.utf-8.add

set complete=.,w,b,u

set lcs=eol:¬,tab:>-,trail:.,extends:»,precedes:«

set ignorecase
set smartcase

if has('linebreak')
  let &showbreak='⤷ '
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

function! s:list_commits()
    let commits = systemlist('git log --oneline | head -n5')
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "Git show ". matchstr(v:val, "^\\x\\+") }')
endfunction

function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction

let g:startify_lists = [
    \ {'type': 'sessions',                 'header': ['    Sessions'      ]},
    \ {'type': 'dir',                      'header': ['    MRU '. getcwd()]},
    \ {'type': 'files',                    'header': ['    MRU'           ]},
    \ {'type': function('s:list_commits'), 'header': ['    Commits'       ]},
    \ ]

let g:startify_session_before_save = [
    \ 'echo "Cleaning up before saving.."',
    \ 'silent! NERDTreeTabsClose'
    \ ]

let g:startify_custom_header = s:filter_header([
    \ '      ____               ',
    \ '     /___/\_             ',
    \ '    _\   \/_/\__         ',
    \ '  __\       \/_/\        ',
    \ '  \   __    __ \ \       ',
    \ ' __\  \_\   \_\ \ \   __ ',
    \ '/_/\\   __   __  \ \_/_/\',
    \ '\_\/_\__\/\__\/\__\/_\_\/',
    \ '   \_\/_/\       /_\_\/  ',
    \ '      \_\/       \_\/    ',
    \ '                         ',
    \ '    \  /   |   |\  /|    ',
    \ '     \/    |   | \/ |    ',
    \ ])

let g:startify_use_env = 1

color dracula
