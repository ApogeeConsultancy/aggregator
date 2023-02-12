(asdf:defsystem #:aggregator
  :author "Matt Doughty <matt@apogee.guru>"
  :description "Aggregator is an implementation of CQRS/ES principles in Common Lisp."
  :license "MIT"
  :depends-on (:chanl
               :closer-mop
               :local-time
               :marshal
               :uuid
               :verbose)
  :components ((:module "src"
                :components ((:file "package")
                             (:module "message"
                              :components ((:file "package")
                                           (:file "command")
                                           (:file "event")
                                           (:file "message")
                                           (:file "query")))
                             (:module "persistence"
                              :components ((:file "package")
                                           (:file "aggregate-repository")
                                           (:file "event-repository")))
                             (:module "processing"
                              :components ((:file "package")
                                           (:file "aggregate")
                                           (:file "aggregate-root")
                                           (:file "command-handler")
                                           (:file "event-bus")
                                           (:file "subscriber")
                                           (:file "subscribable")))))))
