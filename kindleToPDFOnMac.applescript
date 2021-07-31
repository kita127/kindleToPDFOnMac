

-- -----------------------------------------
-- config ファイル入力
-- 今の所使用していない
-- -----------------------------------------
display dialog "config ファイルを選択してください"

set theText to loadText(choose file)

on loadText(theFile)
	try
		open for access theFile
		set theText to read theFile
	end try
	close access theFile
	return theText
end loadText

display dialog theText



-- -----------------------------------------
-- Kindle をオープン
-- -----------------------------------------

set startPage to 1
set endPage to 471
set savepath to "~/work/repo/kindleToPDFOnMac/output/"

-- 右めくりのキー
set keyChar to (ASCII character 29)

set target to "Kindle"
if target is not "" then
	tell application target
		activate
	end tell
end if
repeat with i from startPage to endPage
    set out to (savepath & "p_" & i & ".png")
    do shell script "screencapture " & out
	delay 1.0
	tell application "System Events"
		keystroke keyChar
	end tell
end repeat


