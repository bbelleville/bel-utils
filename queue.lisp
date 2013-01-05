(in-package :bel-utils)

(defclass queue ()
  ((head :accessor queue-head :initform nil)
   (tail :accessor queue-tail :initform nil)))

(defclass queue-node ()
  ((queue :accessor node-queue :initform nil :initarg :queue)
   (next :accessor node-next :initform nil :initarg :next)
   (previous :accessor node-previous :initform nil :initarg :previous)
   (contents :accessor node-contents :initform nil :initarg :contents)))

(defgeneric enqueue (queue object)
  (:documentation "Adds object to the begining of queue"))

(defmethod enqueue ((queue queue) object)
  (let ((new-node (make-instance 'queue-node :contents object :queue queue :next (queue-head queue))))
    (aif (queue-head queue)
	 (setf (node-previous it) new-node)
	 (setf (queue-tail queue) new-node))
    (setf (queue-head queue) new-node))
  object) 

(defgeneric dequeue (queue)
  (:documentation "Removes the object at the end of the queue and returns that object as the primary value, or nil if the queue was empty. Returns nil as the secondary value if the queue was empty, or t if it was not"))

(defmethod dequeue ((queue queue))
  (aifn (last (queue-tail queue))
	(progn
	  (aif (node-previous last)
	       (setf (node-next it) nil
		     (queue-tail queue) it)
	       (setf (queue-head queue) nil
		     (queue-tail queue) nil))
	  (values (node-contents last) t))
	(values nil nil)))

(defgeneric peek (queue)
  (:documentation "Returns the last object in the queue as the primary value, or nil if the queue is empty. Returns nil as the secondary value if the queue is empty, or t if it is not empty. The last item is not removed from the queue"))

(defmethod peek ((queue queue))
  (aif (queue-tail queue)
       (values (node-contents it) t)
       (values nil nil)))