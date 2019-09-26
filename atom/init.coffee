# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

# Generic function to wrap text in something (original from https://discuss.atom.io/t/wrap-selection-in-html-tag-command/22318/7)
# set multiLine to false to split selections into single line
# You can set a cursor position in `before` or `after` using `$1`
wrapSelections = (editor, before, after, multiLine = true) ->

  editor.transact ->
    editor.splitSelectionsIntoLines() unless multiLine
    
    cursorPositions = for selection in editor.getSelections()
      # check if the before/after contains a cursor position
      if before.indexOf("$1") != -1
        # position is in before
        cursorOffset = before.indexOf('$1')
      else if after.indexOf("$1") != -1
        # position is in after
        cursorOffset = before.length+selection.getText().length+after.indexOf('$1')
      else
        # else put the cursor at the end of the selection
        cursorOffset = before.length+selection.getText().length+after.length
      
      cursorPosition = selection.getBufferRange().start.translate [0, cursorOffset]
      #replace the selection text
      selection.insertText("#{before.replace '$1', ''}#{selection.getText()}#{after.replace '$1', ''}")
      cursorPosition
    
    for cursorPosition, i in cursorPositions
      if i == 0
        editor.setCursorBufferPosition cursorPosition
      else
        editor.addCursorAtBufferPosition cursorPosition

# Add command to wrap selected text in markdown link
atom.commands.add 'atom-text-editor', 'custom:markdown-link', ->
  wrapSelections @getModel(), '[', ']($1)', false

