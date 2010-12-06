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
; Remaining entries should be machine-specific 
; (more or less)
;

;
; Emacs Speaks Statistics (ESS)
;
(defun ess-mode ()
  (interactive)
  (load "~/local/ess-5.11/lisp/ess-site.el"))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

; Need to tell swank where to find the jars
(setq swank-clojure-classpath 
      (list "~/.cljr/lib/clojure-1.2.0-beta1.jar"
            "~/.cljr/lib/clojure-contrib-1.2.0-beta1.jar"
            "~/.cljr/lib/swank-clojure-1.2.1.jar"))
