
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

"�󔒂̂���p�X�ł͎g���Ȃ� findfile
let s:save_cpo = &cpo
setlocal cpo&vim
if &ssl == 1 " shellslash�΍�
	let s:split='/'
else
	let s:split='\'
endif

if !exists("*s:JumpLabel")
function s:JumpLabel(line,file)
	let s:labelstart = stridx(a:line, '*')
	let s:labelend = match( a:line, '[ "\]]\|$', s:labelstart) - 1
	let s:storagestart = stridx(a:line,a:file)
	if s:storagestart != -1 " �O���t�@�C���փW�����v
		if a:line =~ 'storage=".*"' " �_�u���N�H�[�g�ň͂܂�Ă��邩
			let s:storagestart += strlen(a:file) + 2
		else
			let s:storagestart += strlen(a:file) + 1
		endif
		let s:storageend = stridx( a:line, '.ks', s:storagestart) + 2
		if a:line !~ '\*' " ���x�����ȗ�����Ă���Ƃ��p
			exe ':e  '.s:kirikiripath.s:split.'scenario'.s:split.strpart(a:line, s:storagestart, s:storageend - s:storagestart + 1)
		else
			exe ':grep ^\'.strpart(a:line, s:labelstart, s:labelend - s:labelstart + 1).' "'.s:kirikiripath.s:split.'scenario'.s:split.strpart(a:line, s:storagestart, s:storageend - s:storagestart + 1).'"'
		endif
	else " ���݃t�@�C���̃��x���փW�����v
		if !search('^\'.strpart(a:line, s:labelstart, s:labelend - s:labelstart + 1).'\>','ws')
			echo '���x���𔭌��o����'
		endif
		unlet! s:storageend
	endif
	unlet! s:labelstart s:labelend s:storagestart
endfunction
endif

if !exists("*s:KirikiriFileOpen")
function s:KirikiriFileOpen(line,file,command,exelist)
	let s:storagestart = stridx(a:line,a:file)
	if a:line =~ a:file.'=".*"' " "�����邩�Ȃ���
		let s:storagestart += strlen(a:file) + 2
	else
		let s:storagestart += strlen(a:file) + 1
	endif
	let s:storageend = match( a:line, '[ \]"]\|$', s:storagestart) - 1
	let s:storagename = strpart(a:line, s:storagestart, s:storageend - s:storagestart + 1)
	
	if s:storagename =~ '\....' " �g���q��3�����O��
		let s:path = findfile(s:storagename, s:kirikiripath.s:split.'**')
	else
		for s:exe in a:exelist
			let s:path = findfile(s:storagename.'.'.s:exe, s:kirikiripath.s:split.'**')
			if strlen(s:path)
				break
			endif
		endfor
	endif
	if !strlen(s:path)
		echo 'path�������o���܂���ł����B'
	else
		if g:kirikiriopen_use_vimproc == 1
			if &ssl == 1
				let s:path = substitute(s:path, '/', '\\\\', 'g')
			else
				let s:path = substitute(s:path, '\\', '\\\\', 'g')
			endif
			" a:command ��'/'�ŋ�؂�Ȃ��Ƃ���
			" vimproc#system�� 'c:/aa/a.exe c:\\test.jpg' �� 'c:\\aa\\a.exe c:\\test.jpg'�ł��������Ȃ�
			exe ':call vimproc#system_bg('''.a:command.' '.s:path.''')'
		else
			" �������̃p�X��\��؂�łȂ��Ƃ���
			exe ":!".a:command.' "'.substitute(s:path, '/', '\\', 'g').'"'
		endif
	endif
	unlet! s:storagestart s:storageend s:storagename s:path
endfunction
endif

if !exists("*s:KirikiriOpen")
function s:KirikiriOpen()
	" expand("%:p:h")�̓t�@�C�����J�����g�h���C�u�ɂ�������h���C�u���^�[
	" �Ȃ��A�������炠��
	let s:kirikiripath = strpart( expand("%:p:h"), 0, strridx(expand("%:p:h"), s:split) )
	let s:line = getline(".")
	if s:line =~ g:kirikiriopen_jump_dict.tag
		call s:JumpLabel(s:line, g:kirikiriopen_jump_dict.file)
	else
		for s:item in g:kirikiriopen_list
			if s:line =~ s:item.tag
				call s:KirikiriFileOpen(s:line,s:item.file,s:item.command,s:item.exelist)
			endif
		endfor
	endif
	unlet! s:line s:kirikiripath
endfunction
endif

if !exists("*s:KirikiriJump")
function s:KirikiriJump() " �t�H�[�J�X�ړ��̊֌W�ŃW�����v�����������B
	" expand("%:p:h")�̓t�@�C�����J�����g�h���C�u�ɂ�������h���C�u���^�[
	" �Ȃ��A�������炠��
	let s:kirikiripath = strpart( expand("%:p:h"), 0, strridx(expand("%:p:h"), s:split) )
	let s:line = getline(".")
	call s:JumpLabel(s:line, g:kirikiriopen_jump_dict.file)
	unlet! s:line s:kirikiripath
endfunction
endif

let &cpo = s:save_cpo
unlet! s:save_cpo

command! -buffer KirikiriOpen :call s:KirikiriOpen()
command! -buffer KirikiriJump :call s:KirikiriJump()
