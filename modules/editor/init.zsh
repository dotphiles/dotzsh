#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Sets key bindings.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Dumb terminals lack support.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Beep on error in line editor.
setopt BEEP

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

typeset -gA key_info
key_info=(
  'Control'   '\C-'
  'Escape'    '\e'
  'Meta'      '\M-'
  'Backspace' "^?"
  'Delete'    "^[[3~"
)

# Check for the minimum supported version.
min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || is-at-least "$min_zsh_version"; then
# Use human-friendly identifiers.
  zmodload zsh/terminfo
  typeset -gA key_info
  key_info+=(
    'F1'        "$terminfo[kf1]"
    'F2'        "$terminfo[kf2]"
    'F3'        "$terminfo[kf3]"
    'F4'        "$terminfo[kf4]"
    'F5'        "$terminfo[kf5]"
    'F6'        "$terminfo[kf6]"
    'F7'        "$terminfo[kf7]"
    'F8'        "$terminfo[kf8]"
    'F9'        "$terminfo[kf9]"
    'F10'       "$terminfo[kf10]"
    'F11'       "$terminfo[kf11]"
    'F12'       "$terminfo[kf12]"
    'Insert'    "$terminfo[kich1]"
    'Home'      "$terminfo[khome]"
    'PageUp'    "$terminfo[kpp]"
    'End'       "$terminfo[kend]"
    'PageDown'  "$terminfo[knp]"
    'Up'        "$terminfo[kcuu1]"
    'Left'      "$terminfo[kcub1]"
    'Down'      "$terminfo[kcud1]"
    'Right'     "$terminfo[kcuf1]"
    'BackTab'   "$terminfo[kcbt]"
  )
fi
unset min_zsh_version

# Do not bind any keys if there are empty values in $key_info.
for key in "$key_info[@]"; do
  if [[ -z "$key" ]]; then
    print "dotzsh: one or more keys are non-bindable" >&2
    return 1
  fi
done

# alias sudoedit if it doesnt exist
if (( ! $+commands[sudoedit] )); then
  alias sudoedit='sudo -e '
fi

# Displays editor information.
function editor-info {
  # Clean up previous $editor_info.
  unset editor_info
  typeset -gA editor_info

  if [[ "$KEYMAP" == 'vicmd' ]]; then
    zstyle -s ':dotzsh:module:editor:keymap' alternate 'REPLY'
    editor_info[keymap]="$REPLY"
  else
    zstyle -s ':dotzsh:module:editor:keymap' primary 'REPLY'
    editor_info[keymap]="$REPLY"

    if [[ "$ZLE_STATE" == *overwrite* ]]; then
      zstyle -s ':dotzsh:module:editor:keymap:primary' overwrite 'REPLY'
      editor_info[overwrite]="$REPLY"
    else
      zstyle -s ':dotzsh:module:editor:keymap:primary' insert 'REPLY'
      editor_info[overwrite]="$REPLY"
    fi
  fi

  unset REPLY

  zle reset-prompt
  zle -R
}
zle -N editor-info

# Updates editor information when the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  zle editor-info
}
zle -N zle-keymap-select
zle -N zle-line-finish
zle -N zle-line-init

# Toggles emacs overwrite mode and updates editor information.
function overwrite-mode {
  zle .overwrite-mode
  zle editor-info
}
zle -N overwrite-mode

# Enters vi insert mode and updates editor information.
function vi-insert {
  zle .vi-insert
  zle editor-info
}
zle -N vi-insert

# Moves to the first non-blank character then enters vi insert mode and updates
# editor information.
function vi-insert-bol {
  zle .vi-insert-bol
  zle editor-info
}
zle -N vi-insert-bol

# Enters vi replace mode and updates editor information.
function vi-replace  {
  zle .vi-replace
  zle editor-info
}
zle -N vi-replace

# Expands .... to ../..
function expand-dot-to-parent-directory-path {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N expand-dot-to-parent-directory-path

# Displays an indicator when completing.
function expand-or-complete-with-indicator {
  local indicator
  zstyle -s ':dotzsh:module:editor' completing 'indicator'
  print -Pn "$indicator"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-indicator

# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Reset to default key bindings.
bindkey -d

# Emacs key bindings.
for key ("$key_info[Escape]"{B,b}) bindkey -M emacs "$key" emacs-backward-word
for key ("$key_info[Escape]"{F,f}) bindkey -M emacs "$key" emacs-forward-word
bindkey -M emacs "$key_info[Escape]$key_info[Left]" emacs-backward-word
bindkey -M emacs "$key_info[Escape]$key_info[Right]" emacs-forward-word

# Kill to the beginning of the line.
for key in "$key_info[Escape]"{K,k}
  bindkey -M emacs "$key" backward-kill-line

# Redo.
bindkey -M emacs "$key_info[Escape]_" redo

# Search previous character.
bindkey -M emacs "$key_info[Control]X$key_info[Control]B" vi-find-prev-char

# Match bracket.
bindkey -M emacs "$key_info[Control]X$key_info[Control]]" vi-match-bracket

# Edit command in an external editor.
bindkey -M emacs "$key_info[Control]X$key_info[Control]E" edit-command-line

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M emacs "$key_info[Control]R" \
    history-incremental-pattern-search-backward
  bindkey -M emacs "$key_info[Control]S" \
    history-incremental-pattern-search-forward
fi

# Vi key bindings.

# Edit command in an external editor.
bindkey -M vicmd "v" edit-command-line

# Undo/Redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "$key_info[Control]R" redo

# Switch to command mode.
bindkey -M viins "jk" vi-cmd-mode
bindkey -M viins "kj" vi-cmd-mode

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M vicmd "?" history-incremental-pattern-search-backward
  bindkey -M vicmd "/" history-incremental-pattern-search-forward
else
  bindkey -M vicmd "?" history-incremental-search-backward
  bindkey -M vicmd "/" history-incremental-search-forward
fi

# Emacs and Vi key bindings.
for keymap in 'emacs' 'viins'; do
  if (( $+key_info[Home] )) bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
  if (( $+key_info[End])) bindkey -M "$keymap" "$key_info[End]" end-of-line

  if (( $+key_info[Insert] )) bindkey -M "$keymap" "$key_info[Insert]" overwrite-mode
  if (( $+key_info[Delete] )) bindkey -M "$keymap" "$key_info[Delete]" delete-char
  if (( $+key_info[Backspace] )) bindkey -M "$keymap" "$key_info[Backspace]" backward-delete-char

  if (( $+key_info[Left] )) bindkey -M "$keymap" "$key_info[Left]" backward-char
  if (( $+key_info[Right] )) bindkey -M "$keymap" "$key_info[Right]" forward-char

  # Bind Shift + Tab to go to the previous menu item.
  if (( $+key_info[BackTab] )) bindkey -M "$keymap" "$key_info[BackTab]" reverse-menu-complete

  bindkey -M "$keymap" "$key_info[Backspace]" backward-delete-char

  # Expand history on space.
  bindkey -M "$keymap" ' ' magic-space

  # Clear screen.
  bindkey -M "$keymap" "$key_info[Control]L" clear-screen

  # Expand command name to full path.
  for key in "$key_info[Escape]"{E,e}
    bindkey -M "$keymap" "$key" expand-cmd-path

  # Duplicate the previous word.
  for key in "$key_info[Escape]"{M,m}
    bindkey -M "$keymap" "$key" copy-prev-shell-word

  # Use a more flexible push-line.
  for key in "$key_info[Control]Q" "$key_info[Escape]"{q,Q}
    bindkey -M "$keymap" "$key" push-line-or-edit

  # Complete in the middle of word.
  bindkey -M "$keymap" "$key_info[Control]I" expand-or-complete

  # Expand .... to ../..
  if zstyle -t ':dotzsh:module:editor' dot-expansion; then
    bindkey -M "$keymap" "." expand-dot-to-parent-directory-path
  fi

  # Display an indicator when completing.
  bindkey -M "$keymap" "$key_info[Control]I" \
    expand-or-complete-with-indicator

  # Insert 'sudo ' at the beginning of the line.
  bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]S" prepend-sudo
done

# Do not expand .... to ../.. during incremental search.
if zstyle -t ':dotzsh:module:editor' dot-expansion; then
  bindkey -M isearch . self-insert 2> /dev/null
fi

# Set the key layout.
zstyle -s ':dotzsh:module:editor' keymap 'keymap'
if [[ "$keymap" == (emacs|) ]]; then
  bindkey -e
elif [[ "$keymap" == vi ]]; then
  bindkey -v
else
  print "dotzsh: invalid keymap: $keymap" >&2
fi

# Set the EDITOR
zstyle -s ':dotzsh:module:editor' editor 'editor'
if [[ "$editor" == (nano|) ]]; then
  export EDITOR='nano'
  export VISUAL='nano'
elif [[ "$editor" == emacs ]]; then
  export EDITOR='emacs'
  export VISUAL='emacs'
elif [[ "$editor" == vi ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
  if (( $+commands[vim] )); then
    alias vi=vim
  fi
else
  print "dotzsh: invalid editor: $editor" >&2
fi

# ctrl+x e to edit command line in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

unset key{map}

