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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 23 :weight 'normal)
;; (setq doom-font (font-spec :family "MonoLisa" :size 22 :weight 'normal)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font")
      ;; doom-variable-pitch-font (font-spec :family "Montserrat"))
      doom-variable-pitch-font (font-spec :family "Bookerly"))

(setq doom-font-increment 1
      doom-big-font-increment 0.5
      text-scale-mode-amount 1
      text-scale-mode-step 1.05)

;; italics for comments and keywords
(custom-set-faces!
  '(font-lock-comment-face :slant italic :weight semi-light)
  '(font-lock-keyword-face :slant italic))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modeline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq doom-modeline-buffer-file-name-style 'relative-to-project
      doom-modeline-height 15
      doom-modeline--buffer-file-icon t)


;;;;;;;;;;;;;;;;;;;;;;;;
;;   Theme
;;;;;;;;;;;;;;;;;;;;;;;;
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; (add-hook! 'doom-load-theme-hook (cmd! (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) . ,(face-attribute 'default :background)))))
;; (setq pdf-view-midnight-colors `(,(face-attribute 'default :foreground) . ,(face-attribute 'default :background)))

(setq morning-1 7
      morning-2 11
      afternoon-1 15
      afternoon-2 19
      late-afternoon-1 20
      late-afternoon-2 22)

(defun mac/timed-theme (&optional morning-theme afternoon-theme
                                  late-afternoon-theme night-theme)
  "Change doom-theme depending on time of the day. Run every hour."
  (let* ((morning-theme (or morning-theme 'doom-solarized-light))
         (afternoon-theme (or afternoon-theme 'doom-gruvbox-light))
         (late-afternoon-theme (or late-afternoon-theme 'doom-solarized-dark))
         (night-theme (or night-theme 'doom-gruvbox))
         (hour (nth 2 (decode-time (current-time))))
         (theme (cond ((<= morning-1 hour morning-2) morning-theme)
                      ((<= afternoon-1 hour afternoon-2) afternoon-theme)
                      ((<= late-afternoon-1 hour late-afternoon-2)
                       late-afternoon-theme)
                      (t night-theme))))
    (unless (equal doom-theme theme)
      (progn (setq doom-theme theme)
             (mapc #'disable-theme custom-enabled-themes)
             (load-theme doom-theme t)))
    ;; run every hour
    (run-at-time (format "%02d:%02d" (+ hour 1) 0) nil
                 #'mac/timed-theme morning-theme afternoon-theme
                 late-afternoon-theme night-theme)))


;; gruvbox-material contrast and palette options
(setq doom-gruvbox-material-background  "medium"
      doom-gruvbox-material-palette "material")

;; gruvbox-material-light contrast and palette options
(setq doom-gruvbox-material-light-background  "medium"
      doom-gruvbox-material-light-palette "material")

;; everforest contrast options
(setq doom-everforest-background  "medium"
      doom-everforest-light-background "medium")

;; (mac/timed-theme 'doom-solarized-light
(mac/timed-theme 'ef-melissa-light 'ef-melissa-light
                 'doom-everforest 'doom-gruvbox-material)

;; solarized dark configuration
(custom-theme-set-faces! '(doom-solarized-dark doom-nord doom-one
                                               doom-lighthaus
                                               doom-monokai-ristretto
                                               doom-monokai-pro)
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

(custom-theme-set-faces! '(doom-solarized-light doom-one-light
                                                doom-ayu-light)
   `(diredfl-compressed-file-name :height 1.15
                                  :foreground ,(doom-color 'yellow))
   `(diredfl-dir-heading :height 1.15 :foreground ,(doom-color 'teal))
   `(diredfl-dir-name :height 1.15 :foreground ,(doom-color 'blue))
   `(diredfl-deletion :height 1.15 :foreground ,(doom-color 'red)
                      :background ,(doom-darken (doom-color 'red) 0.55))
   `(diredfl-deletion-file-name :foreground ,(doom-color 'red)
                                :background ,(doom-darken
                                              (doom-color 'red) 0.55))
   `(diredfl-file-name :height 1.15 :foreground ,(doom-color 'fg))
   `(dired-flagged :height 1.15 :foreground ,(doom-color 'red)
                   :background ,(doom-darken (doom-color 'red) 0.55))
   `(diredfl-symlink :height 1.15 :foreground ,(doom-color 'magenta))
   `(fill-column-indicator :foreground ,(doom-color 'bg-alt)
                          :background ,(doom-color 'bg-alt))
   `(font-lock-comment-face :foreground ,(doom-lighten (doom-color 'yellow) 0.4))
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
;; (setq org-directory "~/org/")

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
      scroll-margin 2          ;; a little margin on top and bottom edges
      global-visual-line-mode t)     ;; enables visual wrapping of lines

(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; don't autosave tramp buffers in server, but locally instead
(setq tramp-auto-save-directory (expand-file-name "~/garbage"))


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
(map! :leader
      (:n "o E" nil
       :n "o e" nil
       :desc "open Eshell buffer in pwd" :n "o E" #'+eshell/here
       :desc "open Eshell popup buffer in pwd" :n "o e" #'+eshell/toggle))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Vterm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open vterm buffer in pwd
(setq vterm-shell "/bin/zsh")
;; (map! :leader (:n "o T" nil
;;                :n "o t" nil
;;                :desc "open Vterm buffer in pwd" :n "o t" #'+vterm/here
;;                :desc "open Vterm buffer in pwd" :n "o T" #'+vterm/toggle))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   LSP-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq lsp-headerline-breadcrumb-enable t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Conda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! conda
  :init
  (setq conda-env-home-directory (expand-file-name "~/miniconda3"))
  (custom-set-variables '(conda-anaconda-home
                          (expand-file-name "~/miniconda3")))

  :config
  (add-hook! 'conda-postactivate-hook (cmd! (lsp-restart-workspace)))
  (add-hook! 'conda-postdeactivate-hook (cmd! (lsp-restart-workspace))))

(conda-env-initialize-eshell)

(after! conda
  (map! :map (python-mode-map eshell-mode-map)
        :localleader
        :prefix ("c" . "conda")
        :nm "a" #'conda-env-activate
        :nm "d" #'conda-env-deactivate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   EIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ein:output-area-inlined-images t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq evil-split-window-below t
      evil-split-window-right t
      evil-want-fine-undo t)

;; evil key bindings
(after! evil
  (map!
   :leader
   :desc "Find text in buffer" :n "f f"  #'evil-ex-search-forward
   ;; :desc "Increase font size" :n "f +" #'doom/increase-font-size
   :desc "Increase font size" :n "f +" #'text-scale-increase
   ;; :desc "Decrease font size" :n "f -" #'doom/decrease-font-size
   :desc "Decrease font size" :n "f -" #'text-scale-decrease
   :desc "Reset font size" :n "f =" #'doom/reset-font-size)
  (map! :n "0" nil
        :nv "0" #'evil-first-non-blank
        :n "C-=" nil
        :n "C-=" #'doom/reset-font-size
        :n "C-+" nil
        :n "C-+" #'text-scale-increase)
  (if (eq system-type 'darwin)
      (progn
        (map!
         :n "ç" nil
         :n "ç" #'evil-forward-paragraph
         :n "´" nil
         :n "´" #'evil-backward-paragraph
         :v "|" #'evil-shift-left
         :v "°" #'evil-shift-right)
        (map!
         :leader
         :n "w |" nil
         :n "w |" #'evil-window-decrease-width
         :n "w °" #'evil-window-increase-width)))
  ;; bind `s' to evil-substitute
  (map! (:map (evil-snipe-local-mode-map evil-snipe-mode-map)
         :nm "s" nil)
        :nm "s" #'evil-substitute)
  (map! :leader
        (:prefix ("F" . "frames")
        :desc "Go to next frame" :n "n" #'+evil/next-frame
        :desc "Go to previous frame" :n "p" #'+evil/previous-frame
        :desc "Open new frame" :n "o" #'make-frame)))

;; python keybindings
(map! :map prog-mode-map
      :localleader
      :desc "Fold all blocks" :n "h" #'hs-hide-all
      :desc "Fold single block" :n "b h" #'hs-hide-block
      :desc "Unfold all blocks" :n "o" #'hs-show-all
      :desc "Unfold single block" :n "b o" #'hs-show-block)

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
;; (add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org And Latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; adding texbin to PATH on macOS
(if (eq system-type 'darwin)
    (progn
    (getenv "PATH")
  (setenv "PATH"
          (concat "/Library/TeX/texbin/" ":"
                  (getenv "PATH"))))
  nil)

;; using after! instead of `use-package!' because `use-package!' loads a package
;; inmediately. accordingly to
;; https://www.reddit.com/r/DoomEmacs/comments/mby1ou/after_vs_usepackage/
(after! org
  ;; org... aesthetics?
  (setq org-hide-block-startup t               ;; all blocks folded by default
        org-image-actual-width 850             ;; width of inline images
        org-startup-folded t                   ;; everything folded (overview)
        org-startup-with-latex-preview nil     ;; start with latex preview
        org-format-latex-options '(:foreground default :background default
                                  :scale 2.0 :html-foreground "Black"
                                  :html-background "Transparent"
                                  :html-scale 1.0
                                  :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))



  ;; latex export config
  (add-to-list 'org-latex-default-packages-alist
         '("hidelinks" "hyperref" nil))         ;; no boxes around hyperlinks
  (setq org-latex-packages-alist
        '(("" "listings" nil)))                 ;; src code listing
  ;; (setq org-latex-caption-above nil)            ;; captions below tables
  (setq org-latex-pdf-process
        '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))
        ;; '("latexmk -shell-escape -bibtex -f -pdf %f"))
  (setq org-latex-image-default-option "keepaspectratio") ;; keep img ratio
  (setq bibtex-dialect 'biblatex))

;; custom latex document-classes for org-latex-export-to-pdf
(after! ox-latex
  (setq org-latex-with-hyperref nil)
  (setq org-latex-default-figure-position "htbp!")
  ;; for CsCog article. needs llncs.sty file in same folder as org
  ;; file
  (add-to-list 'org-latex-classes
               '("llncs" "\\documentclass{llncs}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  ;; Elsevier
  (add-to-list 'org-latex-classes
               '("elsevier"
                 "\\documentclass{elsarticle/elsarticle}
                  [NO-DEFAULT-PACKAGES]
                  [NO-PACKAGES]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  ;; Definitions is a folder from the mdpi latex template where al tex code is
  ;; located
  (add-to-list 'org-latex-classes
               '("mdpi"
                 "\\documentclass{Definitions/mdpi}
                  [NO-DEFAULT-PACKAGES]
                  [NO-PACKAGES]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  ;; for masters thesis
  (add-to-list 'org-latex-classes
               '("masters_thesis"
                 "\\documentclass{book}
                  [NO-DEFAULT-PACKAGES]
                  [NO-PACKAGES]"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("comia" "\\documentclass{llncs}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; MS Word and Libreoffice
(setq org-odt-preferred-output-format "docx")

;; org key bindings
(use-package! org
  :config
  (map! :map org-mode-map
        :localleader
        :prefix ("l" . "org-latex")
        :desc "Export org to PDF latex"  :n "e" #'org-latex-export-to-pdf
        :desc "Insert new label"         :n "l" #'org-ref-insert-label-link
        :desc "Insert new reference"     :n "r" #'org-ref-insert-ref-link
        :desc "Insert new citation"      :n "c" #'org-ref-insert-cite-link
        :desc "LaTeX preview"            :n "p" #'org-latex-preview)
  (if (eq system-type 'darwin)
      (map! :map org-mode-map
            :localleader
            :desc "Edit special block" :n "|" #'org-edit-special)
    (map! :map org-mode-map
          :localleader
          :desc "Edit special block" :n "<" #'org-edit-special)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Roam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! org-roam
  :defer t
  :custom (org-roam-directory (expand-file-name "~/second_brain"))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-enable)
  (org-roam-setup)
  (setq +org-roam-auto-backlinks-buffer t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Agenda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-agenda-files `(,(expand-file-name "~/agenda/TODO.org")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Ref
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! org-ref
  :after org
  :config
  (setq org-ref-default-ref-type "Cref"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! dired
  :defer t
  :custom
  (if (eq system-type 'darwin)
      (setq insert-directory-program "gls"
            dired-use-ls-dired t))
  (dired-listing-switches "-agho --group-directories-first"))

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
;; Tree-sitter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! tree-sitter)
(use-package! tree-sitter-langs)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode
                           #'display-fill-column-indicator-mode ;; 80 col high
                           #'visual-line-mode)
(add-hook! 'python-mode-hook #'tree-sitter-hl-mode #'hs-hide-all
           (cmd! (custom-set-variables '(conda-anaconda-home
                          (expand-file-name "~/miniconda3")))))
(add-hook! 'after-init-hook #'org-agenda-list)

;; TEMPORARY FIX in endeavour
(custom-set-variables '(conda-anaconda-home
                          (expand-file-name "~/miniconda3")))
