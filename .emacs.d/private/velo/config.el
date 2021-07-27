(spacemacs|define-jump-handlers velo-mode)

(defgroup velo-mode nil
  "A Mode for VQL/Velociraptor"
  :prefix "velo-mode-"
  :group '+lang
  )

(add-to-list 'auto-mode-alist '("\\.vql\\'" . velo-mode))

(setq velo-highlights
      '(("SELECT\\|select\\|FROM\\|from\\|LET\\|let\\|Let\\|AS\\|as\\|As\\|WHERE\\|where\\|Where\\|GROUP\\|Group\\|group\\|by\\|By\\|BY\\|LIMIT\\|limit\\not\\NOT" . font-lock-keyword-face)
        ("<=\\|=\\|<\\|\\*\\=~\\|\\+\\|-" . font-lock-function-name-face))
      )

(define-derived-mode velo-mode prog-mode "Velo"
(setq font-lock-defaults '(velo-highlights)))
