vimで吉里吉里/kagのシナリオファイルから吉里吉里本体の起動、ラベルジャンプや画像、音声ファイルを開く 

必要な設定
外部grepが必要

ファイルを開くための設定
let g:kirikiriopen_list = [
	\{'tag':'正規表現で対象とするタグを指定','file':'この属性の引数のファイルを開く','command':'ファイルを開くソフト\ではなく/で区切らないといけない','exelist': 'ファイルの拡張子リスト'}
	\]

ラベルジャンプのための設定、command,exelistはいらない
let g:kirikiriopen_jump_dict = {'tag':'正規表現で対象とするタグを指定','file':'この属性の引数のファイルを開く'}

" vimprocがインストールされているかどうか
let g:kirikiriopen_use_vimproc = 1

ラベルジャンプ、ファイルを開くコマンドKirikiriOpenを好きなコマンドにマップする
autocmd! BufNew,BufRead *.ks	nnoremap <buffer> <S-K> :KirikiriOpen<CR>

ラベルジャンプのみのコマンドKirikiriJumpを好きなコマンドにマップする
autocmd! BufNew,BufRead *.ks	nnoremap <buffer> <C-]> :KirikiriJump<CR>

吉里吉里本体を起動するコマンドKirikiriExeを好きなコマンドにマップする
autocmd! BufNew,BufRead *.ks	nnoremap <buffer> <F5> :KirikiriEXe<CR>

例
 " vimrocを使うなら1 いちいちDOS画面が開かない
let g:kirikiriopen_use_vimproc = 1

let g:kirikiriopen_jump_dict = {'tag': 'call\|jump\|link\|button', 'file':'storage'}

let g:kirikiriopen_list = [
	\{'tag':'\<trans\>','file':'rule','command':'e:/soft/Vix/vix.exe','exelist':['png']},
	\{'tag':'\<image\>\|\<haikei\>\|\<haikei2\>\|\<tr\>\|\<tc\>','file':'storage','command':'e:/soft/Vix/vix.exe','exelist':['png','jpg','tlg']},
	\{'tag':'\<playse\>\|\<playbgm\>\|\<fadeinbgm\>','file':'storage','command':'e:/soft/MPC-HC.1.6.2.4902.x86/mpc-hc.exe','exelist':['ogg']}
	\]

autocmd! BufNew,BufRead *.ks,*.tjs	set filetype=kirikiri
					\ | nnoremap <buffer> <S-K> :KirikiriOpen<CR>
					\ | nnoremap <buffer> <C-]> :KirikiriJump<CR>
					\ | nnoremap <buffer> <F5>  :KirikiriExe<CR>


やっていること
現在行をtagで検索し、見付けたtagに対応するfileに指定された属性の引数に、
exelistの拡張子をくっつけてファイルを検索し、見付けたらcommandに指定したソフト
で開く。

バグ
フォルダ構成が次のようであることを前提
-----data----scenario
   |	   |
   |       |-image
   |       |
   |	   |-fgimage
   |	   |
   |	 ~~~~~
   |     ~~~~~
   |
   |--krkr.eXe

空白を含むパスにプロジェクトフォルダがあると開けない (空白を含むパスでファイルを検索する方法が分からない)
属性と=の間に空白があると開けない
windowsでしか動かない(windowsでしか使わないと思うけど)
多分他にもバグ一杯


ビュアーにはVixがお勧め。多重起動が防げてtlgが読める。
また、autohotkeyや窓使いの憂鬱でKirikiriOpenコマンドをラップすればフォーカスをすぐにvimに戻せる。
