(defun shell-command-on-region-to-string (start end command)
  (with-output-to-string
    (shell-command-on-region start end command standard-output)))

(defun shell-command-on-region-with-output-to-end-of-buffer (start end command)
  (interactive
   (let ((command (read-shell-command "Shell command on region: ")))
     (if (use-region-p)
         (list (region-beginning) (region-end) command)
       (list (point-min) (point-max) command))))
  (save-excursion
    (goto-char (point-max))
    (insert (shell-command-on-region-to-string start end command))))


(defun spacemacs/velo/exec-buffer ()
  "Asks for a command and executes it in inferior shell with current buffer
as input."
  (interactive)
  (setq vql-output (
               shell-command-on-region-to-string (point-min) (point-max) "veloq"))
  (setq vql-buffer (get-buffer-create "*VQL Output*"))
  (with-current-buffer vql-buffer
    (erase-buffer)
    (json-mode)
    (goto-char (point-max))
    (insert vql-output))
  (display-buffer vql-buffer))
