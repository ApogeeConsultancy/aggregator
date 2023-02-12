(in-package :aggregator.processing)

(defclass subscribable ()
  ((subscribers :accessor subscribers :initform (make-hash-table :test 'equal))))

(defmethod subscribe-all ((self subscribable) (subscriber subscriber))
  (subscribe self subscriber "ALL"))

(defmethod subscribe ((self subscribable) (subscriber subscriber) type)
  (setf (gethash type (subscribers self))
        (append (gethash type (subscribers self)) (list (in-ch subscriber)))))

(defmethod unsubscribe ((self subscribable) (subscriber subscriber) type)
  (setf (gethash type (subscribers self))
        (remove-if #'(lambda (x) (eq x (in-ch subscriber)))
                   (gethash type (subscribers self)))))

(defmethod get-subscribers ((self subscribable) type)
  (remove-duplicates (append (gethash type (subscribers self))
                             (gethash "ALL" (subscribers self)))
                      :test 'eq))

(defmethod notify ((self subscribable) type message)
  (pexec () (loop for subscriber in (get-subscribers self type)
                  do (send subscriber message))))
