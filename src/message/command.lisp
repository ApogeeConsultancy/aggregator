(in-package #:aggregator.message)

(defclass command (message)
  ((context :accessor context :initform "command")))
