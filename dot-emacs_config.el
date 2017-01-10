;
; General emacs configurations
;
; Dave Andrzejewski
; 12/1/2014
;

(setq-default default-directory "~/")

; Spellcheck
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
(setq-default ispell-program-name "aspell")

; Font
(set-default-font 
 "-apple-Consolas-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")
;;(set-default-font 
;; "-bitstream-Bitstream Vera Sans Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1")

; use multiple spaces instead of tabs 
(setq-default indent-tabs-mode nil)

; allow dired to recursively copy directories
(setq dired-recursive-copies t)

; final newline compatibility
(setq require-final-newline t)

; see line/col number
(line-number-mode t)
(column-number-mode t)

; get rid of GUI and toolbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; aliases for M-x 
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

; highlight selected text
(transient-mark-mode t)

; copy selections to the X clipboard
(setq x-select-enable-clipboard t)

; allow these commands
(put 'eval-expression 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

; don't make foo.txt~ files
(setq make-backup-files nil) 

; easier goto-line
(global-set-key "\M-;" 'goto-line)

; make default "history" longer
(setq comint-input-ring-size 2000)

; change all yes/no questions to y/n 
(fset 'yes-or-no-p 'y-or-n-p)

; fancier buffer list
(global-set-key "\C-x\C-b" 'electric-buffer-list)

; dark bg / light fg for easier visibility
;; (set-foreground-color "white")
;; (set-background-color "black")
;; (set-cursor-color "green")

; flash screen instead of actual bell
(setq-default visible-bell t)

; Fixes for weird ssh/terminal behavior
;
;; The following two lines fix a problem that some people have. The original
;; emacs mapped C-h to be the help screen. Unfortunately, this is the same 
;; as backspace. So, attempting to press backspace would bring up a help;; screen. The new key-binding for help is C-x h.
(global-set-key "\^xh" 'help-for-help)
(global-set-key "\^h"  'backward-delete-char-untabify)
(global-set-key "\^d"  'backward-delete-char-untabify)

; for fancy syntax modes, etc
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

; Skip the splash screen
(set-variable 'inhibit-splash-screen t)

; avoid SLIME 'fontifying' regex msg in clojure-swank mode
(setq font-lock-verbose nil)
