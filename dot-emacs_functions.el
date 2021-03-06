;
; Custom functions and keyboard shortcuts
;
; Dave Andrzejewski
; 12/1/2014
;

;;; https://www.emacswiki.org/emacs/UnfillParagraph
;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

;;; https://www.emacswiki.org/emacs/UnfillRegion
(defun unfill-region (beg end)
  "Unfill the region, joining text paragraphs into a single
    logical line.  This is useful, e.g., for use with
    `visual-line-mode'."
  (interactive "*r")
  (let ((fill-column (point-max)))
    (fill-region beg end)))



; This is better than shell, within ansi-term
; C-x C-j = switch to emacs style
; C-c C-k = switch to term style
(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'my-term-use-utf8)

(defun quick-ansi-term ()
  (interactive)
  (progn
    (ansi-term "/usr/local/bin/zsh")
    (term-char-mode)))
(global-set-key "\M-n" 'quick-ansi-term)

; Easier goto-line
(global-set-key "\M-;" 'goto-line)

; Easier query-replace
;(global-set-key "\C-w" 'yafolding-toggle-element)

; Easier query-replace
(global-set-key "\C-cq" 'query-replace)

; Hack dired to launch files with 'l' key.
(defun dired-launch-command ()
  (interactive)
  (dired-do-shell-command
   (if (string-match "darwin" (symbol-name system-type))
       "open"
     "gnome-open")
   nil
   (dired-get-marked-files t current-prefix-arg)))

(setq dired-load-hook
      (lambda (&rest ignore)
 (define-key dired-mode-map
   "l" 'dired-launch-command)))


; Common use case where 
; -one window contains an active LaTeX document
; -the other window contains the corresponding bibtex
;

; Use this command from LaTeX doc, where point in other
; window is at the start of the ref you want 
(defun get-cite ()
  (save-current-buffer
    (progn
      (set-buffer (window-buffer (next-window)))
      (buffer-substring-no-properties (point)
                                      (- (search-forward ",") 1)))))

(defun cite-reference ()
  (interactive)  
  (insert (format "\\cite{%s}" (get-cite))))

(global-set-key "\C-cr" 'cite-reference)

; Do this to emulate Eclipse shortcut
(global-set-key "\C-ci" 'indent-region)

(defun count-re-match (re)
  (interactive "sRegular expression:")
  (save-excursion
    (let ((count 0))
      (while (re-search-forward re nil t) ; noerror=t returns nil on fail
        (setq count (1+ count)))
      (message (format "%d regular expression matches" count)))))

; Fullscreen (for non-Aquamacs)
(defun toggle-fullscreen (&optional f)
   (interactive)
   (let ((current-value (frame-parameter nil 'fullscreen)))
     (set-frame-parameter nil 'fullscreen
                          (if (equal 'fullboth current-value)
                              (if (boundp 'old-fullscreen) old-fullscreen nil)
                            (progn (setq old-fullscreen current-value)
                                   'fullboth)))))
(global-set-key "\C-cs" 'toggle-fullscreen)

; Comment/uncommenting across all modes (not just C-like)
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

; treat current line as filename and open in new buffer
(defun fopen ()
  (interactive)
  (find-file 
   (buffer-substring-no-properties (point)
                                   (- (search-forward "\n") 1))
   "Error opening file"))
(global-set-key "\C-cf" 'fopen)

; disable 'compose mail' command
(defun no-mail () 
  (interactive)
  (message "DID NOT MEAN TO COMPOSE AN E-MAIL"))
(global-set-key "\C-x\m" 'no-mail)
