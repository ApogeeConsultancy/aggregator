(defpackage #:aggregator.processing
  (:use #:cl)
  (:import-from :uuid
                :make-v4-uuid
                :print-object)
  (:import-from :chanl
                :channel
                :pexec
                :recv
                :send)
  (:import-from :aggregator.message
                :command
                :event
                :msg-type)
  (:import-from :aggregator.persistence
                :aggregate-repository-memory
                :event-repository-memory
                :store-event)
  (:nicknames :agg-proc :ap)
  (:export #:subscriber
           #:process-messages
           #:subscribable
           #:in-ch
           #:subscribe
           #:subscribe-all
           #:unsubscribe
           #:get-subscribers
           #:notify
           #:handle
           #:aggregate-root
           #:make-repository
           #:determine-affected-aggregate-ids
           #:get-aggregate
           #:aggregate
           #:apply-event
           #:command-handler
           #:process-command))
