#!/usr/bin/env bash
# シェル変数(Shell Variables)

# HOME
echo "HOME: ユーザーのホームディレクトリ[${HOME}]"
# PWD
echo "PWD: カレントディレクトリ[${PWD}]"
cd $HOME
echo "     cd $HOME'するとカレントディレクトリも変わる[${PWD}]"
# SHELL
echo "SHELL: ログインシェルのフルパス[${SHELL}]"
# BASH
echo "BASH: 現在動作しているbashコマンドのフルパス[${BASH}]"
# BASH_VERSION
echo "BASH_VERSION: 現在動作しているbashのバージョン'[${BASH_VERSION}]"
# BASH_VERSINFO
echo "BASH_VERSINFO: 読み込み専用の配列(各要素の詳細はmanを参照)[${BASH_VERSINFO[@]}]"
# LINENO
echo "LINENO: 現在実行しているスクリプトの行番号(主にデバッグ用途)[${LINENO}]"
# LANG
echo "LANG: ロケール(地域や言語の指定)[${LANG}]"
# IFS
echo 'IFS: シェルの区切り文字 >ecoh "${IFS}" | od -a'
echo "${IFS}" | od -a
