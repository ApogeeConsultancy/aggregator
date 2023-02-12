(in-package :aggregator.processing)

(defclass subscriber ()
  ((sub-id :accessor sub-id :initform (print-object (make-v4-uuid) nil))
   (in-ch :accessor in-ch :initform (make-instance 'channel))))

(defgeneric handle (self message)
  (:documentation "Handle a message"))

(defmethod handle ((self subscriber) message)
  nil)

(defmethod process-messages ((self subscriber))
  (pexec (:name (format nil "Subscriber ~a" (sub-id self)))
         (loop (handle self (recv (in-ch self))))))
