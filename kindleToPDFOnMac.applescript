-- -----------------------------------------
-- �ݒ�l
-- -----------------------------------------
-- �ŏI�y�[�W
set pageCount to 1

-- �y�[�W�߂������
-- 1:���߂���
-- 2:�E�߂���
set pageDirection to 1

-- �o�͐�t�H���_
set savepath to ""

-- �L���v�`���ʒu
set x to 0
set y to 0
set cWidth to 0
set cHeight to 0

-- -----------------------------------------
-- config �t�@�C������
-- -----------------------------------------
-- �J�����g�f�B���N�g���p�X�̎擾
tell application "Finder"
	set tmpP to folder of (path to me) as Unicode text
	set p to get POSIX path of tmpP
end tell

-- config.txt �̐ݒ�l��ǂݏo��
set configPath to p & "config.txt"
set s to ""
open for access configPath
try
	set s to read configPath before return
end try
close access configPath

-- config.txt �̐ݒ�l���擾
set ls to splitWord(s, ",")

-- �e�ݒ�l�̎擾
set pageCount to (item 2 of splitWord(item 1 of ls, "="))
set pageDirection to (item 2 of splitWord(item 2 of ls, "="))
set x to (item 2 of splitWord(item 3 of ls, "="))
set y to (item 2 of splitWord(item 4 of ls, "="))
set cWidth to (item 2 of splitWord(item 5 of ls, "="))
set cHeight to (item 2 of splitWord(item 6 of ls, "="))
set savepath to savepath & (item 2 of splitWord(item 7 of ls, "="))

-- delimit �ŃX�v���b�g���������񃊃X�g��Ԃ�
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
-- �o�͐�t�H���_���쐬
-- -----------------------------------------
set cmd to ("mkdir " & savepath)

display dialog "�o�͐�t�H���_ : " & savepath

try
	do shell script cmd
on error
	display dialog "�o�͐�t�H���_�����ɑ��݂��邽�ߏ����𒆒f���܂�"
	return
end try

-- -----------------------------------------
-- Kindle ���I�[�v��
-- -----------------------------------------

-- �y�[�W�߂���L�[�̐ݒ�
if pageDirection = 1 then
	-- ���L�[
	set keyChar to (ASCII character 28)
else
	-- �E�L�[
	set keyChar to (ASCII character 29)
end if

-- Kindle �A�v���P�[�V�������A�N�e�B�u
set target to "Kindle"
if target is not "" then
	tell application target
		activate
	end tell
end if

-- -----------------------------------------
-- pageCount �܂ŃX�N�V��
-- -----------------------------------------
repeat with i from 1 to pageCount
	set out to (savepath & "p_" & i & ".png")
	delay 1.0
	do shell script "screencapture -R " & x & "," & y & "," & cWidth & "," & cHeight & " " & out
	tell application "System Events"
		keystroke keyChar
	end tell
end repeat

display dialog "���s����"