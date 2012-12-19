(asdf:defsystem "bel-utils"
  :description "Contains basic utilities that may be useful in a number of programs"
  :author "Brian Belleville"
  :components ((:file "package")
	       (:file "macros" :depends-on ("package"))
	       (:file "functions" :depends-on ("macros"))
	       (:file "queue" :depends-on ("macros"))))