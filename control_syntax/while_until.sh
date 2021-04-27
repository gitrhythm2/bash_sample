#!/usr/bin/env bash

# while文の構造
# while コマンド
# do
#   処理
# done

echo 'while'
i=0
while [[ $i -lt 10 ]]; do
  echo "$i"
  i=$((++i))
done

# untilの場合はブレイクの条件をどれにするかで迷う
# ので使いづらい
echo -e '\n'
echo 'untile'
i=0
until [[ $i -ge 10 ]]; do
#until [[ $i -gt 9 ]]; do
#until [[ $i -eq 10 ]]; do
  echo "$i"
  i=$((++i))
done

# コマンド出力の結果を1行ずつ処理するパターン
# コマンドの出力をpipeでつないでwhileループに渡す方法
# この方法の場合、ループ内はサブシェルが起動しているようで、外側で定義したresult
# の値にアクセスできない模様
#
# 以下のようにループ内でresultに値をセットしても、ループの外で表示すると0になっている
# (ループ内ではちゃんとインクリメントされている)
# pidを確認してみると、$$はループ内も外も同じ値
# BASHPIDはループ内と外では異なっている
# この辺りの値の違いは[シェルスクリプトでサブシェルのプロセスIDを取る方法](https://rcmdnk.com/blog/2014/01/20/computer-bash/)
# で実験しているが、BASHPIDは異なるのと、ループの外で定義したresultの値が更新されないので、
# whileループはサブシェルで実行されているのだと思う。
result=0
du ~/.config | while read line; do
  ((++result))
  echo "result[$result]"
  echo "\$\$[$$]"
  echo "bashpid:[$BASHPID]"
done

echo "---ループ外---"
echo "result[$result]"
echo "\$\$[$$]"
echo "bashpid:[$BASHPID]"
