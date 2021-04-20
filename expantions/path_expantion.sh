#!/usr/bin/env bash

echo '### パス名展開(path expantion) ###'

# ?: 任意の1文字
# *: 任意の文字列
# []: []内に含まれるいずれか1文字
# [! ][^ ]: []無いに含まれないいずれか1文字

cd data
# file.? - 任意の1文字にマッチ
echo 'file.? => '[$(ls file.?)]        #=> file.c file.h
# file.??? - 任意の3文字にマッチ
echo 'file.??? => '[$(ls file.???)]    #=> file.txt
# *.txt - 末尾が.txt->.hoge.txtはマッチしない
echo '*.txt => '[$(ls *.txt)]          #=> hoge.txt file.txt
# .*.txt - 先頭の.は'*'や'?'の対象外なので明示的に指定する
echo '.*.txt => '[$(ls .*.txt)]        #=> .hoge.txt

# file.[ch]
echo 'file.[ch] => '[$(ls file.[ch])]  #=> file.c file.h ('c'か'h'。仮にfile.aがあってもマッチしない)
# file[1-3].md
echo 'file[1-3].md => '[$(ls file[1-3].md)] #=> fiel1.md file2.md file3.md (1から3の範囲指定)
# file[!24].md
echo 'file[!24].md => '[$(ls file[!24].md)] #=> file1.md file3.md (2,4以外)

# マッチしない場合は展開前の文字列がそのまま渡される
# aaa.[ch]
echo 'aaa.[ch] => '[$(ls aaa.[ch])]    #=> aaa.[ch]

# []は任意の1文字なので、2文字以上の場合は使えない
# 拡張子がtxtとmdのものをマッチさせたいとしても、[txt md]とかはだめ。
# この場合はブレース展開を使う。{txt,md}