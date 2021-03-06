;; インストール設定　してなかったらインストールする
(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))

;;参考：http://qiita.com/bussorenre/items/bbe757ef87e16c3d31ff
;;
;; Auto Complete
;;
;; auto-complete-config の設定ファイルを読み込む。
(require 'auto-complete-config)

;; よくわからない
(ac-config-default)

;; TABキーで自動補完を有効にする
(ac-set-trigger-key "TAB")

;; auto-complete-mode を起動時に有効にする
(global-auto-complete-mode t)

