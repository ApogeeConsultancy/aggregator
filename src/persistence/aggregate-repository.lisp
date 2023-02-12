(in-package :aggregator.persistence)

(defclass aggregate-repository ()
  ((aggregate-type :accessor aggregate-type :initform nil)))

(defgeneric link-event (self evt agg-id)
  (:documentation "Links an event to an aggregate."))

(defgeneric get-linked-events (self agg-id)
  (:documentation "Gets all events linked to an aggregate ID in date order."))

(defmethod link-event ((self aggregate-repository) (evt event) agg-id)
  nil)

(defmethod get-linked-events ((self aggregate-repository) agg-id)
  '())

(defclass aggregate-repository-memory ()
  ((events :accessor events :initform (make-hash-table :test 'equal))))

(defmethod link-event ((self aggregate-repository-memory) (evt event) agg-id)
  (setf (gethash agg-id (events self))
        (append (gethash agg-id (events self)) (list evt))))

(defmethod get-linked-events ((self aggregate-repository-memory) agg-id)
  (sort (gethash agg-id (events self))
        #'(lambda (x y) (< (datetime x) (datetime y)))))
