; disable backup & auto-save
(setq auto-save-default nil)
(setq make-backup-files nil)

(defalias 'yes-or-no-p 'y-or-n-p)

; Seed the random-number generator
(random t)

; to show a verbose buffer name
(require 'uniquify)
(eval-after-load 'uniquify
  '(progn
     (setq uniquify-buffer-name-style 'reverse)
     (setq uniquify-separator "/")
     (setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
     (setq uniquify-ignore-buffers-re "^\\*")))

; UTF-8 everywhere
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

; can open a compressed file .gz .bz2
(auto-compression-mode t)

; show matching parenthese
(show-paren-mode 1)
;(setq show-paren-delay 0)

(setq-default tab-width 4
              standard-indent 4
              indent-tabs-mode nil ; only insert spaces
              show-trailing-whitespace t)

; remove all trailing whitespace and trailing blank lines before saving the file
(add-hook 'before-save-hook 'whitespace-cleanup)

; go to the place last time you opened the same file
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat live-tmp-dir "places"))

; use aspell
(setq-default ispell-program-name "aspell")

; make emacs use the clipboard
(setq x-select-enable-clipboard t)

; Font size
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

; Align your code in a pretty way.
;(global-set-key (kbd "C-x \\") 'align-regexp)
