-- -----------------------------------------
-- 設定値
-- -----------------------------------------
set endPage to 471
set savepath to "~/work/repo/kindleToPDFOnMac/output/"


-- -----------------------------------------
-- config ファイル入力
-- 今の所使用していない
-- -----------------------------------------
-- display dialog "config ファイルを選択してください"

--set theText to loadText(choose file)
--
--on loadText(theFile)
--	try
--		open for access theFile
--		set theText to read theFile
--	end try
--	close access theFile
--	return theText
--end loadText
--
--display dialog theText


-- -----------------------------------------
-- 出力先フォルダを作成
-- -----------------------------------------
set cmd to ("mkdir " & savepath)
do shell script cmd


-- -----------------------------------------
-- Kindle をオープン
-- -----------------------------------------

-- 右めくりのキー
set keyChar to (ASCII character 29)

set target to "Kindle"
if target is not "" then
	tell application target
		activate
	end tell
end if

-- -----------------------------------------
-- Kindle をスクショ
-- -----------------------------------------
repeat with i from 1 to endPage
	set out to (savepath & "p_" & i & ".png")
	delay 1.0
	do shell script "screencapture " & out
	tell application "System Events"
		keystroke keyChar
	end tell
end repeat


