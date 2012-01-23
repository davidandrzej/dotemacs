;
; Dave Andrzejewski
; 12/05/2010
;

;
; General emacs configuration stuff
;
(load "~/.emacs_config.el")

;
; Custom functions and keyboard shortcuts
;
(load "~/.emacs_functions.el")

;
; GNU Emacs or Aquamacs (OS X)?
;
(if (string-match "Aquamacs" (emacs-version))
    (progn
      (message "Customizing Aquamacs")
      (global-set-key "\M-q" 'fill-paragraph) ;; why does aquamacs break this?
      (set-default-font 
       "-apple-Consolas-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")
      (set-face-attribute 'default nil :height 160)
      (global-set-key "\C-cs" 'aquamacs-toggle-full-frame)
      (color-theme-initialize)
      (color-theme-clarity))
  (progn
    (message "Customizing GNU Emacs")
    (global-set-key "\C-cs" 'toggle-fullscreen)
    (set-default-font 
     "-bitstream-Bitstream Vera Sans Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
    (set-foreground-color "white")
    (set-background-color "black")
    (set-cursor-color "green")))


;
; Remaining entries (more or less) machine-specific 
; 

;
; Emacs Speaks Statistics (ESS)
;
;; (defun ess-mode ()
;;   (interactive)
;;   (load "~/local/ess-5.11/lisp/ess-site.el"))

;
; Scala mode
;
;; (add-to-list 'load-path "~/.emacs.d/scala-mode")
;; (require 'scala-mode-auto)

;
; Groovy mode
;
;; (add-to-list 'load-path "~/.emacs.d/groovy-mode")
;; (autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
;; (add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
;; (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
;; (add-hook 'groovy-mode-hook
;;           '(lambda ()
;;              (require 'groovy-electric)
;;              (groovy-electric-mode)))
