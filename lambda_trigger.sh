#!/bin/bash

PARAM1=${1:?} :(fuctionName)
PARAM2=${2:?} :(payloadFilePath)
PARAM3=${3:?} :(executeTime ex 2018-09-01,2018-09-31)

file=${2}
date=${3}

#パラメータが3つあるかチェック
if [ $# -ne 3 ]; then
    echo "入力された引数は$#個です。" 1>&2
    echo "3個の引数が必要です。" 1>&2
    exit 1
fi

#payloadFilePathが存在するかチェック
#jsonかどうかチェックしたい
#$(echo $file | grep .json > /dev/null) ??

if [ ! -e ./$file　 ]; then
    echo "指定されたファイル($file)は存在しません。"
    exit 1
fi

#処理期間が日付形式かチェック
if [ date -d $date > /dev/null 2>&1 | sed -e 's/[^0-9]//g' ]; then
    echo "日付形式ではありません"
    exit
fi

#payloadfileを編集


#payloadfileを出力


