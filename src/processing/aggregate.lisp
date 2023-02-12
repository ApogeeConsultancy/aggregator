(in-package :aggregate.processing)

(defclass aggregate ()
  ((agg-id :accessor agg-id :initform (print-object (make-v4-uuid) nil))
   (exists :accessor exists :initform nil)
   (events :accessor events :initform nil)))

(defgeneric apply-event (self event)
  (:documentation "Apply event to aggregate. Returns the aggregate with changes."))

(defmethod apply-event ((self aggregate) (evt event))
  nil)

(defmethod apply-event :after ((self aggregate) (evt event))
  (setf (events self) (append (events self) (list evt))))
