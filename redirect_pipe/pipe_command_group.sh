#!/usr/bin/env bash

echo '### pipe / コマンドグループ ###'

# pipe
# pipeの仕組みについては「[徹底解説] Linux パイプのしくみ」が参考になる
# https://haystacker.net/linux-pipe-deep-dive/

# スクリプトの中でもpipeは普通に使える

# コマンド展開を使わないと、期待した結果が得られない
echo ls /usr/bin | grep 'pod' | wc -l

# 結果を得たい場合はコマンド展開を使う
echo $(ls /usr/bin | grep 'pod' | wc -l)

# 改行することもできる
result=$(
  ls /usr/bin |
  grep 'pod' |
  wc -l
)
echo $result

# コマンドのグループ化

# date +%Y-%m-%d > result.txt
# echo '/usr list' >> result.txt
# ls /usr >> result.txt

# {}でコマンドを囲んで１つにまとめることができる
{
  date +%Y-%m-%d > result.txt
  echo '/usr list' >> result.txt
  ls /usr >> result.txt
} > result.txt

# 1行で書く場合は[;]でコマンドを区切る
# (最後のコマンドにも[;]が必要なことに注意！)
{ date +%Y-%m-%d > result.txt; echo '/usr list' >> result.txt; ls /usr >> result.txt; } > result.txt

# 子プロセス(サブシェル)を起動してコマンドを実行する場合は()で囲む
(
  date +%Y-%m-%d > result.txt
  echo '/usr list' >> result.txt
  ls /usr >> result.txt
) > result.txt

# {}の場合は子プロセスを起動しないので、{}内の処理がその側に影響する
current=$PWD
name=hoge
cd ~
{
  name=fuga
  cd /usr
}
echo $name    #=> fuga
echo $PWD     #=> /usr

# ()の場合は外側には影響しない
name=hoge
cd ~
(
  name=fuga
  cd /usr
)
echo $name    #=> hoge
echo $PWD     #=> $HOME

# {}の場合
# - {の後にスペースが必要
# - 最後のコマンドにも;が必要
#
# ()の場合
# - (の後にスペースは必要ない
# - 最後のコマンドには;は必要ない

# cleanup
cd $current
rm result.txt
