-- -----------------------------------------
-- Kindle をオープン
-- -----------------------------------------
set target to "Kindle"
if target is not "" then
	tell application target
		activate
	end tell
end if

set startPage to 1
set endPage to 471

-- 右めくりのキー
set keyChar to (ASCII character 29)

repeat with i from startPage to endPage
	delay 1.0
	tell application "System Events"
		keystroke keyChar
	end tell
end repeat
