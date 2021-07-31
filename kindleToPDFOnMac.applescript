-- -----------------------------------------
-- Kindle をオープン
-- -----------------------------------------
set target to "Kindle"
if target is not "" then
    tell application target
        activate
    end tell
end if
