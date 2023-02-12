(in-package :aggregator.persistence)

(defclass event-repository () ())

(defgeneric store-event (self evt)
  (:documentation "Store an event in the repository"))

(defgeneric get-event (self id)
  (:documentation "Retrieve an event from the repository"))

(defmethod store-event ((self event-repository) (evt event))
  nil)

(defmethod get-event ((self event-repository) id)
  nil)

(defclass event-repository-memory (event-repository)
  ((events :accessor events :initform (make-hash-table :test 'string=))))

(defmethod store-event ((self event-repository-memory) (evt event))
  (setf (gethash (id evt) (events self)) evt))

(defmethod get-event ((self event-repository-memory) id)
  (gethash id (events self)))
