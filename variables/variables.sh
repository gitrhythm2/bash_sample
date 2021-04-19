#!/usr/bin/env bash

echo '### 変数(Variables) ###'

# 変数に値をセット()=の前後にスペースは入れると引数と解釈されてエラーとなるのでスペースは入れない)
# (hoge.mdを"や'で囲まなくてもいける)
file=hoge.md
# 値を参照するときは$を付ける
echo [$file]      #=> [hoge.md]
# から文字をセットする場合
file=
# 「file=''」でも良いが、「file=」の方が好まれるっぽい
echo [$file]    #=> []
# 未定義の変数を参照してもエラーにはならない
echo [$hoge]    #=> []
# 変数展開と固定文字列を繋げる時は${}で囲う
error=error
echo two ${error}s

echo '### 環境変数(environment variables) ###'

# 環境変数はexportする(一般的に大文字で定義する)
export CONFIG_FILE=/home/user/config.txt
config_file=/home/user/config.txt   # こちらは普通の変数(child.shには引き継がれない)
./child.sh

echo '### declareによる型宣言 ###'
# -r: 読み取り専用
# -i: 整数
# -a: 配列
# -A: 連想配列

echo '-r:読み取り専用例(一般的にはreadonlyの方がよく使われるっぽい)'
declare -r filename1=hoge.md
filename1=fuga.md  #=> エラー
readonly filename2=hoge.md
filename2=fuga.md  #=> エラー

echo '# -i:整数'
# 算術式評価の詳細は[https://linuxjm.osdn.jp/html/GNU_bash/man1/bash.1.html]の
# 算術式評価を参照([id++]で検索すると一発でヒットする)

# 整数型は右辺を数値として扱うので、x,yは整数型でなくても良い
x=1
y=4
declare -i sum=x+y  # $x, $yとする必要はない
echo $sum           #=> 5
str=x+y
# 通常の変数は文字がそのまま入る
echo $str           #=> x+y

echo '# -a:配列'
# declare宣言しなくても()で配列となる
arr=(hoge fuga chome)
declare -a arr=(hoge fuga chome) # こちらでも良い
# 参照する場合は#{}で囲う
echo $arr           #=> hoge(添字を指定しないと0番目となる)
echo $arr[1]        #=> hoge[1] ->0番目+文字列の[1]と解釈される
echo ${arr[1]}      #=> fuga
echo ${arr[@]}      #=> hoge fuga chome
echo ${#arr[@]}     #=> 3 -> #を付けると要素数

echo "unset--->"
unset arr[1]
echo ${arr[@]}      #=> hoge chome
echo [${arr[1]}]    #=> [] -> 空文字
echo ${!arr[@]}     #=> 0 2 -> "!"と付けると値が存在するインデックスを返す

echo 'インデックスを指定することも可能'
arr=(hoge [2]=fuga [4]=chome)
echo ${arr[@]}      #=> hoge fuga chome
echo [${arr[1]}]    #=> [] -> 空文字

echo '@と*の違い'
arr=(hoge fuga chome)
arr2=("${arr[@]}")  # "hoge" "fuga" "chome"に展開される
echo ${arr2[0]}     #=> hoge
arr2=("${arr[*]}")  # "hoge fuga chome"に展開される
echo ${arr2[0]}     #=> hoge fuga chome

echo '# -A 連想配列'
declare -A user=([id]=1 [first_name]=hiroyuki [last_name]=hosokawa)
echo ${user[id]}        #=> 1
echo ${user[@]}         #=> hosokawa 1 hiroyuki -> 全要素を取得するが定義の順番とは限らない
echo ${#user[@]}        #=> 3 -> 要素数
user[id]=2              #=> 値を上書き
echo ${user[id]}        #=> 2
echo "[${user[hoge]}]"  #=> 未定義のものを指定すると空文字(エラーにはならない)

echo "unset--->"
unset user[id]
echo ${user[@]}         #=> hosokawa hiroyuki













