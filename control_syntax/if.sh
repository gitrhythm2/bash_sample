#!/usr/bin/env bash

echo '### if文 ###'

# '['はテストコマンド(type [ や which [で確認できる)
# if [ $value = 1 ] のスペースは必ず必要。
# 例えば'['はコマンドなので、[$value にすると、それが'[$value'と言うコマンドと解釈される
# $value= 1 とすると、$value= と言う変数と解釈される
# [コマンドは引数の最後に']'を求めるので、最後の']'も必須。
# 最後の';'は文の区切りになるので、続けて then を記述可能
# ;を付けずに
#     if [ xxx ]
#     then
#       ...
#     if
# のように行を分けて書くこともできる。が、下記サンプルのように1行で書くのが一般的っぽい

# if文で参照する変数は""で囲った方が良い
# 例えば
#   name=
#   if [ -n $name ]; then
# と書いたとする。
# これは$nameは空なので、展開された結果
#   if [ -n ]; then
# のようになり、常にfalse扱いとなる

# 条件式に指定可能な演算子はbashのmanを参照
# manを開き、
#   ・CONDITIONAL EXPRESSIONS
#   ・-a file
# などでページ内検索するとヒットしやすい

value=1
if [ "$value" = 1 ]; then
  echo 'value = 1'
elif [ "$value" == 2 ]; then
  echo 'value = 2'
else
  echo 'other'
fi

# if文は終了ステータスが0ならば真になるので、終了ステータスを返す
# コマンドを条件式に書くこともできる
if cd .; then
  echo 'true'
else
  echo 'false'
fi

#
# 文字列系
#

# 条件式のバリエーション
# 等しい
if [ a = b ]; then
  echo 'a = a'
fi
if [ a == a ]; then
  echo 'a == a'
fi

# 等しくない
if [ a != b ]; then
  echo 'a != b'
fi

# 辞書順での大小比較
# ※ <,>記号はリダイレクト記号と区別するために[']で囲う。
if [ a '<' b ]; then
  echo " a < b"
fi
if [ b '>' a ]; then
  echo "b > a"
fi

# -z: 空文字である(zero length)
# -n: 空文字ではない(non zero length)
name=' '
# [name=][name='']の場合はnon zero length, [name=' '][name='a']はzero lengthになる
if [ -z "$name" ]; then
  echo "-z: zero length"
else
  echo "-z: non zero length"
fi

if [ -n "$name" ]; then
  echo "-n: non zero length"
else
  echo "-n: zero length"
fi

# 数値系
#  -eq: 等しい(equal to)
#  -ne: 等しく無い(not equal to)
#  -lt: 左辺が右辺より小さい(less than)
#  -le: 左辺が右辺以下(less than or equal to)
#  -gt: 左辺が右辺より大きい(greater than)
#  -ge: 左辺が右辺以上(greater than or equal to)
#
# <,>とか=,!=でも問題なさそうに思うが、数値の比較演算子で
# <=が無いっぽいので、-eqとか-le系を使うのが良いのかな？

declare -i value1=1
declare -i value2=2
if [ $value1 '<' $value2 ]; then
  echo 'ok'
else
  echo 'ng'
fi
if [ $value1 -le $value2 ]; then
  echo 'ok'
else
  echo 'ng'
fi

#
# '[[''
# '[['は'['とは異なり、コマンドではなく条件式の評価専用の構文
# 色々とシンプルに記述できて便利そう
#
echo '*** [[ ]] ***'

# [[]]の中では<,>はクォートしなくても良い(と言うよりしてはいけない)
if [[ 'a' > 'b' ]]; then
  echo 'OK'
else
  echo 'NG'
fi

# 変数もクォートしなくても問題ない
name=
if [[ -n $name ]]; then
  echo "-z: non zero length"
else
  echo "-z: zero length"
fi

# 論理式(&& ||)が[[]]の中で使える
if [[ 3 > 1 && 1 > 0 ]]; then
  echo 'OK'
else
  echo 'NG'
fi
# []の場合はエラーとなる 〜 実行するとファイル"1"が作成してされてしまうので実行はしない
# if [ 3 > 1 && 1 > 0 ]; then
#   echo 'OK'
# else
#   echo 'NG'
# fi

pattern='x??'
# 右辺にパターン文字列を指定できる (OKと表示される)
if [[ 'xxx' == $pattern ]]; then
  echo 'OK'
else
  echo 'NG'
fi
# こちらは$patternは文字列の'x??'に展開sれるので、NGが表示される
if [ xxx == $pattern ]; then
  echo 'OK'
else
  echo 'NG'
fi

# 正規表現
basepath=/home/user
if [[ $basepath =~ ^/home/[^/]+$ ]]; then
  echo 'Match'
else
  echo 'Not match'
fi
# こちらはエラーになる
if [ $basepath =~ ^/home/[^/]+$ ]; then
  echo 'Match'
else
  echo 'Not match'
fi
