#!/usr/bin/env bash

echo '### case文 ###'

# case文の構造
# case 文字列 in
# パターン1 )
#   処理
#   ;;
# パターン2a | パターン2b )
#   処理
#   ;;
# ...
# esac

file=hoge.txt
case "$file" in
*.txt | *.md)
  echo "$file":'text file'
  ;;
*.zip | *.tar.gz)
  echo "$file":'archive file'
  ;;
*.sh)
  echo "$file":'shell script file'
  ;;
*)
  echo "$file":'other file'
  ;;
esac

# rbenvのラッパーで見られるパターン
command='/home/usr/ruby'
option='/hoge/fuga/chome.rb'

program="${command##*/}"    #=> ruby (パスからディレクトリを除去)
echo "program:[$program]"

for arg in $option; do
  case "$arg" in
  */* )
    basedir=${option%/*}    #=> /hoge/fuga (パスからファイル名を除去)
    echo "basedir:[$basedir]"
    ;;
  esac
done
