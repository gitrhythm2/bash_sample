#!/usr/bin/env bash

echo '### コマンド置換(command substitution) ###'

# コマンドを実行した際の文字列を展開する
# $()の中にコマンドを記述する

# dateコマンドのフォーマット指定
echo dateコマンドのフォーマット指定: $(date +%Y-%m-%d)         # yyyy-mm-dd
touch $(date +%Y-%m-%d).txt    # 指定したフォーマットでファイルを作成
echo $(ls *.txt)               # yyyy-mm-dd.txt
rm $(date +%Y-%m-%d).txt

# コマンド置換はバッククォートも使える
echo バッククォート: `date +%Y-%m-%d`
