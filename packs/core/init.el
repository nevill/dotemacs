(require 'dircolors)

(live-load-config-file "built-in.el")
(live-load-config-file "cosmetic.el")
(live-load-config-file "powerline-conf.el")

(when (eq system-type 'darwin)
  (live-load-config-file "osx.el"))
