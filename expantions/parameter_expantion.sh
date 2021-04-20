#!/usr/bin/env bash

echo '### パラメータ展開(parameter expantion) ###'

# [:-]
# コマンドへの引数のデフォルト値を設定する場合などに使える機能

# [:-] 変数が設定されているかどうか
echo [${name:-hoge}]        # nameは未定義なので値がセットされていない => hoge
name=fuga
echo [${name:-hoge}]        # 値がセットされているのでそれを返す => fuga
name=''
echo [${name:-hoge}]        # 空文字は値がセットされていないと判断される => hoge
name=' '
echo [${name:-hoge}]        # スペースは値がセットされていると判断する => ' '

unset name                # 一旦未定義にする
hoge=hoge2                 # 代入する方の値は変数でもOK

# [-] 変数が未定義かどうか(空文字は未定義ではない)
echo [${name-$hoge}]         # nameは未定義 => 'hoge'
name=fuga
echo [${name-$hoge}]        # 値がセットされているのでそれを返す => "fuga"
name=''
echo [${name-$hoge}]        # 空文字は未定義では無い => ''
name=' '
echo [${name-$hoge}]        # スペースは値がセットされていると判断する => ' '

# [:?] 変数に値が設定されていない場合、標準エラー出力にメッセージを出力してスクリプトを終了する
#
unset name
# [:?]
# メッセージが出力される(スクリプトが終了してしまうのでコメントアウト)
# echo [${name:?Name undefined}]
name=''
# echo [${name:?Name undefined}]  # 空文字もエラー

# [?]
echo [${name?Name undefined}]  # ':?'ではなく'?'は空文字をエラーとみなさない

# [:+] 変数に値が設定されている場合に指定した値に展開する
#
unset name
# [:+]
echo [${name:+'hogehoge'}]    #=> []
name=hoge
echo [${name:+'hogehoge'}]    #=> [hogehoge]
name=''
echo [${name:+'hogehoge'}]    #=> []
echo [${name+'hogehoge'}]     #=> [hogehoge] ':+'じゃなくて'+'の場合は空文字は値が設定されていると判断

# [:] 文字列の切り出し
# ${変数:数値} 先頭を0として、指定された数値から末尾までの文字列を展開する

name=hogefuga
echo [${name:3}]              #=> efuga
# マイナスをして可能(マイナスの場合は末尾からの文字数となる)
# ':-'と区別するために':'の後ろにはスペースが必要
echo [${name: -3}]            #=> uga
echo [${name:2:5}]            #=> gefug(3番目から5文字)

# [#] 文字数を返す
unset name
echo [${#name}]               #=> 0
name=
echo [${#name}]               #=> 0
name=hogefuga
echo [${#name}]               #=> 8

# パターンを指定してマッチした部分を取り除く
# ${変数名#パターン} 〜 前方一致した部分を取り除く(最短一致)
# ${変数名##パターン}   (最長一致)
# ${変数名%パターン} 〜 後方一致した部分を取り除く(最短一致)
# ${変数名%%パターン}   (最長一致)

# [#][##]
filepath=/home/user/conf/config.txt
# 任意の文字の後に/が現れるまで
echo ${filepath#*/}    # home/user/conf/config.txt
echo ${filepath##*/}   # config.txt

# 任意の文字の後に.が現れるまで
filename=hoge.txt.tar.gz
echo ${filename%.*}    # hoge.txt.tar
echo ${filename%%.*}   # hoge

# 配列も展開可能
arr=(hoge.txt.tar.gz fuga.md.org)
echo ${arr[@]%.*}      # hoge.txt.tar fuga.md

# 置換して展開
# ${変数名/パターン/置換文字列} 〜 最短一致
# ${変数名//パターン/置換文字列} 〜 最長一致
filename=hoge.txt.tar.gz
echo ${filename/./_}      # hoge_txt.tar.gz(最短一致)
echo ${filename//./_}     # hoge_txt_tar_gz(最長一致)

# 配も列展開可能
arr=(hoge.txt.tar.gz fuga.md.org)
echo ${arr[@]//./_}      # hoge_txt_tar_gz fuga_md_org

# 前方から最長一致した'.txt.tar.gz'を'.txt'に置換
echo ${filename/.*/.md}   # hoge.md
echo ${filename//.*/.md}  # hoge.md(結果は↑と同じ)

# パターンに#を付けると(/#)、文字列の先頭にマッチした時だけ置換する
uri=ftp://home/user/hoge
echo ${uri/#ftp:/https:}  # https://home/user/home

uri=https://home/user/hoge.txt
# パターンに%を付けると(/%)、文字列の末尾にマッチした時だけ置換する
echo ${uri/%.txt/.html}    # https://home/user/hoge.html

