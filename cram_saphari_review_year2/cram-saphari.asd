; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(asdf:defsystem cram-saphari
  :name "cram-saphari"
  :author "Georg Bartels <georg.bartels@cs.uni-bremen.de>"
  :version "0.1"
  :maintainer "Georg Bartels <georg.bartels@cs.uni-bremen.de>"
  :licence "BSD"
  :description "CRAM code for Saphari development"
  :depends-on (:cram-language
               :cram-utilities
               :cram-beliefstate
               :designators
               :cram-language-designator-support
               :roslisp
               :alexandria
               :saphari_msgs-msg
               :saphari-msgs-conversions
               :roslisp-beasty)
  :components
  ((:module "cram-saphari"
            :components
            ((:file "package")
             (:file "beasty-movements" :depends-on ("package"))
             (:file "human-tracking" :depends-on ("package"))))))
