;;; package concept

;;;;==============================note==============================
;; packages, package archives
;; 
;; large collections of Emacs Lisp packages.
;; Each package is a separate Emacs Lisp program
;;
;; 
;;;;================================================================
(package-user-dir) ;; ~/.emacs.d/elpa/
;;;;==============================note==============================
;; lisp libraries
;; - Lisp code
;; - lisp file
;;
;; load-file
;; load-path
;; load-library
;; load
;;
;; autoloaded
;;;;================================================================

(add-to-list 'load-path "/path/to/my/lisp/library")

 ;; Loads my-shining-package.elc unconditionally.
(require 'my-shining-package)

 ;; Will load my-shining-package.elc when my-func is invoked.
 (autoload 'my-func "my-shining-package")

;;;;==============================note==============================
;;; byte compilation
;; .el -complier-> .elc
;; symbol -complier-> byte-code function object
;;
;;; byte-code interpreter: execute the byte-code
;;
;;; byte-code function object
;; loads faster, takes up less space, and executes faster
;;;;================================================================

;; Byte-Compilation Functions
(byte-compile) ;; byte-compile an individual function or macro definition
(byte-compile-file ) ;; compile a whole file
(byte-recompile-directory) (batch-byte-compile.) ;; several files

;; usage
;; function wait for byte compile
(defun factorial (integer)
  "Compute factorial of INTEGER."
  (if (= 1 integer) 1
    (* integer (factorial (1- integer)))))
;; get byte-code function object format to string
(insert (format "%s" (byte-compile 'factorial)))

#[(integer) \301U\203 \301\207\302S!_\207 [integer 1 factorial] 3 Compute factorial of INTEGER.]
