;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(require 'use-package)

;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;;(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

;; START MENU CONFIG
;; (setq fancy-splash-image (concat "~/Downloads/Wallpapers/catviolin.jpg"))

;; Keybinds
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)


;; `gruvbox-material' contrast and palette options
(setq doom-gruvbox-material-background  "medium"  ; or hard (defaults to soft)
     doom-gruvbox-material-palette     "material") ; or original (defaults to material)

;; `gruvbox-material-light' contrast and palette options
(setq doom-gruvbox-material-light-background  "medium" ; or hard (defaults to soft)
      doom-gruvbox-material-light-palette     "mix") ; or original (defaults to material)

;; set `doom-theme'
(setq doom-theme 'doom-gruvbox-material) ; dark variant
;;(setq doom-theme 'doom-gruvbox-material-light) ; light variant

;; ORG
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam")
(setq org-agenda-files '("~/org/"))
(after! org
  (setq-default org-display-custom-times t)
  (setq org-time-stamp-custom-formats '("<%a %e %b %Y>" . "<%a %e %b %Y %H:%M>")))

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

;; PDF
(setq evil-initial-state-alist '((pdf-view-mode . emacs)))

;; Latex
(use-package org-latex-preview
  :config
  ;; Increase preview width
  (plist-put org-latex-preview-appearance-options
             :page-width 0.8)

  ;; ;; Use dvisvgm to generate previews
  ;; ;; You don't need this, it's the default:
  ;; (setq org-latex-preview-process-default 'dvisvgm)
  
  ;; Turn on `org-latex-preview-mode', it's built into Org and much faster/more
  ;; featured than org-fragtog. (Remember to turn off/uninstall org-fragtog.)
  (add-hook 'org-mode-hook 'org-latex-preview-mode)

  ;; ;; Block C-n, C-p etc from opening up previews when using `org-latex-preview-mode'
  ;; (setq org-latex-preview-mode-ignored-commands
  ;;       '(next-line previous-line mwheel-scroll
  ;;         scroll-up-command scroll-down-command))

  ;; ;; Enable consistent equation numbering
  ;; (setq org-latex-preview-numbered t)

  ;; Bonus: Turn on live previews.  This shows you a live preview of a LaTeX
  ;; fragment and updates the preview in real-time as you edit it.
  ;; To preview only environments, set it to '(block edit-special) instead
  (setq org-latex-preview-mode-display-live t)

  ;; More immediate live-previews -- the default delay is 1 second
  (setq org-latex-preview-mode-update-delay 0.25))
