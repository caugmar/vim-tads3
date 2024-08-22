" ~/.vim/plugin/tads3_indent.vim

" Define the indentation function for TADS 3
function! Tads3Indent()
  " Get the current line number
  let lnum = v:lnum
  
  " Get the current line's text
  let line = getline(lnum)
  
  " Get the previous line's text
  let prevline = getline(lnum - 1)
  
  " Start with the same indentation as the previous line
  let indentlevel = indent(lnum - 1)
  
  " Increase indent after a line ending with '{', ':', or '['
  if prevline =~ '{\s*$' || prevline =~ ':\s*$' || prevline =~ '\[\s*$'
    let indentlevel += &shiftwidth
  endif
  
  " Decrease indent for lines starting with '}' or ']'
  if line =~ '^\s*[}\]]'
    let indentlevel -= &shiftwidth
    return indentlevel >= 0 ? indentlevel : 0
  endif
  
  " Increase indent after object or class definitions identified by ' : '
  if prevline =~ '\s:\s'
    let indentlevel += &shiftwidth
  endif
  
  " Return the computed indentation level
  return indentlevel
endfunction

setlocal indentexpr=Tads3Indent()

