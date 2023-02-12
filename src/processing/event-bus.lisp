(in-package :aggregator.processing)

(defclass event-bus (subscriber subscribable)
  ((event-repository :accessor event-repository
                     :initform (make-instance 'event-repository-memory))))

(defmethod handle ((self event-bus) (evt event))
  (store-event (event-repository self) evt)
  (notify self (msg-type evt) evt))
