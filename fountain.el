(defvar fountain-mode-hook nil)
(add-to-list 'auto-mode-alist '("\\.fountain\\'" . fountain-mode))

(add-hook 'text-mode-hook 'visual-line-mode)

(set-face-attribute 'font-lock-warning-face nil :weight 'bold :foreground "black")
(set-face-attribute 'font-lock-function-name-face nil :foreground "red")
(set-face-attribute 'font-lock-keyword-face nil :foreground "orange")

(defconst wpdl-font-lock-keywords-1
  (list
   ; scene headings
   '("^\\.\.\*\$" . font-lock-function-name-face)
   '("^\\(?:\\(?:EXT\\|INT\\|\\(?:ex\\|in\\)t\\)\\.\\)\.\*\$" . font-lock-function-name-face)
   ; **text** => bold
   '("\\*\\*\.\*?\\*\\*" . font-lock-warning-face))
  "Minimal highlighting expressions for WPDL mode.")

(defconst wpdl-font-lock-keywords-2
  (append wpdl-font-lock-keywords-1
		  (list
		   ; dialogue-related matches, w/parentheticals
		   '("^[A-Z\s\(\)\\.\'#1-9,]\*\$" . font-lock-keyword-face)
		   '("^\(\.\*\)\$" . font-lock-constant-face)))
  "Additional Keywords to highlight in WPDL mode.")

(defconst wpdl-font-lock-keywords-3
  (append wpdl-font-lock-keywords-2
		  (list
		   '("^\.\*:\$" . font-lock-constant-face)))
  "Balls-out highlighting in WPDL mode.")

(defvar wpdl-font-lock-keywords wpdl-font-lock-keywords-3
  "Default highlighting expressions for WPDL mode.")

(defun fountain-mode ()
  (interactive)
  (kill-all-local-variables)
  ;;(use-local-map fountain-mode-map)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(wpdl-font-lock-keywords))
  (setq major-mode 'fountain-mode)
  (setq mode-name "fountain")
  (visual-line-mode t)
  (run-hooks 'fountain-mode-hook))

(provide 'fountain-mode)