# Lucas' custom powerlevel10k theme.
# Based on romkatv/powerlevel10k/config/p10k-lean.zsh, checksum 34415.
# See the example configs for more complete settings: https://github.com/romkatv/powerlevel10k/blob/master/config/
# Type `p10k configure` to generate another config.
#
#
# Tip: Looking for a nice color? Here's a one-liner to print colormap.
#
#   for i in {0..255}; do print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'}; done

() {
  # The list of segments shown on the left prompt.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      # =========================[ Line #1 ]=========================
      status                  # return status of last command
      time                    # current time
      dir                     # current directory
      vcs                     # git status
      # =========================[ Line #2 ]=========================
      newline
      prompt_char             # prompt symbol
  )
  # Nothing on the right prompt:
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
  
  # Lucas: disable icons for segments (I will enable the ones i like individually)
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=
  
  # Mode for font icons. I use a nerdfont font.
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  
  # Add an empty line before each prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  
  # Ruler, a.k.a. the horizontal line before each prompt.
  typeset -g POWERLEVEL9K_SHOW_RULER=true
  typeset -g POWERLEVEL9K_RULER_CHAR='─'
  typeset -g POWERLEVEL9K_RULER_FOREGROUND=240
  
  ##########################[ status: exit code of the last command ]###########################
  
  # nothing for an ok status
  typeset -g POWERLEVEL9K_STATUS_OK=false
  
  # for an error, show a new segment with a red background and a white cross
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=255 # white
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=001 # red
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
  # don't show the error code on error
  typeset -g POWERLEVEL9K_STATUS_VERBOSE=false
  
  
  ####################################[ time: current time ]####################################
  # Current time color.
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=black
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=007
  # Format for the current time: 09:51. See `man 3 strftime`.
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
  # If set to true, time will update when you hit enter. This way prompts for the past
  # commands will contain the start times of their commands as opposed to the default
  # behavior where they contain the end times of their preceding commands.
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
  
  ##################################[ dir: current directory ]##################################
  # Default current directory color.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=252 # almost white
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=004
  # Lucas enable icons for the directory segment
  typeset -g POWERLEVEL9K_DIR_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
  # Enable special styling for non-writable directories.
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
  # Shorten the path if it is too long
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_absolute_chars
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=40
  # Replace removed chars with this symbol.
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=…
  
  #####################################[ vcs: git status ]######################################
  # Enable support for a conflict states (to customise colours)
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_STATE=true
  
  # Colors:
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=254 # almost white
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=028 #green
  typeset -g POWERLEVEL9K_VCS_{MODIFIED,UNTRACKED}_FOREGROUND=000 # black
  typeset -g POWERLEVEL9K_VCS_{MODIFIED,UNTRACKED,CONFLICTED}_BACKGROUND=003 # yellow/orange
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=247 # gray
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=235 # almost black 
  
  # Icons:
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON=''
  typeset -g POWERLEVEL9K_VCS_MODIFIED_ICON=''
  typeset -g POWERLEVEL9K_VCS_STASH_ICON=''
  typeset -g POWERLEVEL9K_VCS_CONFLICT_ICON=''
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON=''
  
  # Git status: feature:master#tag ⇣42⇡42 42 merge 42 42 42 42.
  #
  # VCS_STATUS parameters are set by gitstatus plugin. See reference:
  # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
  # See here for an explanation of ZSH parameter expansions: http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion
  local vcs=''
  # 'feature' or '@72f5c8a' if not on a branch.
  vcs+='${${VCS_STATUS_LOCAL_BRANCH:+${POWERLEVEL9K_VCS_BRANCH_ICON}${VCS_STATUS_LOCAL_BRANCH//\%/%%}}'
  vcs+=':-@${VCS_STATUS_COMMIT[1,8]}}'
  # ':remotebranchname' if the tracking branch name differs from local branch and is not tracking master
  vcs+='${${VCS_STATUS_REMOTE_BRANCH:#($VCS_STATUS_LOCAL_BRANCH|master)}:+:${VCS_STATUS_REMOTE_BRANCH//\%/%%}}'
  # '#tag' if on a tag
  vcs+='${VCS_STATUS_TAG:+#${VCS_STATUS_TAG//\%/%%}}'
  # add a space after the branch shenanigans, only if there is nothing more in the prompt
  vcs+=' '
  # ⇣42 if behind the remote. If no commits are ahead, also add trailing space
  vcs+='${${VCS_STATUS_COMMITS_BEHIND:#0}:+⇣${VCS_STATUS_COMMITS_BEHIND}${${VCS_STATUS_COMMITS_AHEAD:#<1->}:+ }}'
  # ⇡42 if ahead of the remote
  vcs+='${${VCS_STATUS_COMMITS_AHEAD:#0}:+⇡${VCS_STATUS_COMMITS_AHEAD} }'
  # if there are stashes
  vcs+='${${VCS_STATUS_STASHES:#0}:+%025F${POWERLEVEL9K_VCS_STASH_ICON}${VCS_STATUS_STASHES} }'
  # if the repo is in an unusual state, e.g during a merge: 'merge'
  vcs+='${VCS_STATUS_ACTION:+%001F${VCS_STATUS_ACTION//\%/%%} }'
  # if there are merge conflicts
  vcs+='${${VCS_STATUS_NUM_CONFLICTED:#0}:+%001F${POWERLEVEL9K_VCS_CONFLICT_ICON}${VCS_STATUS_NUM_CONFLICTED}}'
  # if there are staged changes
  vcs+='${${VCS_STATUS_NUM_STAGED:#0}:+%021F${POWERLEVEL9K_VCS_STAGED_ICON}${VCS_STATUS_NUM_STAGED}}'
  # if there are modified files
  vcs+='${${VCS_STATUS_NUM_UNSTAGED:#0}:+%124F${POWERLEVEL9K_VCS_MODIFIED_ICON}${VCS_STATUS_NUM_UNSTAGED}}'
  #  if there are untracked files.
  vcs+='${${VCS_STATUS_NUM_UNTRACKED:#0}:+%008F${POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}}'
  # Force a color reset in case this breaks over to another line
  vcs+='$reset_color'
  # If P9K_CONTENT is not empty, leave it unchanged. It's either "loading" or from vcs_info.
  vcs="\${P9K_CONTENT:-$vcs}"
  
  # Disable the default Git status formatting.
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  # Use the above Git status formatter.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION=$vcs
  # When Git status is being refreshed asynchronously, display the last known repo status in grey.
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION=${${${vcs//\%f}//\%<->F}//\%F\{(\#|)[[:xdigit:]]#(\\|)\}}
  # Enable counters for staged, unstaged, etc.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  
  ################################[ prompt_char: prompt symbol ]################################
  # Green prompt for both ok and error state
  typeset -g POWERLEVEL9K_PROMPT_CHAR_FOREGROUND=076
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  # No whitespace around the prompt character
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=''
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  # Prompt symbol in visual vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_SEGMENT_SEPARATOR=''
}
