#!/usr/bin/env bash

echo '### readコマンド ###'

echo 'スペース区切りでオプションを指定して引数１つで受ける場合'
read input          # 「hoge fuga chome」を入力する
echo "$input"       #=> "hoge fuga chome"

echo 'スペース区切りでオプションを指定して複数の引数で受ける場合'
# 行の区切りはIFS変数に従う
read input1 input2  # 「hoge fuga chome」を入力する
echo "$input1"      #=> hoge
echo "$input2"      #=> fuga chome(残りがinput2)

echo -n 'Input string[q:exit]: '
while read input; do
  if [[ "$input" == 'q' ]]; then
    break
  fi
  echo "$input"
done

echo '[hoge\ fuga\ chome]と入力してみる(1)'
read input1 input2
echo "$input1"    #=> [hoge\ fuga\ chome]
echo "$input2"    #=> []
# [\]がスペースをエスケープしていることになるので、引数の区切りとしてスペースが機能していない
# 因みに、-rがない場合、行末が[\]だと行の終わりと判断されない
# hoge\ fuga\ chome\
# だと、エンターを押してもまだ入力を受け付ける

# -rで[\]をエスケープ無効にできる
echo '[hoge\ fuga\ chome]と入力してみる(2 -r付き)'
read -r input1 input2 input3
echo "$input1"    #=> [hoge\]
echo "$input2"    #=> [fuga\]
echo "$input3"    #=> [chome]
echo "$input4"    #=> [] (入力されていないので空)

# 行頭と行末のスペースはカットされる
echo '行頭と行末にスペースを入れてみる'
read input        # [  hoge  ]
echo "[$input]"   # [hoge]

# スペースも受付たい場合はIFS変数を空にする
echo 'IFSを空にして入力を受け付ける'
ifs_save=$IFS
IFS=
read input          # [   hoge   ]
echo "[$input]"     # [   hoge   ]

IFS=$ifs_save
read input          # [   hoge   ]
echo "[$input]"     # [hoge]
