(in-package :bel-utils)

(export '(aif it))
(defmacro aif (predicate consequent &optional else)
  `(let ((it ,predicate))
     (if it
	 ,consequent
	 ,else)))

(export 'aifn)
(defmacro aifn ((varname predicate) consequent &optional else)
  "anaphoric if named. Similar to anaphoric if, but allows you to choose the name that will be bound to the result of predicate within the scope of the form"
  `(let ((,varname ,predicate))
     (if ,varname
	 ,consequent
	 ,else)))

(export 'with-gensyms)
(defmacro with-gensyms (syms &body body)
  `(let ,(mapcar #'(lambda (x)
		     `(,x (gensym)))
		 syms)
     ,@body))

(defun make-acond (clauses)
  (if clauses
      (let ((pred (caar clauses))
	    (forms (cdar clauses)))
	`(aif ,pred
	      (progn ,@forms)
	      ,(make-acond (cdr clauses))))))

(export '(acond it))
(defmacro acond (&rest clauses)
  (make-acond clauses))
