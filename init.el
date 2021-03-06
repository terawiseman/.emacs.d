;;; init.el ---                                      -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Shotaro Yahara

;; Author: Shotaro Yahara <s_yahara@geishatokyo.com>
;; Keywords: 

;;package.elをとりあえず読み込む

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(require 'cl)

;;ファイル分割;;
;;ファイル分割の指針参考：http://qiita.com/akisute3@github/items/7dce94f770e6f3f0b26c
;;(require 'init-loader-x "~/.emacs.d/elisp/auto-install/init-loader-x")
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

;; emcas-clientが起動してないならさせる。
;; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; .emacsのファイル構成は以下の通り
;;~/.emacs.d
;;├── elisp/
;;│   ├── auto-install/                ;auto-installでinsatallしたファイルの保存先
;;│   ├── hand-install/                ;自分で拾ってきたファイルの保存先
;;│   └── work/                        ;自作elisp用
;;├── elpa/                            ;package.elでinstallしたファイルの保存先
;;├── template/                        ;各フォーマットのテンプレート置き
;;│   |                                ;（将来的に拡張してこっから自動コピーしたい）
;;│   └── xyz_template.el              ;inits/　に置くようのelファイルのtemplate
;;├── init.el                          ;このファイル
;;├── inits/
;;│   ├── 000_init.el                  ;全体の細々とした設定の設定
;;│   ├── 001_package.el               ;package.elに関する設定ファイル
;;│   ├── 001_autoinstall.el           ;auto-install.elに関する設定ファイル
;;│   ├── 002_command-keymap.el        ;キーバインド全般（以下のファイルで書き換えられる可能性あり）
;;│   ├── 002_frame-keymap.el          ;window,frame関連のキーバインドはここに
;;│   ├── 002_smartchr.el              ;同じキータイプでなんだか別の挙動をしてくれる。
;;│   ├── 002_sequential_command.el    ;同じコマンドを連続して実行するとなんだか別の挙動をしてくれる。
;;│   ├── 003_emacsclient.el           ;外部からemacsを開くときに現在開いているemacsを開く
;;│   ├── 010_eshell.el                ;eshellの設定あれこれ
;;│   ├── 010_eshell_alias.el          ;eshellのalias設定
;;│   ├── 010_eshell-prompt-extras.el  ;eshell上にgitの現在ブランチを表示する
;;│   ├── 011_scrach.el                ;scrach関連の設定あれこれ
;;│   ├── 012_dired.el                 ;dired関連の設定あれこれ
;;│   ├── 021_dsvn.el                  ;dsvnの設定
;;│   ├── 022_magit.el                 ;magitの設定
;;│   ├── 031_auto-complete.el         ;auto-completeの設定
;;│   ├── 031_company.el               ;companyの設定
;;│   ├── 032_flycheck.el              ;flycheckoの設定
;;│   ├── 033_anzu.el                  ;anzuの設定
;;│   ├── 040_helm.el                  ;helmの設定
;;│   ├── 041_helm-ag.el               ;helm-agの設定
;;│   ├── 051_undo-tree.el             ;undo-treeの設定
;;│   ├── 052_auto-highlight-symbol.el ;シンボルをハイライトつけてくれる
;;│   ├── 053_yasnippet.el             ;yasnippetの設定
;;│   ├── 220_yatex.el                 ;yatexモードの設定あれこれ
;;│   ├── 300_org-mode.el              ;org-modeの設定あれこれ
;;│   ├── 310_org2blog.el              ;org2blogの設定あれこれ
;;│   ├── 311_xml-rpc.el               ;xml-rpcの設定あれこれ
;;│   ├── 319_hlkt-blog.el             ;hlkt-blogの設定あれこれ
;;│   ├── 410_twittering-mode.el       ;twitteringモードの設定あれこれ
;;│   ├── 550_csharp-mode.el           ;csharpモードの設定あれこれ
;;│   ├── 551_omnisharp.el             ;ominisharpの設定あれこれ
;;│   ├── 720_ruby-mode.el             ;ruby-modeの設定
;;│   ├── 721_ruby-electric.el         ;括弧やdo endなどの自動補正
;;│   ├── 721_ruby-block.el            ;endに対応する行を光らせる
;;│   ├── 721_rcodetools.el            ;るびきちさん作の開発ツール群
;;│   ├── 723_robe.el                  ;robe-modeの設定　補完、ドキュメント参照、定義ジャンプなど
;;│   ├── 723_robocop-mode.el          ;robocop-modeの設定 コーディングスタイルのチェック
;;│   ├── 723_ruby-lint.el             ;ruby-lintの設定
;;│   ├── 730_scala-mode.el            ;scala-modeの設定
;;│   ├── 731_ensime.el                ;scala用の構文チェックや型を利用した補完をしてくれるらしい
;;│   ├── 740_php-mode.el              ;php-modeの設定
;;│   ├── 741_php-completion.el        ;php-completionの設定
;;│   ├── 750_js2-mode.el              ;js2-modeの設定
;;│   ├── 751_typescript-mode.el       ;typescript-modeの設定
;;│   ├── 751_tss.el                   ;tssの設定
;;│   ├── 990_init.el                  ;起動時の環境設定あれこれ
;;│   ├── 990_mode.el                  ;メジャーモード、マイナーモード関連の設定あれこれ
;;│   └── 999_overriding-minor-mode-keymap.el   ;全てのモードで割り当てたいキーはここに　
;;└──
;;
;; inits/　以下の命名規則 どうせそのうちうやむやになる。（笑
;; abc: a:メジャーモード　b:マイナーモード　c:その中で細分化した入りしなかったり
;; 読み込み順はファイル名頭の二桁の数字らしいよ！（3桁目は意味がない…と思われる）
;;
;; 0xx:モードに対して横断的に使用するものは0xx
;;; 00x:モード関係なく使いたいものなんかはこの辺に置いておく感じで
;;;; 000:環境構築の機能
;;;; 001:パッケージインストール
;;;; 002:キーバイント関連
;;;; 003:emacs-client関連
;;
;;; 01x:*~~~* で表示されるバッファー関連の設定
;;;; 010:eshell関連
;;;; 011:scrach関連
;;;; 012:dired関連
;;
;;; 02X: ファイル管理ツール関連
;;;; 021:dsvn関連
;;;; 022:magit関連
;;
;;; 03x: 自動補完系
;;;; 031:auto-completeの設定
;;;; 032:flycheckの設定
;;;; 033:anzuの設定
;;
;;; 04x: helm
;;;; 040:helmの設定
;;;; 041:helm-agの設定
;;
;;; 05x: その他便利機能
;;;; 051:undo-treeの設定
;;;; 052:auto-highlight-symbolの設定
;;;; 053:yasnippetの設定
;;
;; 2xx: テキスト編集モード
;;; 20x:テキスト編集モードの全体設定
;;; 21x:markdownモード(半分不完全)
;;; 22x:yatex,yahmlモード
;;;;220:yatexモード
;;
;;; 3xx:org-mode
;;;; 300:org-mode全般
;;;; 310:org2blogの設定
;;;; 311:xml-rpcの設定
;;;; 319:hlkt-blogの設定ファイル
;;
;; 4xx:web関連モード
;;; 40x:eww系全般（予定）
;;; 41x:twittering-mode
;;;; 410:twittering-mode
;;
;; 5xx: CCモードベースはこちら
;;; 50x: モード共通のあれこれ
;;; 51x: Cオンリーモード
;;; 52x: c++オンリーの設定
;;;; 520: c++のみ
;;;; 525: cocos用の設定
;;
;;; 55x:C#向け
;;;; 550:Csharp-mode
;;;; 551:omnisharp
;;
;; 7xx: スクリプト言語関連
;;; 70x:スクリプト関連全般（あるのかは不明）
;;; 71x:prelのために空けとく
;;
;;; 72x:ruby関連
;;;; 720: ruby-mode設定
;;;; 721: 表示・コードリーディング系
;;;; 722: コーディング・リファクタ系
;;;; 723: その他便利ツール系(疲れたのであとで)
;;
;;; 73x:scala関連
;;;; 730: scala-mode
;;;; 731: ensime
;;
;;; 74x:php関連（phpはスクリプト言語なのか？
;;;; 740: php-mode
;;;; 741: php-completion
;;
;;; 75x:JavaScript関連(javascriptはスクリプト言語なのか？)
;;;; 750:Js2-mode
;;;;
;;
;;; 99x:その他モード等々とは別に最後に読んでいきたいファイルとかをこのへんに…
;;;; 990:起動時の環境設定ファイル
;;;; 991:起動時の拡張子ファイルからモードを選択し、切り替える（デフォルト以外の設定）
;;;; 999:最後に読み込みたい動作関連 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(package-selected-packages
   (quote
    (use-package ensime sbt-mode scala-mode auto-install helm-rdefs package yasnippet init-loader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "black" :foreground "#55FF55")))))


;;ちょっと便利な関数をメモ
;;いずれファイルを作ってそこに打ち込む…と思う
;;参考：https://www.emacswiki.org/emacs/AddCommasToNumbers
(defun add-number-grouping (number &optional separator)
  "Add commas to NUMBER and return it as a string.
    Optional SEPARATOR is the string to use to separate groups.
    It defaults to a comma."
  (let ((num (number-to-string number))
        (op (or separator ",")))
    (while (string-match "\\(.*[0-9]\\)\\([0-9][0-9][0-9].*\\)" num)
      (setq num (concat 
                 (match-string 1 num) op
                 (match-string 2 num))))
    num))
