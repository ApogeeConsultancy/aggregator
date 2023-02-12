(in-package #:cl-user)

(defpackage #:aggregator.message
  (:use #:cl)
  (:import-from :closer-mop
                :class-slots
                :slot-definition-name
                :standard-effective-slot-definition)
  (:import-from :local-time
                :now
                :timestamp-to-unix
                :timestamp-millisecond)
  (:import-from :uuid :make-v4-uuid :print-object)
  (:nicknames :agg-msg :am)
  (:export #:command
           #:event
           #:query
           #:as-string
           #:id
           #:correlation-id
           #:context
           #:msg-type
           #:datetime))
