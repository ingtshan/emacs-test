;;; load-org-roam.el -*- lexical-binding: t; no-byte-compile: t; -*-

;;  roam

(when (and *emacs/>=26p* (executable-find "cc"))
  (leaf org-roam
    :diminish org-roam-mode
    :hook ((after-init-hook . org-roam-db-autosync-enable)) 
    :bind (("C-c rt" . org-roam-buffer-toggle)
           ("C-c rn" . org-roam-node-find)
           ("C-c ri" . org-roam-node-insert)
           ("C-c rc" . org-roam-capture)
           ("C-c rj" . org-roam-dailies-goto-today))
    :init
    (setq
     org-roam-directory (file-truename =roam-dir)
     ;;(expand-file-name "roam-v2" =org-dir)
     org-roam-v2-ack t)
    :config 
    (unless (file-exists-p org-roam-directory)
      (make-directory org-roam-directory))
    (unless (file-exists-p (expand-file-name "daily" org-roam-directory))
      (make-directory
       (expand-file-name "daily" org-roam-directory)))))

;; (require 'consult)
;; rely on ripgrep (you should install in your os)
(defun ns/org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
  (interactive)
  (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-roam-directory)))

(defun ns/consult-ripgrep-files-with-matches (&optional dir initial)
  "Use consult-find style to return matches with \"rg --file-with-matches \". No live preview."
  (interactive "P")
  (let ((consult-find-command "rg --ignore-case --type org --files-with-matches . -e ARG OPTS"))
    (consult-find dir initial)))

(defun ns/org-roam-rg-file-search ()
  "Search org-roam directory using consult-find with \"rg --file-with-matches \". No live preview."
  (interactive)
  (ns/consult-ripgrep-files-with-matches org-roam-directory))

(global-set-key (kbd "C-c rr") #'ns/org-roam-rg-search)
(global-set-key (kbd "C-c rf") #'ns/org-roam-rg-file-search)

;; ;; there is a problem deft cause while using roam
;; ;; https://emacs-china.org/t/org-roam-v2-deft/18042/16?u=ingtshan
;; (with-eval-after-load 'deft
;;   (defun ns/deft-parse-title (file contents)
;;     "Parse the given FILE and CONTENTS and determine the title.
;;   If `deft-use-filename-as-title' is nil, the title is taken to
;;   be the first non-empty line of the FILE.  Else the base name of the FILE is
;;   used as title."

;;     (let ((begin (string-match "^#\\+[tT][iI][tT][lL][eE]: .*$" contents)))
;; 	  (if begin (string-trim (substring contents begin (match-end 0))
;;                              "#\\+[tT][iI][tT][lL][eE]: *" "[\n\t ]+")
;; 	    (deft-base-filename file))))

;;   (advice-add 'deft-parse-title :override #'ns/deft-parse-title)

;;   (setq
;;    deft-strip-summary-regexp
;;    (concat "\\("
;; 		   "[\n\t]" ;; blank
;; 		   "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
;; 		   "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
;; 		   "\\)")))

(provide 'load-org-roam)
;;; load-org-roam.el ends here
