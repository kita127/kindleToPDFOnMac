# kindleToPDFForMac

Kindle を OCR 付き PDF に変換する Mac 用のスクリプトです. 

スクリプトは AppleScript, OCR エンジンには tesseract を使用しています. 
OCR 不要の場合は config.txt で無効に設定してください. 無効にした場合は png で出力されます. 
処理速度も上がります. 
png を PDF に変換したい場合は Finder 上で右クリック, 「クイックアクション」の「PDFを作成」から PDF に変換してください. 

<span style="color: red; ">
!!!!!!!!注意!!!!!!!!!!!!!!!!!!<br>
作成した画像は個人使用の範疇にとどめてください<br>
配布等はしないでださい<br>
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<br>
</span>


![demo](./images/image1.gif)

## 使用ツール

* Kindle
* Homebrew
    * パッケージマネージャ
* tesseract
    * OCR エンジン
* tesseract-lang

## インストール

パッケージ管理ツールの Homebrew と OCR エンジンの tesseract が必要です. 
未インストールの場合は以下の手順を参考に環境を構築してください. 

1. パッケージマネージャの Homebrew を導入する
    * 以下のサイトの手順に従い Homebrew を導入する
    * https://brew.sh/index_ja
1. tesseract を導入する
    1. ターミナル(terminal.app)を起動する
    1. 以下のコマンドを実行し `tesseract` と `tesseract-lang` をインストールする

        $ brew install tesseract tesseract-lang


## 使い方

1. 変換したい Kindle 本を開く
1. 開始したいページを開いておく
1. キャプチャしたい範囲を計測する
    * ページの x 座標, y 座標と幅(width)、高さ(height)を計測する
    * ウィンドウサイズ計測方法
        * Command + Shift + 4
        * はじめにx座標とy座標が表示される
        * 左クリックを押し矩形選択をすると選択した箇所からの width と height が表示される
1. config.txt を編集する
    * pageCount
        * キャプチャするページ数
    * pageDirection
        * ページを開く方向
            * 1:左めくり
            * 2:右めくり
    * x
        * x 座標
    * y
        * y 座標
    * width
        * 幅
    * height
        * 高さ
    * savepath
        * 出力先フォルダ
        * 既に存在しているフォルダは指定できません
    * OCR
        * 1:有効
        * 0:無効
    * 注意事項
        * ファイル内の「,」や「=」は消さないでください
        * 前後にスペースは含めないでください
1. `kindleToPDFOnMac.applescript` を開く
1. 「▶」ボタンを押下する
    * 実行中は他操作ができないため注意
1. 「実行完了」のダイアログが表示されたら完了

## その他

### PDF の結合方法

出力した PDF を結合したい場合は, 「プレビュー.app」の機能で結合できます. 

1. 「プレビュー.app」で1ページ目にしたい PDF を開く
1. サムネールを表示する
1. 残りの結合したい PDF ファイルをまとめてドラッグ&ドロップする

## 制限事項

* 実行中は他操作ができません
* 出力先フォルダが既に存在する場合は実行できません
* 日本語の OCR 精度は商用ほど高くはありません
    * 「英文」というワードを調べる際は「英 文」のように半角スペースを開けるなどのテクニックが多少必要です

## 開発者向けの覚書

### OCR

#### 環境設定

OCR エンジンには tesseract を使用する. 
以下2つのアプリケーションをインストールする. 

    $ brew install tesseract tesseract-lang

#### OCR 付き PDF への変換方法

画像ファイルを OCR スキャンした PDF を生成するコマンド

    $ tesseract ./input.png outname -l eng+jpn pdf


