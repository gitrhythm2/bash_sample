#!/usr/bin/env bash

echo '### 関数/組み込み関数 ###'

# :(ヌルコマンド), true, false
# :とtrueは終了ステータス0を返す以外は何もしない
# falseは終了ステータス1を返す
#
# 無限ループを作る際などに:は使われる
# while :; do
#   echo 'hoge'
#   sleep 1
# done

# printf 〜 Cと同じような感覚でprintfが使える
name='Taro Yamada'
age=20
printf "name[%s] age[%d]\n" "$name" "$age"

# command / builtin
# basshのコマンド探索の優先順位は、
# 1. エイリアス
# 2. 予約後
# 3. 関数
# 4. 組み込みコマンド
# 5. 実行可能ファイル
#
# 例えばpsと言う関数を定義すると、psを呼び出した際にコマンドのpsより関数のpsが優先される

ps()
{
  echo 'ps'
}

echo $(ps)

# コマンドのpsを呼びたい場合はcommnadを使う
# commandは組み込みコマンド、実行可能ファイルからコマンドを探す
echo $(command ps)

# builtinは組み込みコマンドからだけ探す
echo $(builtin pwd)

# set
# setは3通りの機能がある
# 1. シェル変数一覧
#    引数を指定せずに呼び出すと、現在設定されているシェル変数の一覧を表示する
# echo $(set)
# 2. シェルのオプションの有効・無効
#    set -o xxx 〜 xxxを有効にする
#    set +o xxx 〜 xxxを無効にする
#    具体的なオプションはman bashを参照[https://linuxjm.osdn.jp/html/GNU_bash/man1/bash.1.html]
#    ※ 「-o option-name」とかでページ内検索すると見つけやすい
#    「set -o」でオプションのon/offを確認できる
#    ==> e u v x などのオプションはデバッグで良く使う
# 3. 位置パラメータの値を更新する
#    位置パラメータは通常の代入はできないのでsetコマンドで値を変更する
#    パラメータを解析してその結果で上書きするような場合に使われる

set_func()
{
  echo "[$1][$2][$3]"     #=> hoge fuga chome
  set 111 222 333
  echo "[$1][$2][$3]"     #=> 111 222 333
  # setコマンドのオプションと被るような場合は先頭に---を付ける(これを付けるとsetのオプションとは認識されない)
  set -- -v -x -u
  echo "[$1][$2][$3]"     #=> -v -x -u
}

set_func hoge fuga chome

# unset
# unsetは定義済みのシェル変数を削除する
name='Taro Yamada'
echo "$name"
unset name
echo "$name"

# 但しreadonlyの変数は削除できない
readonly age=20
echo "$age"
unset age       #=> エラー： 「unset: age: 消去できません: variable は読み取り専用です」

# name=      : 空文字がセットされている状態
# unset name : 変数がundefined
# この違いはパラメータ展開の[-]で違いが出てくる
# [-]は、変数が未定義かどうか(空文字は未定義ではない)を判断するので、
name=
echo [${name-hoge}]         # nameは未定義じゃない => ''
unset name
echo [${name-hoge}]         # nameは未定義 => 'hoge'

# unsetは関数も削除できる
hello()
{
  echo 'Hello!'
}

hello
unset hello
hello           # エラー 『hello: コマンドが見つかりません」
