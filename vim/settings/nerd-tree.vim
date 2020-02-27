" --- NERDTree ----
let NERDTreeIgnore=['.DS_Store']
let NERDTreeShowBookmarks=0
let NERDTreeHighlightCursorline=1
let NERDTreeShowLineNumbers=0
let NERDTreeMinimalUI=1
map <C-n> :NERDTreeToggle<CR>

" --- NERDCommenter ---

let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1
let g:NERDCustomDelimiters = {
    \ 'scss': { 'left': '//' }
\ }