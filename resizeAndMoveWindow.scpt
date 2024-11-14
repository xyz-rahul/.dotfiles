-- ===========================================================
-- Script: Resize and Move Active Window based on Input Position
-- Author: [Your Name]
-- Date: [Date]
-- Description: This script resizes and moves the frontmost window
--              based on the input parameter: "maximize", "top-half", "bottom-half",
--              "left-half", or "right-half".
-- ===========================================================

on run argv
    set pos to item 1 of argv

    tell application "Finder"
        -- Get the screen dimensions of the primary screen
        set {0, 0, screenWidth, screenHeight} to bounds of window of desktop
    end tell

    tell application "System Events"
        -- Get the name of the frontmost application
        set activeApp to name of (first application process whose frontmost is true)
            
        -- Get the first (active) window of that application
        set activeWindow to first window of process activeApp

        set {x_window, y_window} to size of activeWindow 
        
        -- Resize and move the active window based on the position argument
        if pos is "maximize" then
            set position of activeWindow to {0, 0}
            set size of activeWindow to {screenWidth, screenHeight}

            -- SET WINDOW IN MIDDLE
            set activeApp to name of (first application process whose frontmost is true)
                
            set activeWindow to first window of process activeApp

            set {x_window, y_window} to size of activeWindow 
            set position of activeWindow to {screenWidth/2 - x_window/2, screenHeight/2 - y_window/2}
            -- END SET WINDOW IN MIDDLE

        else if pos is "right-half" then
            set position of activeWindow to {screenWidth/2, 0}
            set size of activeWindow to {screenWidth/2, screenHeight}
        else if pos is "left-half" then
            set position of activeWindow to {0, 0}
            set size of activeWindow to {screenWidth/2, screenHeight}
        else if pos is "top-half" then
            set position of activeWindow to {0, 0}
            set size of activeWindow to {screenWidth, screenHeight/2}
        else if pos is "bottom-half" then
            set position of activeWindow to {0, screenHeight/2}
            set size of activeWindow to {screenWidth, screenHeight/2}
        else
            -- Show an error if the position argument is invalid
            display dialog "Invalid position parameter. Use 'top-half', 'bottom-half', 'left-half', or 'right-half'."
        end if
    end tell
end run
