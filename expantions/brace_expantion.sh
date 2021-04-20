#!/usr/bin/env bash

echo '### ブレース展開(brace expantion) ###'

# {文字列1,文字列2,文字列３}
# {始まり..終わり}

cd data

# file*.{txt,md} - 拡張子がtxtかmd
echo 'file*.{txt,md} => '[$(ls file*.{txt,md})]   #=> file.txt file1〜4.md

# file{1..3}.md - 範囲指定
echo 'file{1..3}.md => '[$(ls file{1..3}.md)]     #=> file1.md file2.md file3.md
# 数値だけじゃなく、file{a..c}のように文字で範囲を指定することも可能

# file{1..4..2}.md - 範囲指定＋増分(1から４までで２つづつ増える)
echo 'file{1..4..2}.md => '[$(ls file{1..4..2}.md)]  #=> file1.md file3.md
