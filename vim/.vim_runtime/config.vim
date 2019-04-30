map <silent> <leader>nn :NERDTree<cr>
map <silent> <leader>nc :NERDTreeClose<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


map <silent> <leader>jh :JSHint<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
    \ {'type': 'sessions',               'header': ['    Sessions'      ]},
    \ {'type': 'dir',                    'header': ['    MRU '. getcwd()]},
    \ {'type': 'files',                  'header': ['    MRU'           ]},
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
