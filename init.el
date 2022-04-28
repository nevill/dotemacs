;; -*- lexical-binding: t -*-

;; (tool-bar-mode 0) ; 关闭工具栏
;; (scroll-bar-mode 0) ; 关闭滚动条
(toggle-frame-maximized) ; 最大化窗口
(electric-pair-mode t) ; 自动补齐括号

; (set-face-attribute 'default nil :height 130) ; 设置字体大小
; (setq-default cursor-type '(bar . 2)) ; 设定光标形状

(setq ;; 不显示启动屏
      inhibit-startup-screen t
      ;; 禁用备份文件
      make-backup-files nil
      ;; 禁用自动保存
      auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'kill-region) ;对应Windows上面的Ctrol-x 剪切

;; 定义一个打开配置文件的函数
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 将 open-init-file 绑定到 F2 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(require 'package)
(setq package-archives '(("melpa"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("melpa-stable"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
			 ("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ; ("org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
			 ))
(unless (bound-and-true-p package--initialized) (package-initialize)) ;; 初始化包管理

;; 防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents) (package-refresh-contents))

;; 安装 use-package
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

;; (require 'use-package)
(setq use-package-always-ensure t
      ;; use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t
)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package restart-emacs)

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode)) ; 选中以后按任意键替换文字

(use-package simple
  :ensure nil
  :hook (after-init . (lambda ()
                         (line-number-mode)
                         (column-number-mode)
                         (size-indication-mode))))

(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode)) ; 当前行高亮

(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t)) ; 括号匹配高亮

(use-package company
  :config
  (setq company-minimum-prefix-length 1 ; 最小补全长度
        company-idle-delay 0.1 ; 最小补全弹出时间
  )
  (global-company-mode t) ; 全局补全, 依赖 company 包
  )

;; modeline上显示我的所有的按键和执行的命令
;; (use-package keycast :init (keycast-mode))

;; 增强 minibuffer 的导航功能
(use-package vertico
  :config (vertico-mode))

;; 增强 mini buffer 中的搜索功能
(use-package orderless
  :config
  (setq completion-styles '(orderless)))

;; 给 minibuffer 的选项中增加更多的注释
(use-package marginalia
  :config (marginalia-mode))

;; 给出当前可以做的操作的提示
(use-package embark
  :bind ("C-." . embark-act)

  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))
	       )
  )

(use-package rg)

(use-package consult-eglot
  :bind
  (
    ("s-R" . consult-eglot-symbols) ; search the symbos in the whole project space
  ))
(use-package consult
  :config
  (setq consult-min-input 2) ; 至少输入两个字符才开始补齐
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("s-p" . consult-find)
   ("s-r" . consult-imenu)) ;; super + r to go to symbols in editor, like in VSCode or Sublime Text
  :hook (completion-list-mode . consult-preview-at-point-mode))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


(use-package go-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  :hook
  (before-save-hook gofmt-before-save)
  ;; (before-save-hook #'eglot-format-buffer -10 t)
  )

(use-package eglot
  :config
  (add-hook 'go-mode-hook 'eglot-ensure)
  (setq eldoc-idle-dealy 2) ;; 提示弹出时间延迟 2 秒
  (setq-default eglot-workspace-configuration
    '((:gopls .
	      ((matcher . "CaseSensitive")
	       (usePlaceholders . t)
	       ))))
  )
;; (defun eglot-format-buffer-on-save ()
;;   (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
;; (add-hook 'go-mode-hook #'eglot-format-buffer-on-save)

; (require 'project)
(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))
;; 定义 project 的根目录
(cl-defmethod project-root ((project (head go-module))) (cdr project))

(use-package project
  ; :bind
  ; (("s-p" . project-find-file))
  :config
  (add-hook 'project-find-functions #'project-find-go-module))

(use-package recentf
  :config
  (recentf-mode t)
  (setq recentf-max-menu-items 10))

;; (use-package projectile
;; 	    :init (projectile-global-mode))

;; Recommended keymap prefix on macOS
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(max-lisp-eval-depth 8000)
 '(max-specpdl-size 18000)
 '(package-selected-packages '(keycast restart-emacs use-package company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
