(declaim (optimize (speed 3)))

(defpackage :bel-utils
  (:use :cl)
  (:export

   ; functions symbols
   :split-string
   :string-keyword
   :assoc-list-to-hash-table
   :break-string

   ; macros symbols
   :mac
   :aif
   :it
   :aifn
   :with-gensyms
   :acond

   ; queue symbols
   :queue
   :enqueue
   :dequeue
   :peek))