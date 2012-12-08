(in-package :bel-utils)

(export '(aif it))
(defmacro aif (predicate consequent &optional else)
  `(let ((it ,predicate))
     (if it
	 ,consequent
	 ,else)))

(export 'with-gensyms)
(defmacro with-gensyms (syms &body body)
  `(let ,(mapcar #'(lambda (x)
		     `(,x (gensym)))
		 syms)
     ,@body))