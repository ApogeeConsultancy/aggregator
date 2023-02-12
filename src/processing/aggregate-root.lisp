(in-package :aggregate.processing)

(defclass aggregate-root (subscriber subscribable)
  ((aggregate-repository :accessor aggregate-repository
                         :initform nil)
   (aggregate-type :accessor aggregate-type
                   :initform 'aggregate)))

(defgeneric make-repository (self agg-type)
  (:documentation "Create a new repository."))

(defgeneric determine-affected-aggregate-ids (self event)
  (:documentation "Determine all IDs of affected aggregates, for an event."))

(defmethod make-repository ((self aggregate-root) agg-type)
  (make-instance 'aggregate-repository-memory :aggregate-type agg-type))

(defmethod determine-affected-aggregate-ids ((self aggregate-root) (evt event))
  nil)

(defmethod initialize-instance :around ((self aggregate-root) &key agg-type)
  (call-next-method
   self
   :aggregate-repository (make-repository agg-type)
   :aggregate-type agg-type))

(defmethod get-empty-aggregate ((self aggregate-root) aggregate-id)
  (make-instance (aggregate-type self) :id aggregate-id))

(defmethod get-aggregate ((self aggregate-root) aggregate-id)
  (let* ((agg (get-empty-aggregate self aggregate-id))
         (events (get-linked-events (aggregate-repository self)
                                    aggregate-id)))
    (reduce #'(lambda (agg event) (apply-event agg event))
            events
            :initial-value agg)))

(defmethod handle ((self aggregate-root) (evt event))
  (let ((affected-ids (determine-affected-aggregate-ids self evt)))
    (loop for agg-id in (determine-affected-aggregate-ids self evt)
          do (link-event (aggregate-repository self) evt agg-id))
    (notify self "ALL" (list (aggregate-type self) affected-ids))))
