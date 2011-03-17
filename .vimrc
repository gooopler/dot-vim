"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings
"
"    -> Cope
"    -> Minibuffer plugin
"    -> Omni complete functions
"    -> MISC
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" system sleecton

function! MySys()
    if has("win32")
        return "windows"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction
" Preamble --------------------------------------------------------------------
" {{{
"
filetype off
"call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700                " 设置VIM保留历史记录的行数
filetype plugin on             " Enable filetype plugin
filetype indent on
set autoread                   " 文件在外部被改编后自动重新读取

let mapleader = ","            " With a map leader it's possible to do extra key combinations
let g:mapleader = ","
 " 快速保存文件
nmap <leader>w :w!<cr>
nmap <leader>x :xa!<cr>
" 很方便的编辑 vimrc
if MySys()=="windows"
  map <leader>e :e! ~\_vimrc<cr>
  autocmd! bufwritepost vimrc source ~\_vimrc    " vimrc该变后自动装载
else
" 很方便的编辑 vimrc
  map <leader>e :e! ~/.vimrc<cr>
  autocmd! bufwritepost vimrc source ~/.vimrc   " vimrc该变后自动装载
endif  

set textwidth=80
set formatoptions+=mM

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7                         " Set 7 lines to the curors - when moving vertical..
set wildmenu                     "Turn on WiLd menu
set ruler                        "Always show current position
set nu                           "Show line number
set cmdheight=2                  "The commandbar height
set hid                          "Change buffer - without saving
set backspace=eol,start,indent   " Set backspace config
set whichwrap+=<,>,h,l
set ignorecase                   "Ignore case when searching
set smartcase
set hlsearch                     "Highlight search things
set tags=tags;/               " search recursively up for tags
set incsearch                    "搜索时，显示匹配位置,(下划线) 类型浏览器的行为。

set nolazyredraw                 "Don't redraw while executing macros 
set magic                        "Set magic on, for regular expressions
set showmatch                    "Show matching bracets when text indicator is over them
set mat=2                        "How many tenths of a second to blink
set noerrorbells                 " 烦人的bell.... 干掉 No sound on errors
set novisualbell
set t_vb=
set tm=500
set ttyfast                      "加快终端重绘的速度   we have a fast terminal
set matchpairs+=<:>           " add < and > to match pairs
set modeline                    "设置模式行

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

"internationalization 主要是中文的设置
if has("multi_byte")
    "set bomb
  set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
  " CJK environment detection and corresponding setting
  if v:lang =~ "^zh_CN"
    " Use cp936 to support GBK, euc-cn == gb2312
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    "listchars 只有加在这里才正常 why
    set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
  elseif v:lang =~ "^zh_TW"
    " cp950, big5 or euc-tw
    " Are they equal to each other?
    set encoding=big5
    set termencoding=big5
    set fileencoding=big5
  elseif v:lang =~ "^ko"
    " Copied from someone's dotfile, untested
    set encoding=euc-kr
    set termencoding=euc-kr
    set fileencoding=euc-kr
  elseif v:lang =~ "^ja_JP"
    " Copied from someone's dotfile, untested
    set encoding=euc-jp
    set termencoding=euc-jp
    set fileencoding=euc-jp
  endif
  " Detect UTF-8 locale, and replace CJK setting if needed
  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
  endif
endif
"解决菜单乱码
if has("gui_running")
    set langmenu=zh_CN
    let $LANG = 'zh_CN.UTF-8'
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim 
    endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
    set ambiwidth=double
endif
""设置GUI选项
if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
	
	set cursorline
    set t_Co=256
	set background=dark
	
    if MySys()=="windows"
        "start gvim maximized
        if has("autocmd")
            au GUIEnter * simalt ~x
        endif
    endif
    "let psc_style='cool'
    if v:version > 601
        "colorscheme ps_color
        colorscheme ir_black            " 不错的界面配色
        "colorscheme molokai
	endif
else    " ++++++没有图形界面++++++
    if v:version > 601
        "set background=dark
        "colorscheme default
         colorscheme  ter_ir_black
        "colorscheme molokai
    endif
endif




" Set font according to system
if has("gui_running")
	if MySys() == "mac"
	  set gfn=Menlo:h14
	  set shell=/bin/bash
	elseif MySys() == "windows"
	  "set gfn=Bitstream\ Vera\ Sans\ Mono:h10  :cANSI
	  set gfn=monaco:h12:cANSI                          "guifont = gfn
	elseif MySys() == "linux"
	  set gfn=Monospace\ 10
	  set shell=/bin/bash
	endif
endif

set ffs=unix,dos,mac "Default file types
",fd 文件格式为windows格式
nmap <leader>fd :se ff=dos<cr>
",fu 文件格式为linux 格式
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
try
    if MySys() == "windows"
      set undodir=C:\Windows\Temp
    else
      set undodir=~/.vim/undodir
      let $VIM = "/home/liangchunyu/.vim/"
    endif
    
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set ai                       "Auto indent
set si                       "Smart indet
set wrap                     "Wrap lines

"C-style indenting
if has("cindent")
    set cindent
endif


"set list!                    "display blank chars
nmap <silent> <leader>l :set list!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Aligning text with Tabular.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=','
if exists(":Tabularize")
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
endif
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
      let p = '^\s*|\s.*\s|\s*$'
      if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
          let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
          let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
          Tabularize/|/l1
          normal! 0
          call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
      endif
endfunction
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Useful on some European keyboards
map ? $
imap ? $
vmap ? $
cmap ? $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" 方便在窗口之间切换，在Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tl :tabprev<cr>
map <leader>th :tabnext<cr>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2                     " 永远显示有标签页的行 show tab line
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flags
set statusline+=[
if v:version >= 600
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&encoding}, " encoding
endif
set statusline+=%{&fileformat}] " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()} " vim buddy
endif
set statusline+=%= " right align
set statusline+=%2*0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset


" special statusbar for special windows
if has("autocmd")
    au FileType qf
                \ if &buftype == "quickfix" |
                \ setlocal statusline=%2*%-3.3n%0* |
                \ setlocal statusline+=\ \[Compiler\ Messages\] |
                \ setlocal statusline+=%=%2*\ %<%P |
                \ endif

    fun! FixMiniBufExplorerTitle()
        if "-MiniBufExplorer-" == bufname("%")
            setlocal statusline=%2*%-3.3n%0*
            setlocal statusline+=\[Buffers\]
            setlocal statusline+=%=%2*\ %<%P
        endif
    endfun

    if v:version>=600
        au BufWinEnter *
                    \ let oldwinnr=winnr() |
                    \ windo call FixMiniBufExplorerTitle() |
                    \ exec oldwinnr . " wincmd w"
    endif
endif

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\ " file name
    set titlestring+=%h%m%r%w " flags
    set titlestring+=\ -\ %{v:progname} " program name
endif


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"iab xname Amir Salihefendic                    " 我的名字

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0"行首
map 0 ^ 

"用 ALT+[jk] 来移动一行文字or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()

set guitablabel=%t           "描述 GUI 标签页行使用的标签的文本,如果为空使用默认值。


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 	打开一个窗口显示当前的错误列表。
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 25  " Split width
let g:bufExplorerUseCurrentWindow=0  " Open in new window.
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 1
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  show mark plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen


"++++++++++++++++++++++++++++++++++++++++++++++++++++
" NERD Tree Plugin Settings
"++++++++++++++++++++++++++++++++++++++++++++++++++++
" load nerd tree on startup
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="~\vimfiles\NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
            \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
            \ '\.embed\.manifest$', '\.embed\.manifest.res$',
            \ '\.intermediate\.manifest$', '^mt.dep$' ]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd BufNewFile,BufRead *.c set formatprg=astyle\ -T4pb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc
noremap <leader>j :CommandT<cr>
noremap <leader>y :CommandTFlush<cr>
" --------------------
" TagList
" --------------------
" F4: Switch on/off TagList
nnoremap <silent> <F4> :TlistToggle<CR>
" TagListTagName - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
" TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue
" TagListTitle - Used for tag titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
" TagListComment - Used for comments
highlight MyTagListComment guifg=DarkGreen
" TagListFileName - Used for filenames
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue
"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 25 
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 if has("cscope")
   set csprg=$HOME/bin/cscope
   set csto=1
   set cst
   set nocsverb
" add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif
"
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>

"Remove indenting on empty line
map <F2> :%s/s*$//g<cr>:noh<cr>''

"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
" Automaticaly  cd into the dirtory that the  file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" srcexplor plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" // The switch of the Source Explorer
 nmap <F8> :SrcExplToggle<CR>
" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8
" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100
" // Set "Enter" key to jump into the exact definition context
 let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"
" // In order to Avoid conflicts, the Source Explorer should know what plugins
" // are using buffers. And you need add their bufname into the list below
" // according to the command ":buffers!"
let g:SrcExpl_pluginList = [
 \ "__Tag_List__",
 \ "_NERD_tree_",
 \ "Source_Explorer"
 \ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" //  create/update a tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

" // Set "<F12>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F12>" 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Rainbows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 nmap <leader>R :RainbowParenthesesToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some userfule key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When I forget I'm in Insert mode, how often do you type 'jj' anyway?:
imap jj <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bubble text
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bubble single lines
nmap <leader><Up> ddkP
nmap <leader><Down> ddp
" Bubble multiple lines
vmap <A-Up> xkP`[V`]
vmap <A-Down> xp`[V`]

