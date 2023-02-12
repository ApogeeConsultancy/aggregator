(in-package :aggregator.message)

(defun get-accurate-time ()
  (let* ((time-now (now))
         (time-now-as-timestamp (* 1000 (timestamp-to-unix time-now)))
         (time-now-with-ms (+ time-now-as-timestamp (timestamp-millisecond time-now))))
    time-now-with-ms))

(defclass message ()
  ((id :accessor id :initform (print-object (make-v4-uuid) nil))
   (correlation-id :accessor correlation-id :initform nil)
   (context :accessor context :initform "message")
   (msg-type :accessor msg-type :initform nil)
   (datetime :accessor datetime :initform (get-accurate-time))))

(defgeneric as-string (obj)
  (:documentation "Print a message object as a string."))

(defmethod as-string ((obj message))
  (format t
          "[~a] (~a) ~a.~a~&"
          (correlation-id message)
          (id message)
          (context message)
          (msg-type message)))

(defmethod ms:class-persistent-slots ((self message))
  (mapcar #'slot-definition-name (class-slots (class-of self))))
