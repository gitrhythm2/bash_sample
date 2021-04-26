#!/usr/bin/env bash

echo '### ヒアドキュメント ###'

# コマンド << 終了文字列
#   ヒアドキュメントの内容
# 終了文字列

cat << HERE
  ヒアドキュメント
HERE

# 最後の[HERE]の行頭にスペースがあったり、後ろに何かあるとエラーになる

# 行頭にスペース 〜 エラーになる
# cat << HERE
#   ヒアドキュメント 〜 行頭にスペース
#  HERE

# 行末にコメント 〜 エラーになる
# cat << HERE
#   ヒアドキュメント 〜 行末にコメント
# HERE  # コメント

# ヒアドキュメントを変数に代入する場合
doc=$(cat << HERE
  ヒアドキュメントを変数に代入
  2行目はちゃんと改行されるか？
HERE
)
echo "$doc"
# $docを"で囲わないと改行されない
echo $doc

# パラメータ展開、コマンド置換、算術式展開が使える
parameter='パラメータ'
num=$((1))
expand=$(cat << HERE
  算術式展開：num[$((++num))]
  パラメータ展開："$parameter"
  コマンド置換："$(ls .)"
HERE
)
echo "$expand"

# 展開したくない場合は終了文字列をクォートする
not_expand=$(cat << 'HERE'
  算術式展開：num[$((++num))]
  パラメータ展開："$parameter"
  コマンド置換："$(ls .)"
HERE
)
echo "$not_expand"

# ヒアストリング
# <<< を使うと右辺に指定したものを標準入力と見なすことができる
cat <<< 'hoge'
result=$(tr b B <<< 'aaa bbb abab')
echo $result
