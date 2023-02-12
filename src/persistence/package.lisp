(defpackage #:aggregator.persistence
  (:use #:cl)
  (:import-from :aggregator.message :event :id :datetime)
  (:nicknames :agg-pers :ar)
  (:export #:event-repository
           #:aggregate-repository
           #:event-repository-memory
           #:aggregate-repository-memory
           #:store-event
           #:get-event
           #:link-event
           #:get-linked-events))
