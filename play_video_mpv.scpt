on run
    -- Check if mpv is installed
    try
        do shell script "which mpv" 
    on error
        display dialog "mpv is not installed. Please install it to proceed." buttons {"OK"} default button "OK"
        return
    end try

    -- Terminate any running mpv processes
    try
        do shell script "pkill mpv"
    end try

    tell application "Finder"
        set selectedFiles to selection
        if selectedFiles is not {} then
            set firstFile to item 1 of selectedFiles
            set filePath to POSIX path of (firstFile as alias)
        else
            -- Exit if no file is selected
            return
        end if
    end tell

    -- Launch mpv with the selected file
    do shell script "mpv " & quoted form of filePath
end run

