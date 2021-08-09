-- -----------------------------------------
-- 設定値
-- -----------------------------------------
-- 最終ページ
set pageCount to 1

-- ページめくり方向
-- 1:左めくり
-- 2:右めくり
set pageDirection to 1

-- 出力先フォルダ
set savepath to ""

-- キャプチャ位置
set x to 0
set y to 0
set cWidth to 0
set cHeight to 0

-- OCR 有効/無効
set ocrEnable to 1

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
set pageCount to (item 2 of splitWord(item 1 of ls, "="))
set pageDirection to (item 2 of splitWord(item 2 of ls, "="))
set x to (item 2 of splitWord(item 3 of ls, "="))
set y to (item 2 of splitWord(item 4 of ls, "="))
set cWidth to (item 2 of splitWord(item 5 of ls, "="))
set cHeight to (item 2 of splitWord(item 6 of ls, "="))
set savepath to savepath & (item 2 of splitWord(item 7 of ls, "="))
set ocrTemp to (item 2 of splitWord(item 8 of ls, "="))

if ocrTemp is "0" then
	set ocrEnable to false
else if ocrTemp is "1" then
	set ocrEnable to true
else
	-- 不正な値
	display dialog "OCR の値は 0 か 1 を設定してください"
	return
end if

-- delimit でスプリットした文字列リストを返す
on splitWord(s, delimit)
	set AppleScript's text item delimiters to delimit
	set ls to every text item of s
	return ls
end splitWord

(*
display dialog pageCount
display dialog pageDirection
display dialog savepath
*)

-- -----------------------------------------
-- 出力先フォルダを作成
-- -----------------------------------------
set cmd to ("mkdir " & savepath)

display dialog "出力先フォルダ : " & savepath

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
	-- 左キー
	set keyChar to (ASCII character 28)
else
	-- 右キー
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
-- OCR 付きの PDF 生成
-- -----------------------------------------

delay 1.0
repeat with i from 1 to pageCount
	set out to (savepath & i & ".png")
	
	-- スクリーンショット
	do shell script "screencapture -R " & x & "," & y & "," & cWidth & "," & cHeight & " " & out
	
	-- ページめくり
	tell application "System Events"
		keystroke keyChar
	end tell
	
	if ocrEnable then
		-- OCR 処理し PDF 出力	
		do shell script "/usr/local/bin/tesseract " & savepath & i & ".png  " & savepath & i & " -l eng+jpn pdf"
		
		-- PNG ファイルの削除
		do shell script "rm " & savepath & "*.png"
	else
		delay 1.0
	end if
	
end repeat

display dialog "実行完了"
