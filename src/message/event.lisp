(in-package #:aggregator.message)

(defclass event (message)
  ((context :accessor context :initform "event")))
