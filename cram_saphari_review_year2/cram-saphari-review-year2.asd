; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(asdf:defsystem cram-saphari-review-year2
  :name "cram-saphari-review-year2"
  :author "Georg Bartels <georg.bartels@cs.uni-bremen.de>"
  :version "0.1"
  :maintainer "Georg Bartels <georg.bartels@cs.uni-bremen.de>"
  :licence "BSD"
  :description "CRAM code for Saphari Year 2 review"
  :depends-on (:cram-language
               :designators 
               :cram-language-designator-support
               :cram-reasoning
               :cram-beasty
               :roslisp-utilities
               :roslisp
               :saphari_msgs-msg
               :cl-human-shapes
               :cl-3d-shapes
               :cl-transforms
               :cl-tf
               :cram-ptu
               :cram-ik-proxy)
  :components
  ((:module "src"
            :components
            ((:file "package")
             (:file "tf" :depends-on ("package"))
             (:file "human-perception" :depends-on ("package"))
             (:file "robot-configuration" :depends-on ("package"))
             (:file "ros-misc" :depends-on ("package" "robot-configuration" "human-perception" "tf"))
             (:file "demo-plans" :depends-on ("package" "robot-configuration"))
             (:file "reasoning" :depends-on ("package" "robot-configuration"))
             (:file "sandbox" :depends-on ("package" "reasoning" "robot-configuration"))))))