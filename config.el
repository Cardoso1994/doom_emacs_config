;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marco Antonio Cardoso Moreno"
      user-mail-address "marcoacardosom@gmail.com")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq fancy-splash-image "~/.doom.d/img/brain.png")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Fonts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Cascadia Code PL" :size 23 :weight 'normal)
      doom-unicode-font (font-spec :family "CaskaydiaCove Nerd Font")
      doom-variable-pitch-font (font-spec :family "Bookerly"))

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 22 :weight 'normal)
      ;; doom-variable-pitch-font (font-spec :family "Guardi LT Roman"))
      ;; doom-variable-pitch-font (font-spec :family "Lato"))
(setq doom-font-increment 1)
(setq doom-big-font-increment 1)

;; italics for comments and keywords
(custom-set-faces!
  '(font-lock-comment-face :slant italic :weight light)
  '(font-lock-keyword-face :slant italic :weight semi-bold))

;;;;;;;;;;;;;;;;;;;;;;;;
;;   Theme
;;;;;;;;;;;;;;;;;;;;;;;;
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(defun mac/timed-theme (&optional morning-theme night-theme)
  "Change doom-theme depending on time of the day. Runs every hour."
  (let* ((morning-theme (or morning-theme 'doom-gruvbox-light))
         (night-theme (or night-theme 'doom-gruvbox))
         (hour (nth 2 (decode-time (current-time))))
         (theme (cond ((<= 7 hour 17)   morning-theme)
                      (t                night-theme))))
    (unless (equal doom-theme theme)
      (setq doom-theme theme)
      (load-theme doom-theme t))
    ;; run every hour
    (run-at-time (format "%02d:%02d" (+ hour 1) 0) nil
                 #'mac/timed-theme morning-theme night-theme)))

;; gruvbox-material contrast and palette options
(setq doom-gruvbox-material-background  "medium"
      doom-gruvbox-material-palette     "material")

;; gruvbox-material-light contrast and palette options
(setq doom-gruvbox-material-light-background  "medium"
      doom-gruvbox-material-light-palette     "material")

;; everforest contrast options
(setq doom-everforest-background  "hard")
(setq doom-everforest-light-background "soft")

;; (mac/timed-theme 'doom-everforest-light
;;                  'doom-everforest)
(mac/timed-theme 'doom-gruvbox-material-light
                 'doom-gruvbox-material)

;; enabling italics and bold font
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some Defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq initial-major-mode 'lisp-interaction-mode)
(setq auto-save-default t       ;; autosave
      scroll-margin 2)          ;; a little margin on top and bottom edges
(global-visual-line-mode t)     ;; enables visual wrapping of lines

(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   LSP-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq lsp-headerline-breadcrumb-enable t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Conda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables '(conda-anaconda-home "/opt/miniconda3/"))
(setq conda-env-home-directory (expand-file-name "/home/cardoso/.conda/"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq evil-split-window-below t
      evil-split-window-right t
      evil-want-fine-undo t)
;; evil key bindings
(map! :leader :n "f f"         #'evil-ex-search-forward)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mixed Pitch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))       ;; in all text modes


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org And Latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pdf viewer
(setq +latex-viewers '(zathura))
;; using after! instead of use-package! because use-package! loads a package
;; inmediately. accordingly to
;; https://www.reddit.com/r/DoomEmacs/comments/mby1ou/after_vs_usepackage/
(after! org
  ;; org... aesthetics?
  (setq org-hide-block-startup t)               ;; all blocks folded by default
  (setq org-image-actual-width 400)             ;; width of inline images
  (setq org-startup-folded t)                   ;; everything folded (overview)

  ;; latex export config
  (add-to-list 'org-latex-default-packages-alist
         '("hidelinks" "hyperref" nil))         ;; no boxes around hyperlinks
  (setq org-latex-packages-alist
        '(("" "listings" nil)))                 ;; src code listing
  ;; (setq org-latex-caption-above nil)            ;; captions below tables
  (setq org-latex-pdf-process
        '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))
  (setq org-latex-image-default-option "keepaspectratio")) ;; keep img ratio

;; custom latex document-classes for org-latex-export-to-pdf
(after! ox-latex
  (add-to-list 'org-latex-classes
               ;; for CsCog article. needs llncs.sty file in same folder as org
               ;; file
               '("llncs" "\\documentclass{llncs}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; MS Word and Libreoffice
(setq org-odt-preferred-output-format "docx")

;; org key bindings
(map! :map org-mode-map
      :leader
      (:prefix "l"
       (:desc "Export org to PDF latex"  :n "e" #'org-latex-export-to-pdf)
       (:desc "Insert new label"         :n "l" #'org-ref-insert-label-link)
       (:desc "Insert new reference"     :n "r" #'org-ref-insert-ref-link)
       (:desc "Insert new citation"      :n "c" #'org-ref-insert-cite-link))
      (:prefix "m"
       (:desc "Edit special block"      :n "<" #'org-edit-special)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Roam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! org-roam
  :defer t
  :custom (org-roam-directory "/home/cardoso/second_brain")
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Agenda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-agenda-files
      '("/home/cardoso/TODO.org"
        "/home/cardoso/TAREAS.org"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Ref
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! org-ref
  :after org)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! dired
  :defer t
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(map! :map dired-mode-map
        ;; Kill buffer when quitting dired buffers
        [remap quit-window] (cmd! (quit-window t))
        ;; To be consistent with ivy/helm+wgrep integration
        "C-c C-e" #'wdired-change-to-wdired-mode
        ;; Stop dired from creating new buffers when we enter a new directory or
        ;; travel up the tree
        ;; :n  "RET" #'dired-find-alternate-file
        :ng "-"   (cmd! (find-alternate-file ".."))
        :ng "h"   (cmd! (find-alternate-file ".."))
        :ng "l"   #'dired-find-alternate-file)

;; hide details, like permissions and ownership
(add-hook! 'dired-mode-hook #'dired-hide-details-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vertico
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vertico-sort-function #'vertico-sort-history-alpha)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tomatinho
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader
      :desc "Tomatinho" "tt" #'tomatinho)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook! 'prog-mode-hook #'display-fill-column-indicator-mode) ;; 80 col high
;; (add-hook! 'after-init-hook #'org-agenda-list)
