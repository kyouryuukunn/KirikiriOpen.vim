�g���g��/kag�̃V�i���I�t�@�C�����烉�x���W�����v��摜�A�����t�@�C�����J�� 

�K�v�Ȑݒ�
�t�@�C�����J�����߂̐ݒ�
let g:kirikirilist = [
	\{'tag':'���K�\���őΏۂƂ���^�O���w��','file':'���̑����̈����̃t�@�C�����J��','command':'�t�@�C�����J���\�t�g\�ł͂Ȃ�/�ŋ�؂�Ȃ��Ƃ����Ȃ�','exelist': '�t�@�C���̊g���q���X�g'}
	\]

���x���W�����v�̂��߂̐ݒ�Acommand,exelist�͂���Ȃ�
let g:kirikiri_jump_dict = {'tag':'���K�\���őΏۂƂ���^�O���w��','file':'���̑����̈����̃t�@�C�����J��'}

" vimproc���C���X�g�[������Ă��邩�ǂ���
let g:kirikiri_use_vimproc = 1

���x���W�����v�A�t�@�C�����J���R�}���hKirikiriOpen���D���ȃR�}���h�Ƀ}�b�v����
autocmd! BufNew,BufRead *.ks	nnoremap <buffer> <S-K> :KirikiriOpen<CR>

���x���W�����v�݂̂̃R�}���hKirikiriJump���D���ȃR�}���h�Ƀ}�b�v����
autocmd! BufNew,BufRead *.ks	nnoremap <buffer> <C-]> :KirikiriJump<CR>

��
 " vimroc���g���Ȃ�1 ��������DOS��ʂ��J���Ȃ�
let g:kirikiri_use_vimproc = 1

let g:kirikiri_jump_dict = {'tag': 'call\|jump\|link\|button', 'file':'storage'}

let g:kirikirilist = [
	\{'tag':'\<trans\>','file':'rule','command':'e:/soft/XnView/xnview.exe','exelist':['png']},
	\{'tag':'\<image\>\|\<haikei\>\|\<haikei2\>\|\<tr\>\|\<tc\>','file':'storage','command':'e:/soft/XnView/xnview.exe','exelist':['png','jpg','tlg']},
	\{'tag':'\<playse\>\|\<playbgm\>\|\<fadeinbgm\>','file':'storage','command':'e:/soft/MPC-HC.1.6.2.4902.x86/mpc-hc.exe','exelist':['ogg']}
	\]

autocmd! BufNew,BufRead *.ks,*.tjs	set filetype=kirikiri
					\ | nnoremap <buffer> <S-K> :KirikiriOpen<CR>
					\ | nnoremap <buffer> <C-]> :KirikiriJump<CR>


����Ă��邱��
���ݍs��tag�Ō������A���t����tag�ɑΉ�����file�Ɏw�肳�ꂽ�����̈����ɁA
exelist�̊g���q���������ăt�@�C�����������A���t������command�Ɏw�肵���\�t�g
�ŊJ���B

�o�O
�󔒂��܂ރp�X�Ƀv���W�F�N�g�t�H���_������ƊJ���Ȃ� (�󔒂��܂ރp�X�Ńt�@�C��������������@��������Ȃ�)
������=�̊Ԃɋ󔒂�����ƊJ���Ȃ�
windows�ł��������Ȃ�(windows�ł����g��Ȃ��Ǝv������)
�������ɂ��o�O��t

