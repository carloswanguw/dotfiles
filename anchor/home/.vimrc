" URL: https://github.com/carloswanguw/dotfiles
" Authors: Carlos
" Description: carloswanguw dotfile (.vimrc)
"------------------------------------------------------------

" function! StarterConfigs()
    set nocompatible             " ignore compatibility with vi (for vim)

    " remap leader
    let mapleader=","
    " Switch on syntax highlighting (font/color settings)
    if !exists("g:syntax_on")    
        syntax enable
    endif

" endfunction 

" function! Vundle()
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    
    """ Required Settings
    filetype off		                " Ignore auto-detection of filetypes
    set rtp+=~/.vim/bundle/Vundle.vim       " Set runtime path for Vundle
    call vundle#begin('$HOME/.vim/bundle')  " Begin Vundle (with path to install plugins)
    Plugin 'VundleVim/Vundle.vim'	        " Let Vundle manage Vundle
    
    " Plugins
    "" Other Settings and Remappings
    Plugin 'tpope/vim-sensible'               " Convenient settings for vim
    Plugin 'tpope/vim-unimpaired'             " Some remappings for Syntastic and other plugins (([,])+l)
    "" Editor Specific
    Plugin 'scrooloose/nerdtree'              " Treestyle file manager
    Plugin 'vim-airline/vim-airline'          " Status bar tracker/updater
    "" Syntax Highlighting
    Plugin 'scrooloose/syntastic'             " Linter for vim
    Plugin 'octol/vim-cpp-enhanced-highlight' " Enhanced syntax highlighting for .cpp files
    "" Code highlighting
    Plugin 'terryma/vim-multiple-cursors'     " Sublime-like multicursor (<Ctl>+(n,p,x))
    Plugin 'tpope/vim-surround'               " Surround entities (S+<char>)
    Plugin 'easymotion/vim-easymotion'        " Easy cursor motion (<leader><leader> (w,b), etc.)
    Plugin 'nathanaelkane/vim-indent-guides'  " Indent guides (<leader> i+g)
    "" Code manipulation
    Plugin 'junegunn/vim-easy-align'          " Justifies text (g+a+(visual select, operator, etc))
    Plugin 'FooSoft/vim-argwrap'	      " Argument wrapper (<leader>a)
    "" Code addition 
    Plugin 'Shougo/neocomplete.vim'           " Auto code completer (tab completion)
    Plugin 'honza/vim-snippets'               " Extra snippets to use
    Plugin 'aperezdc/vim-template'            " Simple file template inserter
    "" Code statistics
    Plugin 'majutsushi/tagbar'                " CTags listing
    "" File plugins
    Plugin 'tpope/vim-fugitive'	              " Github plugin (Gstatus, Gcommit, Gremove, etc.)
    Plugin 'ctrlpvim/ctrlp.vim'               " Fuzzile file/folder finder (<Ctl>+(p,j,k,v,x))
    "" Commenting
    Plugin 'scrooloose/nerdcommenter'         " Auto commenter (<leader>+c+(n,space,m,i,s,y,$,A))
    Plugin 'vim-scripts/DoxygenToolkit.vim'   " Doxygen (:Dox for cmds, <leader>c+d)
    Plugin 'vim-scripts/DoxyGen-Syntax'       " Doxygen syntax highlighting
    "" Wiki
    Plugin 'vimwiki/vimwiki'                  " Wiki for vim (<leader>w+s for wiki index)
    Plugin 'mattn/calendar-vim'               " Calendar to augment vim-wiki
    "Plugin 'tpope/vim-speeddating'            " Increment/Decrement time/date to wiki date (<Ctl>a, <Ctl>x)
    "Plugin 'blindFS/vim-taskwarrior'          " Taskwarrior integration to vim (requires taskwarrior install)
    "Plugin 'Shougo/unite.vim'                 " Easier bookmark and history ops for taskwarrior
    "" TMUX specific
    Plugin 'christoomey/vim-tmux-navigator'   " TMUX windows nav plugin
    "" CLang
    Plugin 'kana/vim-operator-user'	      " Required for CLang Format
    Plugin 'Shougo/vimproc.vim'               " Required for CLang Format
    Plugin 'rhysd/vim-clang-format'           " CLang formatter
    "" Colorschemes
    Plugin 'morhetz/gruvbox'                  " Colorscheme: Gruvbox
    
    " Cleanup
    call vundle#end()                         " End Vundle
    filetype indent plugin on                 " Re-enable filetype auto-detection
" endfunction

" function! ConfigColorScheme()
    " Gruvbox
    set background=dark
    let g:gruvbox_contrast_dark="hard"
    colorscheme gruvbox
" endfunction

" function! RecommendedSettings()

    " High level operation and display
    set hidden            " Keeps buffers hidden instead of closing them, useful for undos and file edits
    set wildmenu          " Better command-line completion
    set showcmd           " Show partial commands in the last line of the screen
    set hlsearch          " Highlight searches (use <Ctl-L> or another mapping to turn off)
    set showmatch         " Highlight matching paranthesis-like chars when cusor is over them
    set cursorline        " Draw horizontal (sometimes underline) highlight for current pos of cursor

    " Indentation settings
    set shiftwidth=4      " 4 characters indented with >> or <<
    set softtabstop=4     " Tabs (in insert mode) separated by 4 column spaces
    set expandtab         " Expand all tabs to spaces instead
    
    " Usability Convenience
    set ignorecase                 " Ignore case when searching (unless all caps are used)
    set smartcase                  " Unless all caps are used
    set backspace=indent,eol,start " Allow backspace over autoindents, line breaks, and inserts
    set autoindent                 " Keep the same indent as the previous line, unless file-specific settings override them
    set nostartofline              " Stop certain movements from going to the first char of a line
    set textwidth=80               " Set text width (for wrapping)
    set ruler                      " Display cursor position on the status line
    set laststatus=2               " Always display the status line even if one window is displayed
    set confirm                    " Raise dialog to save changed files prior to applying certain commands
    set visualbell                 " Use visual bell instead of beeping when doing something wrong
    set t_vb=                      " Unset the visual bell terminal code
    set mouse=a                    " Enable use of mouse for all modes
    set cmdheight=2                " Set command window height (2 lines to avoid 'Press <Enter> to continue')
    set number                     " Display line numbers (on the left)
    set relativenumber             " Display line numbers relative to cursor line position
    set notimeout ttimeout ttimeoutlen=200  " Quickly time out on keycodes, but never time out on mappings
    set pastetoggle=<F11>          " Use <F11> to toggle between 'paste' and 'nopaste'
    set guitablabel=\[%N\]\ %t\ \[%M\] " Setup label format for tabs ([num windows] filename [is file modified])

    " disable autocommenting for all files
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    
    " 80 character limit highlight
    hi ColorColumn ctermbg=235 guibg=#2c2d27         " Set color highlights
    let &colorcolumn="80,".join(range(100,999),",")  " Set the highlights at 80+ and 100+ chars
" endfunction

" function! ConfigSpellChecker()
    if has("spell")
        set spelllang=en_us        " Set language
        " Toggle spelling with <F5> key
        map <F5> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
        " Highlight the spelling checks
        highlight PmenuSel ctermfg=black ctermbg=lightgray
        " Limit the spelling suggestions to the top 10 only
        set sps=best,10
    endif
" endfunction

" function! ConfigTMUXforVim()
    "TMUX compatibility with Vim
    if &term =~ '^screen' && exists('$TMUX')
        " TMUX knows the extended mouse mode
        set mouse+=a 
        set ttymouse=xterm2
        " TMUX will send xterm-style keys when xterm-keys is on
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
        execute "set <xHome>=\e[1;*H"
        execute "set <xEnd>=\e[1;*F"
        execute "set <Insert>=\e[2;*~"
        execute "set <Delete>=\e[3;*~"
        execute "set <PageUp>=\e[5;*~"
        execute "set <PageDown>=\e[6;*~"
        execute "set <xF1>=\e[1;*P"
        execute "set <xF2>=\e[1;*Q"
        execute "set <xF3>=\e[1;*R"
        execute "set <xF4>=\e[1;*S"
        execute "set <F5>=\e[15;*~"
        execute "set <F6>=\e[17;*~"
        execute "set <F7>=\e[18;*~"
        execute "set <F8>=\e[19;*~"
        execute "set <F9>=\e[20;*~"
        execute "set <F10>=\e[21;*~"
        execute "set <F11>=\e[23;*~"
        execute "set <F12>=\e[24;*~"
    endif
" endfunction

" function! ConfigPluginSyntastic()
    " [buffer number] followed by filename:
    set statusline=[%n]\ %t
    " status line settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    " show line#:column# on the right hand side
    set statusline+=%=%l:%c
    
    let g:syntastic_always_populate_loc_list = 1
    " auto load location list
    let g:syntastic_auto_loc_list = 0
    " check errors when opening file
    let g:syntastic_check_on_open = 1
    " check when saving
    let g:syntastic_check_on_wq = 0
    
    " for cpplint.py which is installed using pip (python-pip)
    let g:syntastic_cpp_cpplint_exec = 'cpplint'
    
    " using multiple checkers for cpp
    let g:syntastic_cpp_checkers=['gcc','cpplint']
" endfunction

" function! ConfigPluginNERDTree()
    " start up NERDtree every time vim loads
    autocmd VimEnter * NERDTree
    " Go to previous (last accessed) window. (this will focus away from the
    " NERDtree window that was just opened from the above line)
    autocmd VimEnter * wincmd p
    
    " maps <ctrl n> to toggle nerd tree
    map <F7> :NERDTreeToggle<CR>
    
    " if NERDtree is the last window open, close vim
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    
    " Remaps vertical and horizontal splits to match the rest of the vim / tmux
    let NERDTreeMapOpenSplit='<C-x>'
    let NERDTreeMapOpenVSplit='<C-v>'

" endfunction

" function! ConfigPluginCtrlP()
    " change the default mapping and the default command to invoke ctrlp
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    
    " When invoked without an explicit starting directory, CtrlP will set its
    " local working directory according to this variable
    let g:ctrlp_working_path_mode = 'ra'
    
    " Exclude files and directories using Vim's wildignore and CtrlP's own
    " g:ctrlp_custom_ignore. If a custom listing command is being used, exclusions
    " are ignored:
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    
    " ignore files in .gitignore
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" endfunction

" function! ConfigKeyMappings()
    " Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
    " which is the default
    map Y y$
    
    " remap the redraw screen command (<C L>) to <Tab> and also turn off search
    " highlighting until the next search (this remap will help with the split
    " window config)
    nnoremap <Tab> :nohl<CR>:redraw<CR>
    
    " remaps <C i> and <C o> to allow for jump lists to work
    " (once the <Tab> was remapped, <C i> no longer works properly).
    nnoremap g, <C-o>
    nnoremap g. <C-i>
    
    " Remaps double 'o' and 'O' to insert new line below and above without being
    " in insert mode, respectively
    nmap oo o<ESC>k
    nmap OO O<ESC>j
    
    " highlight last inserted text
    nnoremap gV `[v`]l
    
    
    " tab manipulation
    nnoremap <leader>tn :tabnew<CR>
    nnoremap <leader>tc :tabclose<CR>
    
    " switch to previous tab
    nnoremap <C-Left> :tabprevious<CR>
    " switch to next tab
    nnoremap <C-Right> :tabnext<CR>
    " move current tab to left
    nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    " move current tab to right
    nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
    
    " remaps the * key to also put the cursor back to the same point in the text
    nnoremap * *<C-o>
    
    " search and replace remappings
    nnoremap gs :%s/
    vnoremap gs :s/\%V
    
    " search and replace advanced remappings
    " (within the current buffer, with an option of confirming)
    nnoremap <Leader><Leader>rr *:%s/<C-r>///g<Left><Left>
    vnoremap <Leader><Leader>rr "vy/<C-r>v<CR>:%s/<C-r>///g<Left><Left>
    nnoremap <Leader><Leader>rc *:%s/<C-r>///gc<Left><Left><Left>
    vnoremap <Leader><Leader>rc "vy/<C-r>v<CR>:%s/<C-r>///gc<Left><Left><Left>
    " (within all windows, with an option of confirming)
    nnoremap <Leader>.rr *:windo %s/<C-r>///g<Left><Left>
    vnoremap <Leader>.rr "vy/<C-r>v<CR>:windo %s/<C-r>///g<Left><Left>
    nnoremap <Leader>.rc *:windo %s/<C-r>///gc<Left><Left><Left>
    vnoremap <Leader>.rc "vy/<C-r>v<CR>:windo %s/<C-r>///gc<Left><Left><Left>
    
    " highlighting trailing whitespaces
    " trailing after text
    nnoremap <Leader><Leader>s$ /\S\s\+$<CR><C-o>
    " remove trailing whitespaces
    " trailing after text
    nnoremap <Leader><Leader>sd$ :%s/\s\+$//<CR>
    " remove all except 1 space between words
    nnoremap <Leader><Leader>sdw V:s/\s\+/ /g \| nohl<CR>
    vnoremap <Leader><Leader>sdw :s/\%V\s\+/ /g \| nohl<CR>
    
    " Inserting date/time
    " number dash format
    nnoremap <leader>ddt :r! date +"\%Y-\%m-\%d \%I:\%M:\%S \%P"<cr>
    nnoremap <leader>ddo :r! date +"\%Y-\%m-\%d"<cr>
    nnoremap <leader>dto :r! date +"\%I:\%M:\%S \%P"<cr>
    " named format
    nnoremap <leader>dnt :r! date +"\%a, \%b \%d \%Y \%I:\%M:\%S \%P"<cr>
    nnoremap <leader>dno :r! date +"\%a, \%b \%d \%Y"<cr>
    
    " Inserting file name
    " tail and full path
    nnoremap <leader>ftr :r! echo %:t:r<cr>
    nnoremap <leader>fpt :r! echo %:p:t<cr>
    nnoremap <leader>fpo :r! echo %:p<cr>
    
    " override <C-a> to do nothing for tmux compatibility
    autocmd VimEnter * nmap <C-A> <Nop>
    autocmd VimEnter * xmap <C-A> <Nop>
    autocmd VimEnter * imap <C-A> <Nop>
    
    set clipboard=unnamed
    
    " Open new split panes to right and bottom, which feels more natural
    set splitbelow
    set splitright
    " Change splits to be v = vertical, h = horizontal
    nnoremap <C-w>x <C-w>s
    " Quicker window movement
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-h> <C-w>h
    nnoremap <C-l> <C-w>l
    " Maps Shift-arrow keys to resizing a window split
    nnoremap <S-Up> <C-w>+
    nnoremap <S-Down> <C-W>-
    nnoremap <S-Left> <C-W><
    nnoremap <S-Right> <C-W>>
    " "" side notes, extra useful commands to remember
    " " max out the height of the current split
    " ctrl + w _
    " " max out the width of the current split
    " ctrl + w |
    " " normalize all split sizes, which is very handy when resizing terminal
    " ctrl + w =
    " " swap top/bottom or left/right split
    " Ctrl+W R
" endfunction

" function! ConfigPluginNERDCommenter()
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
" endfunction

" function! ConfigPluginNeoComplete()
    " Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }
    
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
    
    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1
    
    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
    
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    
    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" endfunction

" function! ConfigPluginEasyAlign()
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
    
    " extra delimiter rules
    let g:easy_align_delimiters = {
                \ '>': { 'pattern': '>>\|=>\|>' },
                \ '/': {
                \     'pattern':         '//\+\|/\*\|\*/',
                \     'delimiter_align': 'l',
                \     'ignore_groups':   ['!Comment'] },
                \ ']': {
                \     'pattern':       '[[\]]',
                \     'left_margin':   0,
                \     'right_margin':  0,
                \     'stick_to_left': 0
                \   },
                \ ')': {
                \     'pattern':       '[()]',
                \     'left_margin':   0,
                \     'right_margin':  0,
                \     'stick_to_left': 0
                \   },
                \ 'd': {
                \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
                \     'left_margin':  0,
                \     'right_margin': 0
                \   }
                \ }
" endfunction

" function! ConfigPluginArgWrap()
    nnoremap <silent> <leader>a :ArgWrap<CR>
    " ensures that the closing brace is tied to the last variable
    let g:argwrap_wrap_closing_brace = 0
" endfunction

" function! ConfigPluginIndentGuides()
    " set guide size = 1 space, only works on space tabs
    let g:indent_guides_guide_size = 1
" endfunction

" function! ConfigPluginEasyMotion()
    " Move to word (over different windows)
    " map  <Leader>.w <Plug>(easymotion-bd-w)
    nmap <Leader>.w <Plug>(easymotion-overwin-w)
    " Move to line
    " map <Leader>.L <Plug>(easymotion-bd-jk)
    nmap <Leader>.L <Plug>(easymotion-overwin-line)
" endfunction

" function! ConfigPluginTagBar()
    nmap <F8> :TagbarToggle<CR>
    " show line numbers in tagbar (1 = abs, 2 = relative)
    let g:tagbar_show_linenumbers = 1
" endfunction

" function! ConfigPluginCLangFormat()
    " use the current clang format (by setting the command to match what is installed)
    let g:clang_format#command = 'clang-format-3.8'
    
    " use google style for now
    let g:clang_format#code_style = 'google'
    
    " " example settings
    " let g:clang_format#style_options = {
    "             \ "AccessModifierOffset" : -4,
    "             \ "AllowShortIfStatementsOnASingleLine" : "true",
    "             \ "AlwaysBreakTemplateDeclarations" : "true",
    "             \ "Standard" : "C++11"}
    
    " map to <Leader>cf in C++ code
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
    " if you install vim-operator-use
    autocmd FileType c,cpp,objc map <buffer><Leader>cx <Plug>(operator-clang-format)
    " Toggle auto formatting:
    nmap </Leader>CF :ClangFormatAutoToggle<CR>
" endfunction

function! ToggleCalendar()
    execute ":Calendar"
    if exists("g:calendar_open")
        if g:calendar_open == 1
            execute "q"
            unlet g:calendar_open
            set relativenumber
        else
            g:calendar_open = 1
            set norelativenumber
            execute "normal 0"
        end
    else
        let g:calendar_open = 1
        set norelativenumber
        execute "normal 0"
    end
endfunction

" function! ConfigPluginVimWiki()
    " vimwiki stuff "
    " Run multiple wikis "
    let g:vimwiki_list = [
                \{'path': '~/vimwiki/personal'},
                \{'path': '~/vimwiki/task_list'},
                \{'path': '~/vimwiki/quick_notes'},
                \{'path': '~/vimwiki/knowledge_base'},
                \{'path': '~/vimwiki/misc_info'}
                \]
    au BufRead,BufNewFile *.wiki set filetype=vimwiki
    autocmd FileType vimwiki map <leader><leader>d :VimwikiMakeDiaryNote<CR>
    autocmd FileType vimwiki map <leader><leader>c :call ToggleCalendar()<CR>
    nmap <Leader>wx <Plug>VimwikiSplitLink
    nmap <Leader>wv <Plug>VimwikiVSplitLink
    
    " Add folding for vimwiki
    let g:vimwiki_folding = 'expr'
    set foldlevelstart=20 " make sure we have everything unfolded initially
" endfunction

" function! ConfigPluginSpeedDating()
    " use <c-b> instead to do increment speed dating
    xmap <C-B> <Plug>SpeedDatingUp
    nmap <C-B> <Plug>SpeedDatingUp
" endfunction

" " function! ConfigPluginTaskWarrior()
"     " " if experiencing line-wrapping issues, uncomment
"     " let g:task_rc_override = 'rc.defaultwidth=0'
"
"     " " if experiencing task truncation, uncomment
"     " let g:task_rc_override = 'rc.defaultheight=0'
"
"     " default command to start up vim-taskwarrior
"     nmap ,tw :TW<cr>
"     " default task report type
"     let g:task_report_name     = 'next'
"     " custom reports have to be listed explicitly to make them available
"     let g:task_report_command  = []
"     " whether the field under the cursor is highlighted
"     let g:task_highlight_field = 1
"     " can not make change to task data when set to 1
"     let g:task_readonly        = 0
"     " vim built-in term for task undo in gvim
"     let g:task_gui_term        = 1
"     " allows user to override task configurations. Seperated by space. Defaults to ''
"     let g:task_rc_override     = 'rc.defaultwidth=999'
"     " default fields to ask when adding a new task
"     let g:task_default_prompt  = ['tag', 'project', 'description', 'priority', 'due', 'depends']
"     " whether the info window is splited vertically
"     let g:task_info_vsplit     = 0
"     " info window size
"     let g:task_info_size       = 15
"     " info window position
"     let g:task_info_position   = 'belowright'
"     " directory to store log files defaults to taskwarrior data.location
"     let g:task_log_directory   = '~/.task'
"     " max number of historical entries
"     let g:task_log_max         = '20'
"     " forward arrow shown on statusline
"     let g:task_left_arrow      = ' <<'
"     " backward arrow ...
"     let g:task_left_arrow      = '>> '
" " endfunction

" function! ConfigPluginCPPEnhancedHighlighting()
    " " optional highlight
    " let g:cpp_class_scope_highlight = 1
" endfunction

" function! ConfigPluginFugitive()
    " make sure Gdiff opens vertical windows
    set diffopt+=vertical
" endfunction

" function! ConfigPluginDoxygenToolkit()
    nnoremap <leader>cd :Dox<cr>
    let g:DoxygenToolkit_briefTag_pre="@brief  "
    let g:DoxygenToolkit_paramTag_pre="@param "
    let g:DoxygenToolkit_returnTag="@return "
    let g:DoxygenToolkit_authorName="Carlos Wang"
    let g:DoxygenToolkit_licenseTag="TODO: TBD"
" endfunction

" function! ConfigPluginDoxygenHighlighting()
    let g:load_doxygen_syntax=1
    " set syntax=cpp.doxygen
" endfunction

" VimRC Loading Procedures

" " Startup
" call StarterConfigs()
" call ConfigKeyMappings()
" call Vundle()
" call ConfigColorScheme()
" call RecommendedSettings()
" call ConfigSpellChecker()
" call ConfigTMUXforVim()
"
" " Plugins
" call ConfigPluginSyntastic()
" call ConfigPluginNERDTree()
" call ConfigPluginCtrlP()
" call ConfigPluginNERDCommenter()
" call ConfigPluginNeoComplete()
" call ConfigPluginEasyAlign()
" call ConfigPluginArgWrap()
" call ConfigPluginIndentGuides()
" call ConfigPluginEasyMotion()
" call ConfigPluginTagBar()
" call ConfigPluginCLangFormat()
" call ConfigPluginVimWiki()
" call ConfigPluginSpeedDating()
" "call ConfigPluginTaskWarrior()
" call ConfigPluginCPPEnhancedHighlighting()
" call ConfigPluginFugitive()
" call ConfigPluginDoxygenToolkit()
" call ConfigPluginDoxygenHighlighting()
"
" " Configure Key Mappings
