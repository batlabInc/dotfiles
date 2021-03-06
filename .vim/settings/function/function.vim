function! g:IndentWithI()
    if ln( getline('.')) == 0
        return "\"_dd0
    else
        return "i" 
    endif 
endfunction

function! g:SortCss()
    for i in range("1", line("$"))
        exe "/{"
        exe "silent! normal j,S"
    endfor
endfunction 

"function! g:put_in_args( dirname, filetype )
"exec Rooter
"    s:dir_found = finddir( dirname )
"    if s:dir_found
"        let s:result = system( 'shell find . -name "*.js" -type f -print' )
"        execute("argadd"." ". s:result)
"    endif
"endfunction

function! g:DelTagOfFile(file)
    let fullpath = a:file
    let cwd = getcwd()
    let tagfilename = cwd . "/tags"
    let f = substitute(fullpath, cwd . "/", "", "")
    let f = escape(f, './')
    let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
    let resp = system(cmd)
endfunction

function! g:UpdateTags()
    let f = expand("%:p")
    let cwd = getcwd()
    let tagfilename = cwd . "/tags"
    let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
    call DelTagOfFile(f)
    let resp = system(cmd)
endfunction

function! g:CloseEmptyBuffer()
    if winnr('$') == 2 && &bt == 'help'
      let bufnr = tabpagebuflist()[1]
      let modified = getwinvar(2, '&modified')
      if bufname(bufnr) == '' && !modified
        only
      endif
    endif
endfunction

" TODO : for cygwin
let g:is_win = has('win32') || has('win64')
let g:is_mac = has('mac') || system('uname') =~? '^darwin'
let g:is_linux = !g:is_mac && has('unix')
let g:is_gui = has('gui_running') || has('gui_macvim')
let g:is_vim = ( g:is_linux || g:is_mac ) && !g:is_gui && !has('nvim')
let g:is_nvim = ( g:is_linux || g:is_mac ) && has('nvim') 
let g:plugin_manager_installed = filereadable(expand('~/.vim/plug'))

