(in-package :bel-utils)

(defun pos-chars (char-bag s)
  "returns a list containing all of the positions of any element of char-bag in string"
  (declare (type string s))
  (do ((end (length s))
       (index 0 (1+ index))
       (acc nil))
      ((>= index end) (nreverse acc))
    (if (find (aref s index) char-bag)
	(push index acc))))

(defun break-string (char s)
  (declare (type character char)
	   (type string s))
  (let ((pos (position char s)))
    (if pos
	(values (subseq s 0 pos)
		(subseq s (1+ pos)))
	(values s ""))))

(defun split-string (char-bag s)
  (let ((delim-pos (pos-chars char-bag s)))
    (labels ((substring (start-pos end-list)
	       (subseq s
		       (or
			(and
			 start-pos
			 (+ start-pos 1))
			0)
		       (car end-list)))
	     (cons-if-not-empty (string acc)
	       (if (equal string "")
		   acc
		   (cons string acc)))
	     (rec (start-pos end-list acc)
	       (cond ((and (null start-pos)  (null end-list))
		      (cons s acc))
		     ((null end-list)
		      (cons-if-not-empty (substring start-pos end-list) acc))
		     (t (rec (car end-list)
			     (cdr end-list)
			     (cons-if-not-empty (substring start-pos end-list) acc))))))
      (nreverse (rec nil delim-pos nil)))))

(defun string-keyword (string)
  (declare (type string string))
  (intern (string-upcase string) :keyword))

(defun assoc-list-to-hash-table (assoc-list)
  "takes an assoc list and returns a hash table with the keys and values from the assoc list"
  (let ((table (make-hash-table)))
    (dolist (x assoc-list table)
      (setf (gethash (car x) table) (cadr x)))))
		     