map <leader>nn :NERDTree<cr>
map <leader>nc :NERDTreeClose<cr>

set number
highlight LineNr ctermfg=red

set nofoldenable
set spellfile=~/.vim/spell/en.utf-8.add

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

