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
;; Modeline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq doom-modeline-buffer-file-name-style 'relative-to-project)


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
(setq doom-font (font-spec :family "JetBrains Mono" :size 22 :weight 'normal)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font")
      doom-variable-pitch-font (font-spec :family "Bookerly"))

;; (setq doom-font (font-spec :family "Cascadia Code PL" :size 22 :weight 'normal)
      ;; doom-variable-pitch-font (font-spec :family "Guardi LT Roman"))
      ;; doom-variable-pitch-font (font-spec :family "Lato"))
(setq doom-font-increment 1
      doom-big-font-increment 1)

;; italics for comments and keywords
(custom-set-faces!
  '(font-lock-comment-face :slant italic :weight light)
  '(font-lock-keyword-face :slant italic :weight normal))


;;;;;;;;;;;;;;;;;;;;;;;;
;;   Theme
;;;;;;;;;;;;;;;;;;;;;;;;
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(defun mac/timed-theme (&optional morning-theme night-theme)
  ""
  (let* ((morning-theme (or morning-theme 'doom-solarized-light))
         (night-theme (or night-theme 'doom-solarized-dark))
         (hour (nth 2 (decode-time (current-time))))
         (theme (cond ((<= 7 hour 18)   morning-theme)
                      (t                night-theme))))
    (unless (equal doom-theme theme)
      (setq doom-theme theme)
      (load-theme doom-theme t))
    ;; run every hour
    (run-at-time (format "%02d:%02d" (+ hour 1) 0) nil
                 #'mac/timed-theme morning-theme night-theme)))

;; defining colorschemes
(mac/timed-theme)

;; gruvbox-material contrast and palette options
;; (setq doom-gruvbox-material-background  "medium"
;;       doom-gruvbox-material-palette "mix")

;; gruvbox-material-light contrast and palette options
;; (setq doom-gruvbox-material-light-background  "hard"
;;       doom-gruvbox-material-light-palette "original")

;; everforest contrast options
;; (setq doom-everforest-background  "hard")
;; (setq doom-everforest-light-background "hard")

;; (mac/timed-theme 'doom-gruvbox-material-light
;;                  'doom-gruvbox-material)
;; (mac/timed-theme 'doom-everforest-light
;;                  'doom-everforest)

;; solarized dark configuration
(custom-theme-set-faces! '(doom-solarized-dark doom-everforest)
  `(fill-column-indicator :foreground ,(doom-color 'bg-alt)
                          :background ,(doom-color 'bg-alt))
  `(font-lock-comment-face :foreground ,(doom-darken (doom-color 'teal) 0.2))
  `(org-document-info-keyword :foreground ,(doom-darken
                                            (doom-color 'green) 0.3))
  `(org-drawer :foreground ,(doom-darken (doom-color 'yellow) 0.25))
  `(org-link :foreground ,(doom-color 'teal) :underline t)
  `(show-paren-match :foreground ,(doom-color 'fg)
                     :background ,(doom-darken (doom-color 'orange) 0.5))
  `(org-block-begin-line :foreground ,(doom-color 'fg-alt)
                         :background ,(doom-color 'bg-alt))
  `(org-level-1 :foreground ,(doom-color 'violet) :weight bold :height 1.6)
  `(org-level-2 :foreground ,(doom-color 'orange) :weight bold :height 1.4)
  `(org-level-3 :foreground ,(doom-color 'magenta):weight bold  :height 1.2)
  `(org-level-4 :foreground ,(doom-color 'teal) :weight bold :height 1.1))

;; solarized light configuration
(custom-theme-set-faces! '(doom-solarized-light doom-everforest-light)
  `(fill-column-indicator :foreground ,(doom-color 'bg-alt)
                          :background ,(doom-color 'bg-alt))
  `(font-lock-comment-face :foreground ,(doom-lighten (doom-color 'teal) 0.2))
  `(org-document-info-keyword :foreground ,(doom-lighten
                                            (doom-color 'violet) 0.25))
  `(org-meta-line :foreground ,(doom-lighten (doom-color 'magenta) 0.25))
  `(org-link :foreground ,(doom-color 'teal) :underline t)
  `(org-drawer :foreground ,(doom-lighten (doom-color 'orange) 0.35))
  `(show-paren-match :foreground ,(doom-color 'fg)
                     :background ,(doom-lighten (doom-color 'orange) 0.5))
  `(org-level-1 :foreground ,(doom-color 'violet) :weight bold :height 1.6)
  `(org-level-2 :foreground ,(doom-color 'orange) :weight bold :height 1.4)
  `(org-level-3 :foreground ,(doom-color 'magenta):weight bold  :height 1.2)
  `(org-level-4 :foreground ,(doom-color 'teal) :weight bold :height 1.1))

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
;;   Eshell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mac/eshell-prompt-fn ()
  "Generate the prompt string for eshell.Based in the original doom's
eshell-default-prompt-fn. Use for `eshell-prompt-function'."
  (require 'shrink-path)
  (concat (if (bobp) "" "\n")
          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name (shrink-path-file pwd)))
                        'face '+eshell-prompt-pwd))
          (propertize (+eshell--current-git-branch)
                      'face '+eshell-prompt-git-branch)
          (if (bound-and-true-p conda-env-current-name)
              (propertize (concat " [conda:" conda-env-current-name "]"
                                  ) 'face 'italic)
            "")
          (propertize " λ" 'face (if (zerop eshell-last-command-status)
                                     'success 'error))
          " "))

;; not an elegant solution for own eshell prompt function
(setq mac/eshell-own-prompt nil)
(add-hook! 'eshell-mode-hook
   (if (not mac/eshell-own-prompt)
       (progn (setq mac/eshell-own-prompt t
                    eshell-prompt-function #'mac/eshell-prompt-fn))
        t))

;; open eshell buffer in pwd
(map! :leader (:n "o E" nil
               :n "o e" nil
               :desc "open Eshell buffer" :n "o e" #'+eshell/here))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   LSP-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq lsp-headerline-breadcrumb-enable t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Conda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! conda
  :config
  ;; arch!
  (custom-set-variables '(conda-anaconda-home "/opt/miniconda3/"))
  (setq conda-env-home-directory (expand-file-name "~/.conda/")))

  ;; ubuntu!
  ;; (custom-set-variables '(conda-anaconda-home (expand-file-name "~/miniconda3/")))
  ;; (setq conda-env-home-directory (expand-file-name "~/miniconda3/")))

  (conda-env-initialize-eshell)

(after! conda
  (map! :leader
        :nm "m c a" #'conda-env-activate
        :nm "m c d" #'conda-env-deactivate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq evil-split-window-below t
      evil-split-window-right t)
;;       evil-want-fine-undo nil)

;; evil key bindings
(after! evil
  (map! :leader (:n "f f"  #'evil-ex-search-forward))
  (map! :n "0" nil
        :n "0" #'evil-first-non-blank)
  ;; bind `s' to evil-substitute
  (map! (:map (evil-snipe-local-mode-map evil-snipe-mode-map)
         :nm "s" nil)
        :nm "s" #'evil-substitute))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mixed Pitch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))       ;; in all text modes


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PDF tools
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq +latex-viewers '(zathura)
      pdf-view-resize-factor 1.05)
;; pdf tools midnight mode when opening a pdf
(add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org And Latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; using after! instead of `use-package!' because `use-package!' loads a package
;; inmediately. accordingly to
;; https://www.reddit.com/r/DoomEmacs/comments/mby1ou/after_vs_usepackage/
(after! org
  ;; org... aesthetics?
  (setq org-hide-block-startup t)               ;; all blocks folded by default
  (setq org-image-actual-width 450)             ;; width of inline images
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
  (setq org-latex-default-figure-position "htbp!")
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
      (:prefix ("l" . "org-latex")
      :desc "Export org to PDF latex"  :n "e" #'org-latex-export-to-pdf
      :desc "Insert new label"         :n "l" #'org-ref-insert-label-link
      :desc "Insert new reference"     :n "r" #'org-ref-insert-ref-link
      :desc "Insert new citation"      :n "c" #'org-ref-insert-cite-link)
      (:prefix "m"
      :desc "Edit special block"      :n "<" #'org-edit-special))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Roam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! org-roam
  :defer t
  :custom (org-roam-directory "/home/cardoso/second_brain")
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
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
      :desc "Tomatinho" "tt" #'tomatinho
      :desc "Quit Tomatinho" "tq" #'tomatinho-interactive-quit)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook! 'prog-mode-hook #'display-fill-column-indicator-mode) ;; 80 col high
; (add-hook! 'after-init-hook #'org-agenda-list)
