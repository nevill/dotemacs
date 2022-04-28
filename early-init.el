(add-hook 'emacs-startup-hook
  (lambda ()
    (message "Emacs ready in %s with %d garbage collections."
      (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
      gcs-done
    )
  )
)

(setq
 package-enable-at-startup nil
 ;; Resizing the Emacs frame can be a terribly expensive part of changing the
 ;; font. By inhibiting this, we easily halve startup times with fonts that are
 ;; larger than the system default.
 frame-inhibit-implied-resize t
 ;; After startup `gcmh' will reset this.
 gc-cons-threshold most-positive-fixnum
 gc-cons-percentage 0.6)

;; Faster to disable these here (before they've been initialized)
;; Since `default-frame-alist' didnt have default value, just setq here
(setq default-frame-alist
      '(
        (vertical-scroll-bars . nil)
        ; (menu-bar-lines . 10)
        (tool-bar-lines . 0) ; 关闭工具栏
        (alpha-background . 90)
        ; (internal-border-width . 18)
        ; (right-fringe   . 1)
        ; (show-paren-mode . 1) ; 括号匹配高亮
        (column-number-mode . 1) ; 状态栏显示行列信息
        ))

(set-face-attribute 'default nil :height 130) ; 设置字体大小
(setq-default cursor-type '(bar . 2)) ; 设定光标形状
