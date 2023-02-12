(in-package #:aggregator.message)

(defclass query (message)
  ((context :accessor context :initform "query")))
