(in-package :bel-utils)

(defmacro with-gensyms ((syms) &body body)
  `(let ,(mapcar #'(lambda (x)
		     `(,x (gensym)))
		 syms)
     ,@body))