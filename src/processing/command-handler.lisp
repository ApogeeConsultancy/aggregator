(in-package :aggregate.processing)

(defclass command-handler (subscriber subscribable))

(defgeneric process-command (self cmd)
  (:documentation "Takes a command and returns a list of events or nil."))

(defmethod process-command ((self command-handler) (cmd command))
  nil)

(defmethod handle ((self command-handler) (cmd command))
  (let ((events (process-command self cmd)))
    (loop for evt in events
          do (notify self "ALL" evt))))
