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
if [ ! -e $file ]; then
    echo "$fileは存在しません。"
    exit 1
fi

#処理期間が日付形式かチェック
elif [ `date -d $date > /dev/null 2>&1;` -ne 0 ] ; then
    echo "引数の値は日付ではありません。"
    exit 1
fi