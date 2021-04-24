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
