;;; Copyright (c) 2014, Georg Bartels <georg.bartels@cs.uni-bremen.de>
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;;
;;; * Redistributions of source code must retain the above copyright
;;; notice, this list of conditions and the following disclaimer.
;;; * Redistributions in binary form must reproduce the above copyright
;;; notice, this list of conditions and the following disclaimer in the
;;; documentation and/or other materials provided with the distribution.
;;; * Neither the name of the Institute for Artificial Intelligence/
;;; Universitaet Bremen nor the names of its contributors may be used to 
;;; endorse or promote products derived from this software without specific 
;;; prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;; POSSIBILITY OF SUCH DAMAGE.

(in-package :cram-saphari-review-year2)

(defun start-demo ()
  (top-level
    (with-process-modules-running (boxy-manipulation-process-module)
      (let ((action1 (make-designator 'action '((no description))))
            (monitoring-action (make-designator 
                                'action
                                '((to monitor)
                                  (detect collisions)))))
        (format t "~%~a~%" action1)
        (format 
         t "~%~a~%"
         (pm-execute 'boxy-manipulation-process-module monitoring-action))))))

(defun fluent-test ()
  (top-level
    (let ((fluent (cpl:make-fluent :value 0)))
      (format 
       t "~%RETURNED WITH:~a"
       (cpl:pursue
         (loop for i from 0 to 10 do
           (cpl:sleep* 0.3)
           (setf (cpl:value fluent) i))
         (cpl:whenever ((cpl:pulsed fluent))
           (format t "~%~a~%" (cpl:value fluent)))
         (progn
           (cpl:wait-for (cpl:eql fluent 8))
           11))))))

(defun velocity-tests ()
  (top-level
    ; designators...
    (let* ((small-increment 1)
           (big-increment 2)
           (increment big-increment)
           (goal 13)
           (counter 0))
      ; fluents
      (let ((fluent (cpl:make-fluent :value nil)))
        ; some recursive plan definition...
        (labels ((perform-with-safety ()
                   (format 
                    t "starting perform with counter=~a and increment=~a~%"
                    counter increment)
                   (let ((result (cpl:pursue
                                   (progn
                                     (loop while (< counter goal) do
                                       (progn
                                         (cpl:sleep* 0.1)
                                         (format t "incrementing by ~a~%" increment)
                                         (incf counter increment)))
                                     counter)
                                   (progn
                                     (cpl:sleep* 0.2)
                                     (format t "setting danger to ~a~%" (not (cpl:value fluent)))
                                     (setf (cpl:value fluent) (not (cpl:value fluent)))
                                     (cpl:value fluent)))))
                   (unless (typep result 'number)
                     (if (cpl:value fluent)
                         (setf increment small-increment)
                         (setf increment big-increment))
                     (perform-with-safety))
                   (values counter increment (cpl:value fluent)))))
          (perform-with-safety))))))