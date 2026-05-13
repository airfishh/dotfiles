;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(require 'use-package)

;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;;(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

;; START MENU CONFIG
;; (setq fancy-splash-image (concat "~/Downloads/Wallpapers/catviolin.jpg"))

;; `gruvbox-material' contrast and palette options
(setq doom-gruvbox-material-background  "medium"  ; or hard (defaults to soft)
     doom-gruvbox-material-palette     "material") ; or original (defaults to material)

;; `gruvbox-material-light' contrast and palette options
(setq doom-gruvbox-material-light-background  "medium" ; or hard (defaults to soft)
      doom-gruvbox-material-light-palette     "mix") ; or original (defaults to material)

;; set `doom-theme'
(setq doom-theme 'doom-gruvbox-material) ; dark variant
;;(setq doom-theme 'doom-gruvbox-material-light) ; light variant

(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam")
(after! org
  (setq org-agenda-files '("~/org/Agenda.org")))

;; BABEL
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; Make deleted files go to the trash can
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files")

;; Set splash screen
(setq fancy-splash-image (concat "~/Downloads/doom-logos/doom3.iconset/icon_256x256.png"))

(add-to-list '+doom-dashboard-menu-sections
             '("Open vterm"
               :icon (nerd-icons-octicon "nf-oct-terminal" :face 'doom-dashboard-menu-title)
               :action +vterm/here))

;; Clippy config
(map! :leader
      (:prefix ("c h" . "Help info from Clippy")
        :desc "Clippy describes the function under point" "f" #'clippy-describe-function
        :desc "Clippy describes the variable under point" "v" #'clippy-describe-variable))

;; Typst
(use-package typst-ts-mode
  :ensure t
  :custom
  (typst-ts-watch-options "--open")
  (typst-ts-mode-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory))
  (typst-ts-mode-enable-raw-blocks-highlight t)
  :config
  (keymap-set typst-ts-mode-map "C-c C-c" #'typst-ts-tmenu))

(with-eval-after-load 'eglot
  (with-eval-after-load 'typst-ts-mode
    (add-to-list 'eglot-server-programs
                 `((typst-ts-mode) .
                   ,(eglot-alternatives `(,typst-ts-lsp-download-path
                                          "tinymist"
                                          "typst-lsp"))))))

(use-package typst-preview
  ;; :load-path "path/to/typst-preview.el" ;; if installed manually
  :init
  (setq typst-preview-autostart t) ; start preview automatically when typst-preview-mode is activated
  (setq typst-preview-open-browser-automatically t) ; open browser automatically when typst-preview-start is run

  :custom
  (typst-preview-browser "default") 	; this is the default option; other options are `eaf-browser' or `xwidget'.
  (typst-preview-invert-colors "auto")	; invert colors depending on system theme
  (typst-preview-executable "tinymist") ; path to tinymist binary (relative or absolute)
  (typst-preview-partial-rendering t)   ; enable partial rendering 
  
  :config
  (define-key typst-preview-mode-map (kbd "C-c C-j") 'typst-preview-send-position))

