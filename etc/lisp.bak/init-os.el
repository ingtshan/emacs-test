;;; init-os.el -*- lexical-binding: t; no-byte-compile: t; -*-

;;;;-----------------------------README-----------------------------
;;  os/ tool fun

(defun os/quit-emacs (&optional pfx)
  "quit emacs with confirm"
  (interactive "P")
  (when (or pfx (y-or-n-p "Quit emacs now?"))
    (save-buffers-kill-terminal)))

(defun os/close-frame (&optional pfx)
  "close emacs frame"
  (interactive "P")
  (let ((q nil))
    (condition-case ex
	    (delete-window) ('error (setq q t)))
    (if q (progn (setq q nil)
		         (condition-case ex
		             (delete-frame) ('error (setq q t)))
		         (if q (os/quit-emacs pfx))))))

;;;;-----------------------------README-----------------------------
;;  OS adapt
;; bind key to 'hyper and 'meta
(funitcall +system-key-adapte)

;; what different between (kbd "H-v") and [(hyper v)] ?
(global-set-key (kbd "H-a") #'mark-page)         ;; 全选
(global-set-key (kbd "H-v") #'yank)              ;; 粘贴
(global-set-key (kbd "H-x") #'kill-region)       ;; 剪切
(global-set-key (kbd "H-c") #'kill-ring-save)    ;; 复制
(global-set-key (kbd "H-s") #'save-buffer)       ;; 保存
(global-set-key (kbd "H-z") #'vundo)             ;; 撤销编辑修改
(global-set-key (kbd "H-l") #'goto-line)         ;; 行跳转

(global-set-key [(hyper n)] #'make-frame-command);; 新建窗口
(global-set-key [(hyper q)] #'os/quit-emacs)     ;; 退出
(global-set-key [(hyper w)] #'os/close-frame)    ;; 退出frame

;; use shift to extend select
(global-set-key (kbd "<S-down-mouse-1>") #'mouse-save-then-kill)
;;;;-------------------------------END------------------------------
(provide 'init-os)
;;; init-os.el ends here
