;
; Custom functions and keyboard shortcuts
;

; Hack dired to launch files with 'l' key.
(defun dired-launch-command ()
  (interactive)
  (dired-do-shell-command
   (if (string-match "Aquamacs" (emacs-version))       
       "open"
     "gnome-open")
   nil
   (dired-get-marked-files t current-prefix-arg)))

(setq dired-load-hook
      (lambda (&rest ignore)
 (define-key dired-mode-map
   "l" 'dired-launch-command)))

; Browsing LDA topics
(defun goto-topic (tnum)
  (interactive "sTopic number:")
  (progn
    (goto-char (point-min))
    (search-forward (format "Topic %s" tnum))))
(global-set-key "\C-ct" 'goto-topic)

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
