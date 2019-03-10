(require 'package)

;; (add-to-list 'package-archives
; ;          '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when(not package-archive-contents)
  (package-refresh-contents))

; ; (defvar myPackages
; ;   '(better-defaults
; ;     material-theme))

; ; (mapc '(lambda (package)
; ;             (unless(package-installed-p package)
; ;               (package-install package)))
; ;       myPackages)
; ; BASIC CUSTOMIZATION
; ; --------------------------------------

(setq inhibit-startup-message t)
(load-theme 'material t)
(global-linum-mode t);; enable line number globally

                                        ;; rectangular selection
(cua-mode t)
(setq cua-enable-cua-keys nil);; disable making back-up file
(setq make-backup-files nil);; active save history mode and keep 500 history records
(savehist-mode 1)
(setq history-length 500); ; SETUP PYTHONMODE
                                        ;; ---------------------------------------

; ; (defvar myPackages
; ;   '(better-defaults
; ;     elpy ; ; add elpy package
; ;     material-theme))

; ; active auto-complete by jedi

;; (defvar myPackages
;;   '(better-defaults
;;     smartrep; ; add smartrep package
;;     material-theme))


; ; setup indent hiright
;;(set-face-background 'highlight-indentation-face "#313131")
;;(set-face-background 'highlight-indentation-current-column-face "#777777")

;; (setq twittering-curl-program "/usr/bin/curl")

; ; init.el ends here

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

(require 'package)

; ; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

; ; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

; ; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)

; ; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

; ; 初期化
(package-initialize)
(exec-path-from-shell-initialize)


;; (setq jedi: setup-keys nil)
;; (setq jedi: tooltip-method nil)
;; (autoload 'jedi: setup "jedi" nil t)
;; (add-hook 'python-mode-hook 'jedi: setup)
;; (setq jedi: complete-on-dot t)

; (jedi: setup)
; ; (define-key jedi-mode-map (kbd "<C-tab>") nil); ; C-tabはウィンドウの移動に用いる
; (setq jedi: complete-on-dot t)
; (setq ac-sources;;      (delete 'ac-source-words-in-same-mode-buffers ac-sources)); ; jediの補完候補だけでいい
; (add-to-list 'ac-sources 'ac-source-filename)
; (add-to-list 'ac-sources 'ac-source-jedi-direct)
; (define-key python-mode-map "\C-ct" 'jedi: goto-definition)
; (define-key python-mode-map "\C-cb" 'jedi: goto-definition-pop-marker)
; (define-key python-mode-map "\C-cr" 'helm-jedi-related-names)

; (require 'py-autopep8)
; (setq py-autopep8-options '("--max-line-length=200"))
; (setq flycheck-flake8-maximum-line-length 200)
; (py-autopep8-enable-on-save)


; ; tabにスペースを使用する
(setq default-tab-width 2); ; non display menu bar
(menu-bar-mode 0); ; non display tool bar
(tool-bar-mode 0); ; 列数を表示
(column-number-mode t); ; カーソルの点滅をやめる
(blink-cursor-mode 0); ; カーソル行をハイライト
(global-hl-line-mode 1); ; 対応するカッコを光らせる
(show-paren-mode 1); ; スクロールを１行ずつ
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-save-buffers-enhanced undo-tree sql-indent py-autopep8 material-theme jedi flymake-python-pyflakes exec-path-from-shell elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(add-hook 'post-command-hook 'flymake-show-help); ; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8); ; スタートアップメッセージを表示させない
(setq inhibit-startup-message t); ; バックアップファイルを作成させない
(setq make-backup-files nil); ; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)


(global-undo-tree-mode)
(setq auto-save-buffers-enhanced-interval 1)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; keybind
(setq scroll-conservatively 1); ; Ctrl-K with no kill
;; Ctrl-K with no kill
(defun delete-line-no-kill ()
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
  (delete-char 1)
  (open-line 1)
)
(global-set-key (kbd "C-k") 'delete-line-no-kill)
(defun delete-line-prior-to-cursor()
  (interactive)
  (delete-region
   (point)
   (save-excursion (smarter-move-beginning-of-line 1) (point)))
  (delete-char 1)
  (open-line 1)
  )
(global-set-key (kbd "C-s") 'delete-line-prior-to-cursor)


(global-set-key (kbd "C-x C-o") 'other-window)
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;; Ctrl aで行頭へ
(defun smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)


;; Python
(add-hook 'elpy-mode-hook 'highlight-indentation-current-column-mode)
(elpy-enable)
; ; (elpy-use-ipython)
(setq elpy-rpc-backend "jedi")
;; (setq jedi: complete-on-dot t)
; ; (setq jedi: use-shortcuts t)

; ; active flycheck instead of flymake
(when(require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(flymake-mode t)
;; errorやwarningを表示する
;;(require 'flymake-python-pyflakes)

(add-hook 'find-file-hook 'flymake-find-file-hook)
(when(load "flymake" t)
  (defun flymake-pyflakes-init()
    (let * ((temp-file(flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file(file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list $HOME/.pyenv/shims/pyflakes(list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init))); show message on miniloa-buffer
(defun flymake-show-help()
  (when(get-char-property(point) 'flymake-overlay)
    (let((help(get-char-property(point) 'help-echo)))
      (if help(message "%s" help)))))

;;(flymake-python-pyflakes-load)
