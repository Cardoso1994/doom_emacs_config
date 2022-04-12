;;; doom-lighthaus.el --- inspired by lighthaus
;;; https://lighthaustheme.com/
(require 'doom-themes)

;;
(defgroup doom-lighthaus-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-lighthaus-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-lighthaus-theme
  :type 'boolean)

(defcustom doom-lighthaus-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-lighthaus-theme
  :type 'boolean)

(defcustom doom-lighthaus-comment-bg doom-lighthaus-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-lighthaus-theme
  :type 'boolean)

(defcustom doom-lighthaus-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-lighthaus-theme
  :type '(choice integer boolean))

;;
(def-doom-theme doom-lighthaus
  "A dark theme inspired by lighthaus"

  ;; name        default   256       16
  ((bg         '("#18191e" nil       nil            ))
   (bg-alt     '("#21252d" nil       nil            ))
   (base0      '("#32302f" "black"   "black"        ))
   (base1      '("#1c1f24" "#1e1e1e" "brightblack"  ))
   (base2      '("#202328" "#2e2e2e" "brightblack"  ))
   (base3      '("#504945" "#262626" "brightblack"  ))
   (base4      '("#6c782e" "#3f3f3f" "brightblack"  ))
   (base5      '("#cccccc" "#525252" "brightblack"  ))
   (base6      '("#73797e" "#6b6b6b" "brightblack"  ))
   (base7      '("#9ca0a4" "#979797" "brightblack"  ))
   (base8      '("#ddc7a1" "#dfdfdf" "white"        ))
   (fg         '("#fffade" "#bfbfbf" "brightwhite"  ))
   (fg-alt     '("ffeee79" "#2d2d2d" "white"        ))

   (grey       base5)
   (red        '("#fc2929" "#ff6655" "red"          ))
   (orange     '("#e25600" "#dd8844" "brightred"    ))
   (green      '("#50c16e" "#99bb66" "green"        ))
   (teal       '("#44b273" "#44b9b1" "brightgreen"  ))
   (yellow     '("#ffff00" "#ECBE7B" "yellow"       ))
   (blue       '("#47a8a1" "#51afef" "brightblue"   ))
   (dark-blue  '("#1d918b" "#2257A0" "blue"         ))
   (magenta    '("#d16bb7" "#c678dd" "brightmagenta"))
   (violet     '("#d68eb2" "#a9a1e1" "magenta"      ))
   (cyan       '("#5ad1aa" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#00bfa4" "#5699AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      orange)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   ;; (builtin        magenta)
   (builtin        orange)
   (comments       (if doom-lighthaus-brighter-comments dark-cyan base5))
   (doc-comments   (doom-darken (if doom-lighthaus-brighter-comments green green) 0.15))
   (constants      yellow)
   (functions      magenta)
   (keywords       green)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      blue)
   (numbers        magenta)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-lighthaus-brighter-modeline)
   (-modeline-pad
    (when doom-lighthaus-padded-modeline
      (if (integerp doom-lighthaus-padded-modeline) doom-lighthaus-padded-modeline 4)))

   (modeline-fg     fg)
   (modeline-fg-alt fg-alt)

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg-alt)))
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1))))


  ;; --- extra faces ------------------------
((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   (evil-goggles-default-face :inherit 'region :background (doom-blend region bg 0.5))

   ((line-number &override) :foreground (doom-darken fg-alt 0.4))
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-lighthaus-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; Doom modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground blue :weight 'bold)

   ;; ivy-mode
   (ivy-current-match :background blue :distant-foreground base0 :weight 'bold)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; LaTeX-mode
   (font-latex-math-face :foreground green)
   (font-latex-script-char :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden)
   (org-document-info :foreground blue)
   (org-document-info-keyword :foreground (doom-darken blue 0.25))
   (org-document-title :foreground blue)
   (org-block-begin-line :foreground fg
                         :background (doom-darken dark-blue 0.25))
   (org-block-end-line :foreground fg
                         :background (doom-darken dark-blue 0.25))
   (org-block :foreground fg :background bg-alt)
   (org-meta-line :foreground cyan)
   (org-drawer :foreground (doom-darken yellow 0.25))
   (org-level-1 :foreground magenta :weight 'semi-bold)
   (org-level-2 :foreground cyan :weight 'semi-bold)
   (org-level-3 :foreground green :weight 'semi-bold)
   (org-level-4 :foreground yellow :weight 'semi-bold)
   (org-level-5 :foreground (doom-lighten magenta 0.15) :weight 'semi-bold)
   (org-level-6 :foreground (doom-lighten cyan 0.15) :weight 'semi-bold)
   (org-level-7 :foreground (doom-lighten green 0.15) :weight 'semi-bold)
   (org-level-8 :foreground (doom-lighten yellow 0.15) :weight 'semi-bold)

   ;; magit
   (magit-section-heading :foreground blue :weight 'bold)

   ;; ivy
   (ivy-current-match :foreground blue :background bg)
   (ivy-minibuffer-match-face-2 :foreground blue :background bg)

   ;; rainbow
   (rainbow-delimiters-depth-1-face :foreground orange)
   (rainbow-delimiters-depth-2-face :foreground magenta)
   (rainbow-delimiters-depth-3-face :foreground cyan)
   (rainbow-delimiters-depth-4-face :foreground yellow)
   (rainbow-delimiters-unmatched-face: :foreground fg :background 'nil)

   ;; evil
   (evil-ex-lazy-highlight :foreground fg :background (doom-darken magenta 0.3))

   ;; others
   (isearch :foreground fg :background (doom-darken magenta 0.2))

   ;; column indicator
   (fill-column-indicator :foreground (doom-darken red 0.3))
   )

  ;; --- extra variables ---------------------
  ()
  )

;;; doom-lighthaus-heme.el ends here
