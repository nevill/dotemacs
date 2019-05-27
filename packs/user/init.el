(setq user-full-name "Nevill")
(setq user-mail-address "nevill.dutt@gmail.com")

;; change this according to your needs
;; you can get "Source Code Pro" from http://sourceforge.net/projects/sourcecodepro.adobe/
;; it's a great coding font
;;(defvar default-font "Source Code Pro Regular-13" "My default Emacs font.") ;; it doesn't support Chinese well
;;(defvar default-font "Monaco Regular-13" "My default Emacs font.")
;;(set-frame-font default-font nil t)

; to support chinese characters
(when (display-graphic-p)
  (setq fonts
        (cond ((eq system-type 'darwin)     '("Monaco"   "STHeiti")) ; if STHeiti is not supported, try with: Hiragino Sans GB
              ((eq system-type 'gnu/linux)  '("Menlo"    "WenQuanYi Zen Hei"))
              ((eq system-type 'windows-nt) '("Consolas" "Microsoft Yahei"))))

  (setq face-font-rescale-alist '(("STHeiti" . 1.1) ("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" (car fonts) 13))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family (car (cdr fonts))))))

;; Always have cursor above a number of lines from bottom
(setq scroll-margin 8)

;; yaml-mode.el from https://github.com/yoshiki/yaml-mode
(autoload 'yaml-mode "yaml-mode" "Major mode for editing Yaml" t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; php-mode.el from https://github.com/ejmr/php-mode
(autoload 'php-mode "php-mode" "Major mode for editing PHP" t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; js2-mode

(autoload 'js2-mode "js2-mode" "Major mode for Javascript" t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
;(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
