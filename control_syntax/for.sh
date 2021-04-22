#!/usr/bin/env bash

echo '### for文 ###'

# for文の構造
# for 変数 in 単語リスト
# do
#   処理
# done

basic() {
  arr=(aaa bbb ccc)
  for item in ${arr[@]}
  do
    echo $item
  done

  # for ...; doのように、';'の後にdoを繋げることもできる
  # (shellは;で１つのコマンドが終わったと判断する)
  for item in ${arr[@]}; do
    echo $item
  done

  # 単語リスト部分には配列に展開されるものなら(多分)なんでも指定可能
  for file in *.sh; do
    echo $file
  done
}

parameter() {
  # 引数を表示
  echo 通常形
  for arg in "$@"; do
    echo $arg
  done

  echo '省略形($@は省略できる)'
  for arg; do
    echo $arg
  done
}

break_continue() {
  for num in {1..9}; do
    if [[ $num -eq 3 ]]; then
      echo 'num is 3. continue...'
      continue
    elif [[ $num -eq 5 ]]; then
      echo 'num is 5. break!'
      break
    fi

    echo $num
  done
}

basic
parameter hoge fuga chome
break_continue

