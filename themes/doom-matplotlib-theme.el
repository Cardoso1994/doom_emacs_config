;;; doom-matplotlib-theme.el --- inspired by Matplotlib
;;; https://github.com/sainnhe/matplotlib
(require 'doom-themes)

;;
(defgroup doom-matplotlib-theme nil
  "Options for doom-matplotlib"
  :group 'doom-themes)

(defcustom doom-matplotlib-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-matplotlib-theme
  :type 'boolean)

(defcustom doom-matplotlib-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-matplotlib-theme
  :type 'boolean)

(defcustom doom-matplotlib-comment-bg doom-matplotlib-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-matplotlib-theme
  :type 'boolean)

(defcustom doom-matplotlib-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-matplotlib-theme
  :type '(choice integer boolean))

;; all colors are from matplotlib cmaps: inferno, viridis
;; used matplotlib.colors.Normaliz(vmin=0, vmax=100) to get values from cmaps
;; cmap_ = cm.get_cmap('cmap_string')
(def-doom-theme doom-matplotlib
  "A dark theme inspired by Matplotlib"

  ;; name        default   256       16
  ((bg         '("#050417" nil       nil            )) ;; inferno(4)
   (bg-alt     '("#10092d" nil       nil            )) ;; inferno(8)
   (base0      '("#323d43" "black"   "black"        )) ;; bg1 hard
   (base1      '("#1c1f24" "#1e1e1e" "brightblack"  )) ;;
   (base2      '("#202328" "#2e2e2e" "brightblack"  ))
   (base3      '("#445055" "#262626" "brightblack"  )) ;; bg3
   (base4      '("#3f444a" "#3f3f3f" "brightblack"  ))
   (base5      '("#7c8377" "#525252" "brightblack"  )) ;; grey0
   (base6      '("#73797e" "#6b6b6b" "brightblack"  ))
   (base7      '("#9ca0a4" "#979797" "brightblack"  ))
   (base8      '("#d3c6aa" "#dfdfdf" "white"        ))
   (fg         '("#fed89a" "#bfbfbf" "brightwhite"  )) ;; magma(92)
   (fg-alt     '("#fdcf92" "#2d2d2d" "white"        )) ;; magma(90)

   (grey       base4)
   (red        '("#bc3754" "#ff6655" "red"          )) ;; inferno(50)
   (orange     '("#f2834b" "#dd8844" "brightred"    )) ;; plasma(70)
   (green      '("#5ec962" "#99bb66" "green"        )) ;; viridis(75)
   (teal       '("#2fb47d" "#44b9b1" "brightgreen"  )) ;; viridis(65)
   (yellow     '("#dfe318" "#ECBE7B" "yellow"       )) ;; viridis(95)
   (blue       '("#26828e" "#51afef" "brightblue"   )) ;; viridis(44)
   (dark-blue  '("#297a8e" "#2257A0" "blue"         )) ;; viridis(41)
   (magenta    '("#3d4b89" "#c678dd" "brightmagenta")) ;; viridis(23)
   (violet     '("#8c2980" "#a9a1e1" "magenta"      )) ;; magma(40)
   (cyan       '("#25848e" "#46D9FF" "brightcyan"   )) ;; viridis(45)
   (dark-cyan  '("#287d8e" "#5699AF" "cyan"         )) ;; viridis(42)

   ;; face categories -- required for all themes
   ;; (highlight      orange)
   (highlight      orange)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      blue)
   ;; (builtin        magenta)
   (builtin        yellow)
   (comments       (if doom-matplotlib-brighter-comments dark-cyan base5))
   (doc-comments   (doom-darken (if doom-matplotlib-brighter-comments dark-cyan green) 0.2))
   ;; (constants      violet)
   (constants      yellow)
   ;; (functions      magenta)
   (functions      cyan)
   ;; (keywords       blue)
   (keywords       red)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   ;; (variables      (doom-lighten magenta 0.3))
   (variables      blue)
   ;; (numbers        orange)
   (numbers        teal)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-matplotlib-brighter-modeline)
   (-modeline-pad
    (when doom-matplotlib-padded-modeline
      (if (integerp doom-matplotlib-padded-modeline) doom-matplotlib-padded-modeline 4)))

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

   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-matplotlib-comment-bg (doom-lighten bg 0.05)))
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
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;; ivy-mode
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; LaTeX-mode
   (font-latex-math-face :foreground green)
   (font-latex-script-char-face :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden)
   (org-drawer :foreground (doom-darken yellow 0.1))
   (org-document-info :foreground dark-blue :weight 'bold)
   (org-document-info-keyword :foreground blue)
   (org-document-title :foreground blue :weight 'semi-bold)
   (org-block-begin-line :foreground fg
                         :background (doom-darken dark-blue 0.5))
   (org-block-end-line :foreground fg
                         :background (doom-darken dark-blue 0.5))
   (org-block :foreground fg :background bg-alt)
   (org-meta-line :foreground cyan)
   (org-level-1 :foreground orange :weight 'semi-bold :slant 'italic)
   (org-level-2 :foreground cyan :weight 'semi-bold :slant 'italic)
   (org-level-3 :foreground green :weight 'semi-bold :slant 'italic)
   (org-level-4 :foreground yellow :weight 'semi-bold :slant 'italic)
   (org-level-5 :foreground (doom-darken orange 0.1)
                :weight 'semi-bold :slant 'italic)
   (org-level-6 :foreground (doom-darken cyan 0.1)
                :weight 'semi-bold :slant 'italic)
   (org-level-7 :foreground (doom-darken green 0.1)
                :weight 'semi-bold :slant 'italic)
   (org-level-8 :foreground (doom-darken yellow 0.1)
                :weight 'semi-bold :slant 'italic)

   ;; magit
   (magit-section-heading :foreground (doom-darken blue 0.1) :weight 'bold)

   ;; rainbow
   (rainbow-delimiters-depth-1-face :foreground orange)
   (rainbow-delimiters-depth-2-face :foreground magenta)
   (rainbow-delimiters-depth-3-face :foreground cyan)
   (rainbow-delimiters-depth-4-face :foreground yellow)
   (rainbow-delimiters-unmatched-face: :foreground fg :background 'nil)

   ;; evil
   (evil-ex-lazy-highlight :foreground bg-alt :background violet)

   ;; others
   (isearch :foreground bg :background (doom-lighten magenta 0.2))

   ;; column indicator
   (fill-column-indicator :foreground bg-alt :background bg-alt)
   )


  ;; --- extra variables ---------------------
  ()
  )

;;; doom-matplotlib-theme.el ends here
