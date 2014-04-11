(setq user-full-name "Nevill Dutt")
(setq user-mail-address "nevill.dutt@gmail.com")

;;; change this according to your needs
;;; you can get "Source Code Pro" from http://sourceforge.net/projects/sourcecodepro.adobe/
;;; it's a great coding font
;;(defvar default-font "Source Code Pro Regular-13" "My default Emacs font.") ;; it doesn't support Chinese well
(defvar default-font "Monaco Regular-13" "My default Emacs font.")

(set-frame-font default-font nil t)

;;; Always have cursor above a number of lines from bottom
(setq scroll-margin 8)

;(require 'package)
;(add-to-list 'package-archives
;  '("marmalade" . "http://marmalade-repo.org/packages/"))
;(package-initialize)
