(defun read-file (filepath)
  (if (file-exists-p filepath)
	  (with-temp-buffer
		(insert-file-contents filepath)
		(buffer-string))
	(error "No file found!"))
)

(defun clear-file (filepath)
  (if (file-exists-p filepath)
	  (progn
		(delete-file filepath)
		(make-empty-file filepath))
	(make-empty-file filepath)))

(defun initialize-config-file (path)
  (progn
	(setq compile-path "~/.emacs.d/HIXAC/compile-path")
    (clear-file compile-path)
	(append-to-file path nil compile-path)
	)
)

(defun set-compile-directory (dir)
  (interactive (list (read-directory-name "What directory? " default-directory)))
   (if (file-directory-p dir)
		 (initialize-config-file dir)
	 (message "Can not set this."))
)

(defun compile-dir (com)
  (interactive (list (read-shell-command "Compile command: ")))
  (progn
	(setq compile-path "~/.emacs.d/HIXAC/compile-path")
	(if (file-exists-p compile-path)
	    (progn
		  (setq path (read-file compile-path))
		  (with-temp-buffer
			(cd path)
			(compile com)))
	  (message "Set directory first!"))
	)
)

(global-set-key (kbd "C-<tab>") 'compile-dir)
