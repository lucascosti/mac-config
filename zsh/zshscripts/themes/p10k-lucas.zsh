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

  ## Old shorten config:
  # # Shorten the path if it is too long
  # typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_absolute_chars
  # typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=40
  # # Replace removed chars with this symbol.
  # typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=…

  ## New shorten config:
  # If directory is too long, shorten some of its segments to the shortest possible unique
  # prefix. The shortened directory can be tab-completed to the original.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  # Shorten directory if it's longer than this even if there is space for it. The value can
  # be either absolute (e.g., '80') or a percentage of terminal width (e.g, '50%'). If empty,
  # directory will be shortened only when prompt doesn't fit or when other parameters demand it
  # (see POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS and POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT below).
  # If set to `0`, directory will always be shortened to its minimum length.
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=50%
  # Don't shorten this many last directory segments. They are anchors.
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  # Display anchor directory segments in bold.
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  # Don't shorten directories that contain any of these files. They are anchors.
  local anchor_files=(
    .git
  )
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  # If set to "first" ("last"), remove everything before the first (last) subdirectory that contains
  # files matching $POWERLEVEL9K_SHORTEN_FOLDER_MARKER. For example, when the current directory is
  # /foo/bar/git_repo/nested_git_repo/baz, prompt will display git_repo/nested_git_repo/baz (first)
  # or nested_git_repo/baz (last). This assumes that git_repo and nested_git_repo contain markers
  # and other directories don't.
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=last
  # Don't shorten this many last directory segments. They are anchors.
  #typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  # Shorten directory if it's longer than this even if there is space for it. The value can
  # be either absolute (e.g., '80') or a percentage of terminal width (e.g, '50%'). If empty,
  # directory will be shortened only when prompt doesn't fit or when other parameters demand it
  # (see POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS and POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT below).
  # If set to `0`, directory will always be shortened to its minimum length.
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=40
  # Don't shorten this many last directory segments. They are anchors.
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  
  #####################################[ vcs: git status ]######################################
  # Enable support for a conflict states (to customise colours)
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_STATE=true
  
  # General colors (see the my_git_formatter()  function for other foreground colors specific to the type git ):
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=254 # almost white
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=028 #green
  typeset -g POWERLEVEL9K_VCS_{MODIFIED,UNTRACKED}_FOREGROUND=000 # black
  typeset -g POWERLEVEL9K_VCS_{MODIFIED,UNTRACKED,CONFLICTED}_BACKGROUND=003 # yellow/orange
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=248 # lighter gray
  typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=240 # darker gray 
  
  # Icons:
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON=''
  typeset -g POWERLEVEL9K_VCS_MODIFIED_ICON=''
  typeset -g POWERLEVEL9K_VCS_STASH_ICON=''
  typeset -g POWERLEVEL9K_VCS_CONFLICT_ICON=''
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON=''

  # Formatter for Git status.
  #
  # Example output: local_branch:tracking#tag ⇣42⇡42 42 merge 42 424242
  # VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
  # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
  function my_git_formatter() {
    emulate -L zsh

    if [[ -n $P9K_CONTENT ]]; then
      # If P9K_CONTENT is not empty, use it. It's either "loading" or from vcs_info (not from
      # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi

    # Colors for most foreground elements of git status
    if (( $1 )); then
      # Styling for up-to-date Git status.
      # Lucas: commenting these couple out, so it should use the POWERLEVEL9K_VCS_ colors for clean/dirty.
      # local       meta='%248F'  #  foreground
      # local      clean='%254F'  #  foreground
      local   modified='%124F'  # dark red foreground
      local  untracked='%008F'  # grey foreground
      local conflicted='%001F'  # red foreground
      # Lucas: other custom colors
      local    stashed='%025F'  # subtle blue foreground
      local     staged='%021F'  # blue foreground
    else
      # Styling for incomplete and stale Git status.
      # Lucas: removed all these, just use POWERLEVEL9K_VCS_LOADING_ colors.
    fi

    local res
    local where  # branch or tag
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}"
      where=${(V)VCS_STATUS_LOCAL_BRANCH}
    elif [[ -n $VCS_STATUS_TAG ]]; then
      res+="${meta}#"
      where=${(V)VCS_STATUS_TAG}
    fi

    # Show tracking branch name if it differs from local branch 
    ## Lucas: moved this above the shorthening test, and added the "AND is not master"
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} && ${VCS_STATUS_REMOTE_BRANCH} != 'master' ]]; then
      where+=":${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
    fi

    # Lucas custom part to shorten long branch names, with remote tracking.
    local max_branch_length=40
    if (( $#where > $max_branch_length )); then
      # If the branch includes my handle (e.g. lucascosti/), replace it with a trimmed version:
      where=${where//lucascosti\//lucas…\/}
      # If it is still longer than 40 chars
      if (( $#where > $max_branch_length )); then
        if [[ $where == *:* ]]; then # if there is a tracking branch (if there is a colon in there)
          # Split into two variables at the colon
          local shorterlocalbranch=${where%\:*}
          local shorterremotebranch=${where#*\:}
          # For a max branch length of 40, shorten the local branch to 20 characters from start, 5 from the end.
          shorterlocalbranch[$max_branch_length*0.5,-($max_branch_length*0.15)]="…"
          #  For a max branch length of 40, shorten the remote branch to 13 characters
          shorterremotebranch="${shorterremotebranch:0:$max_branch_length*0.3}…"
          # Combine the two new shorter branches
          where="$shorterlocalbranch:$shorterremotebranch"
        else # there is no tracking branch, so it's a local branch only or a tag
          # For a max branch length of 40, show the first 27 … the last 8.
          where[$max_branch_length*0.7,-($max_branch_length*0.3)]="…"
        fi
      fi
    fi

    res+="${clean}${where//\%/%%}"  # escape %

    # Display the current Git commit if there is no branch or tag.
    # Tip: To always display the current Git commit, remove `[[ -z $where ]] &&` from the next line.
    [[ -z $where ]] && res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

    # add a space after the branch stuff
    res+=" "
    # ⇣42 if behind the remote.
    (( VCS_STATUS_COMMITS_BEHIND )) && res+="⇣${VCS_STATUS_COMMITS_BEHIND}"
    # ⇡42 if ahead of the remote.
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="⇡${VCS_STATUS_COMMITS_AHEAD}"
    # If there are either commits ahead or behind, add a space
    (( VCS_STATUS_COMMITS_BEHIND || VCS_STATUS_COMMITS_AHEAD )) && res+=" "
    # ⇠42 if behind the push remote.
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+="⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    # ⇢42 if ahead of the push remote.
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    # If there are either push commits ahead or behind, add trailing space
    (( VCS_STATUS_PUSH_COMMITS_BEHIND || VCS_STATUS_PUSH_COMMITS_AHEAD )) && res+=" "
    # If there are stashes.
    (( VCS_STATUS_STASHES        )) && res+="${stashed}${POWERLEVEL9K_VCS_STASH_ICON}${VCS_STATUS_STASHES} "
    # 'merge' if the repo is in an unusual state.
    [[ -n $VCS_STATUS_ACTION     ]] && res+="${conflicted}${VCS_STATUS_ACTION} "
    # Dirty icons after here; no more spaces!
    ## If there is nothing ahead, trim the space off the end
    (( !VCS_STATUS_NUM_CONFLICTED && !VCS_STATUS_NUM_STAGED && !VCS_STATUS_NUM_UNSTAGED && !VCS_STATUS_NUM_UNTRACKED )) && res="${res%% }"
    ## Otherwise:
    # If there are merge conflicts.
    (( VCS_STATUS_NUM_CONFLICTED )) && res+="${conflicted}${POWERLEVEL9K_VCS_CONFLICT_ICON}${VCS_STATUS_NUM_CONFLICTED}"
    # If there are staged changes.
    (( VCS_STATUS_NUM_STAGED     )) && res+="${staged}${POWERLEVEL9K_VCS_STAGED_ICON}${VCS_STATUS_NUM_STAGED}"
    # If there are unstaged changes.
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+="${modified}${POWERLEVEL9K_VCS_MODIFIED_ICON}${VCS_STATUS_NUM_UNSTAGED}"
    # If there are untracked files.
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+="${untracked}${POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    # "─" if the number of unstaged files is unknown. This can happen due to
    # POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY (see below) being set to a non-negative number lower
    # than the number of files in the Git index, or due to bash.showDirtyState being set to false
    # in the repository config. The number of staged and untracked files may also be unknown
    # in this case.
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+="${modified}─"

    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null
  
  # Disable the default Git status formatting.
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  # Use the above Git status formatter.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
  # When Git status is being refreshed asynchronously, display the last known repo status in grey.
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
  # Enable counters for staged, unstaged, etc.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  # Don't count the number of unstaged, untracked and conflicted files in Git repositories with
  # more than this many files in the index. Negative value means infinity.
  #
  # If you are working in Git repositories with tens of millions of files and seeing performance
  # sagging, try setting POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY to a number lower than the output
  # of `git ls-files | wc -l`. Alternatively, add `bash.showDirtyState = false` to the repository's
  # config: `git config bash.showDirtyState false`.
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
  
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
