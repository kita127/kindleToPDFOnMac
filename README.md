# kindleToPngOnMac

<span style="color: red; ">
!!!注意!!!<br>
作成した画像は個人使用の範疇にとどめてください<br>
配布等はしないでださい
</span>

![demo](./images/image1.gif)

## 使用ツール

* Kindle

## 使い方

1. キャプチャした Kindle 本を開く
1. キャプチャを開始したいページを開く
1. キャプチャしたいページの x 座標, y 座標と幅(width)、高さ(height)を計測する
    * 計測方法は覚書のウィンドウサイズ計測を参照
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
1. キャプチャしたいページが表示されている状態でスクリプトを実行する
1. 「実行完了」のダイアログが表示されたらキャプチャ完了

## OCR 対応

### 使用ツール

* Homebrew
* tesseract
* tesseract-lang

### 環境設定

OCR エンジンには tesseract を使用する. 
以下2つのアプリケーションをインストールする. 

    $ brew install tesseract tesseract-lang

### 実行

画像ファイルを OCR スキャンした PDF を生成するコマンド

    $ tesseract ./input.png outname -l eng+jpn pdf

### その他

日本語の精度はあまり高くない. 
「英文」というワードを調べる際は「英 文」のように半角スペースを開けるなどのテクニックが必要そう. 


## 覚書

* ウィンドウサイズ計測
    * Command + Shift + 4
    * はじめにx座標とy座標が表示される
    * 左クリックを押し矩形選択をすると選択した箇所からの width と height が表示される
* PDF への変換
    * finder で PDF にした png ファイルを全て選択する
    * 右クリック → クイックアクション → PDF を作成

## 制限事項

* 実行中は他操作ができません
* 出力先フォルダが既に存在する場合は実行できません

