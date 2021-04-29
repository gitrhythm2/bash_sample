#!/usr/bin/env bash

echo '### 関数 ###'

# 関数の定義３パターン
# 上から順に処理してくので、関数を呼ぶ前に定義されていなければならない
function f1()
{
  echo 'f1 called.'
}

function f2
{
  echo 'f2 called.'
}

f3() # この形での宣言が一般的っぽい
{
  echo 'f3 called.'
}

f1
f2
f3

# 変数の有効範囲
# 関数の外で定義しても中で定義してもグローバル変数になる
# ローカル変数を定義する場合は[local]を付ける

variable='global1'
func1()
{
  variable='hoge'
  variable_func1='variable_func1'
}

func2()
{
  local variable='fuga'
  local variable_func2='variable_func2'
}

echo $variable
func1
echo $variable        # func1でvariableの値が変更された
echo $variable_func1  # func1で宣言した変数にアクセス可能
func2
echo $variable        # variableの値はそのまま
echo $variable_func2  # func2でlocal宣言された変数にはアクセスできない

# ただしlocalを宣言していても、関数から更に関数を読んだ場合はlocal変数を
# 参照可能

func_child()
{
  # 呼びもとで定義されている場合、値を上書きしてしまうので、
  # 関数内で変数を宣言する場合はlocalを付けるべき。
  parent='child'
}

func_parent()
{
  local parent='parent'
  echo $parent    #=> parent
  func_child
  echo $parent    #=> child
}

func_parent

# 引数渡し
# 引数を渡した場合、受けがわではコマンドライン引数同様、位置パラメータで参照する

print_argument()
{
  echo 'print_argument in'
  echo "\$0: $0"    # $0にはコマンド名(関数名では無い)
  echo "\$1: $1"
  echo "\$2: $2"
  echo "\$3: $3"
  echo "\$#: $#"    #=>3(引数の個数)
  echo "FUNCNAME[0]: ${FUNCNAME[0]}"  # 関数名
  echo "FUNCNAME: ${FUNCNAME[@]}"     # 呼ばれた関数がスタック状に積まれている
}

print_child()
{
  echo "\$1: $1"     #=> 空(mainで引数を渡しても、それが子に引き継がれるわけではない)
  print_argument hoge fuga chome
}

print_parent()
{
  print_child
}

print_parent aaa bbb ccc

# 終了ステータス
# 「return 数値」で終了ステータスを返す
# 数値のみなので、文字列は返せない
# コマンド同様、正常時0、それ以外1が一般的
stat1()
{
  return 0
}

stat1
echo "result: $?"

# 関数で文字列を返したい場合
return_string()
{
  echo '返したい文字列'
}

result=$(return_string)
echo ${result}  #=> 返したい文字列
