-- -----------------------------------------
-- �ݒ�l
-- -----------------------------------------
-- �ŏI�y�[�W
set endPage to 471

-- �y�[�W�߂������
-- 1:���߂���
-- 2:�E�߂���
set pageDirective to 2

-- �o�͐�t�H���_
set savepath to "~/work/repo/kindleToPDFOnMac/output/"


-- -----------------------------------------
-- config �t�@�C������
-- ���̏��g�p���Ă��Ȃ�
-- -----------------------------------------
-- display dialog "config �t�@�C����I�����Ă�������"

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
-- �o�͐�t�H���_���쐬
-- -----------------------------------------
set cmd to ("mkdir " & savepath)
do shell script cmd


-- -----------------------------------------
-- Kindle ���I�[�v��
-- -----------------------------------------

-- �y�[�W�߂���L�[�̐ݒ�
if pageDirective = 1 then
	set keyChar to (ASCII character 28)
else
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
-- Kindle ���X�N�V��
-- -----------------------------------------
repeat with i from 1 to endPage
	set out to (savepath & "p_" & i & ".png")
	delay 1.0
	do shell script "screencapture " & out
	tell application "System Events"
		keystroke keyChar
	end tell
end repeat
