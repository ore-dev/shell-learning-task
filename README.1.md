# shell-learning-task
shellの課題学習用リポジトリ

<h2>課題</h2>

~~~~~
workflow過去データ集計用lambda起動シェルの作成			
~~~~~

<h2>ゴール</h2>

- [ ] 作成したソースコードのレビュー完了
- [ ] テストエビデンスのレビュー完了	


<h2>ストーリー</h2>

- [ ] ～2018/10/28(日)：パラメータ取得及びチェック処理を作成、レビュー完了
- [ ] ～2018/11/4(日)：payloadfileを編集・出力処理を作成、レビュー完了
- [ ] ～2018/11/11(日)：Lambadaをコールする処理を作成、レビュー完了
- [ ] ～2018/11/18(日)：テスト完了、現場にて実運用



<div style="page-break-before:always"></div>

<h2>ツール概要</h2>

<img alt=”figure1” src=.\figure1.png />

~~~~~
シェルのパラメータに指定したLambda,payloadFilePath,処理期間
を基に、payloadを編集してLambdaをコールする。

【使用方法,効果】
WorkFlow起動用lambdaに処理期間を指定してコールすることで
yamlfaileの指定やpayloadの再設定することなく過去データの作成処理起動が可能となる。
（payloadFileの編集処理を改修することで汎用化も可能）
~~~~~

<h2>機能</h2>

~~~~~
payloadFileの処理期間を編集してLambdaコール用に出力する。
出力したpayloadFilePathを指定してLambdaをコールする。
Lambda,payloadFilePath,処理期間はパラメータにて指定可能とする。
~~~~~

<div style="page-break-before:always"></div>

<h2>機能詳細</h2>

<h6>lambda_trigger.sh</h6>

~~~~~
１．パラメータを取得する。
    a.FunctionName
        (ex:workflow起動用lambda)		
    b.payloadFilePath		
    c.処理期間
        format : from[yyyy-mm-dd],to[yyyy-mm-dd]
        (ex:2018-09-01,2018-09-31)
    
    ~チェック~
    下記の場合エラーメッセージを表示し終了すること
    ・パラメータ数<>3
    ・payloadFilePathが存在しない
    ・処理期間が日付でない

２．payloadfileを編集・出力する。			
    a.項番１.bからpayload情報を読み込む
    b.読み込んだ情報の処理期間を編集する
        編集方法：
            fromDate ：項番１.cのfrom
            toDate ：項番１.cのto
            executeDate ：項番１.cのfrom
            targetWindow ：項番１.cのfromと項番１.cのtoの日数差
    c.編集した情報を出力する。	
        出力先：./payload
        出力ファイル名：input_yyyymmddhhmmss.txt

３．Lambadaをコールする。
    a.項番１.aのlambdaについて起動する。		
    【起動方法】	
        aws cli
    【payload】	
        項番２.cで出力したpayloadFilePath
~~~~~

<h6>payload.json</h6>

~~~~~
format:
{
	"Dummy1": "value1",
	"Message":"{\"properties\": {\"toDate\": \"YYYY-MM-DD\", \"executeDate\": \"YYYY-MM-DD\", \"fromDate\": \"YYYY-MM-DD\"}, \"targetWindow\": \"99\"}",
	"Dummy2": "value3"
}
~~~~~


<h2>テスト</h2>

~~~~~
１．エラーが発生した場合、エラーメッセージが出力され処理が中断されること。
２．fromDateとtoDateに指定した日付の差分日数が正しく出力されること。
３．パラメータで指定したpayloadファイルが./paylaod/配下に出力されること。
４．出力されたpayloadファイルのフォーマットが[input_yyyymmddhhmmss.txt]であること。
５．Lambdaがコールされ、編集したpayloadが渡されていること。
~~~~~

<h2>補足</h2>

~~~~~
・現場lambdaのパラメータ情報は持ち出せないため
　payload情報のfromDate/toDate/executeDate/targetWindow以外は開発時Dummyとしてください。
　現場でDummyの箇所を実データに置き換えて検証してください。
・テスト項目４はaws環境が準備できない場合は、現場開発環境のlambdaにて検証してください。
・作成したソースコードはgithubにて管理してください。
~~~~~

<h2>~参考資料~</h2>

- jsonファイルの読み込み方法
  https://qiita.com/wnoguchi/items/70a808a68e60651224a4		

- lambda実行方法
  https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-userapp-walkthrough-custom-events-invoke.html

- gitインストール
  https://eng-entrance.com/git-install

- git-ssh設定
  https://qiita.com/shizuma/items/2b2f873a0034839e47ce
  
