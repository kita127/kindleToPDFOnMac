-- -----------------------------------------
-- 設定値
-- -----------------------------------------
-- 最終ページ
set endPage to 1

-- ページめくり方向
-- 1:左めくり
-- 2:右めくり
set pageDirection to 1

-- 出力先フォルダ
set savepath to ""


-- -----------------------------------------
-- config ファイル入力
-- -----------------------------------------
-- カレントディレクトリパスの取得
tell application "Finder"
	set tmpP to folder of (path to me) as Unicode text
	set p to get POSIX path of tmpP
end tell

-- config.txt の設定値を読み出し
set configPath to p & "config.txt"
set s to ""
open for access configPath
try
	set s to read configPath before return
end try
close access configPath

-- config.txt の設定値を取得
set ls to splitWord(s, ",")

-- 各設定値の取得
set endPage to (item 2 of splitWord(item 1 of ls, "="))
set pageDirection to (item 2 of splitWord(item 2 of ls, "="))
set savepath to savepath & (item 2 of splitWord(item 3 of ls, "="))

-- delimit でスプリットした文字列リストを返す
on splitWord(s, delimit)
	set AppleScript's text item delimiters to delimit
	set ls to every text item of s
	return ls
end splitWord

(*
display dialog endPage
display dialog pageDirection
display dialog savepath
*)

-- -----------------------------------------
-- 出力先フォルダを作成
-- -----------------------------------------
set cmd to ("mkdir " & savepath)

display dialog cmd

try
	do shell script cmd
on error
	display dialog "出力先フォルダが既に存在するため処理を中断します"
	return
end try

-- -----------------------------------------
-- Kindle をオープン
-- -----------------------------------------

-- ページめくりキーの設定
if pageDirection = 1 then
	set keyChar to (ASCII character 28)
else
	set keyChar to (ASCII character 29)
end if

-- Kindle アプリケーションをアクティブ
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
