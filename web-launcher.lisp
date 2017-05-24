; -*- coding: utf-8; mode: Lisp; fill-column: 76; tab-width: 4; -*-
; Brief: Web launcher.

(in-package :cl-user)

(defun log-base (prefix fmt &rest args)
  (let ((newfmt (concatenate 'string prefix fmt "~%")))
    (apply #'format t newfmt args)))

(defun log-title (fmt &rest args)
  (apply #'log-base "       -----> " fmt args))
(defun log-content (fmt &rest args)
  (apply #'log-base "              " fmt args))
(defun log-footer (fmt &rest args)
  (apply #'log-base "              [DONE]" fmt args))

(require :asdf)
(asdf:disable-output-translations)

(defvar *virtual-root*
  (pathname (concatenate
             'string (asdf::getenv "VIRTUAL_ROOT") "/")))
(defvar *sbcl-home*
  (pathname (concatenate
             'string (asdf::getenv "SBCL_HOME") "/")))
(defvar *port* (parse-integer (asdf::getenv "PORT")))

(log-title "Checking environment variables ...")
(log-content "VIRTUAL_ROOT = ~a" *virtual-root*)
(log-content "   SBCL_HOME = ~a" *sbcl-home*)
(log-content "        PORT = ~d" *port*)
(log-footer "")

(defun require-quicklisp ()
  (let ((quicklisp-init
         (merge-pathnames "quicklisp/setup.lisp" *virtual-root*)))
    (when (probe-file quicklisp-init)
      (load quicklisp-init))))

(require-quicklisp)

(log-title "Check SBCL-Framework before running ...")
(log-content "        SBCL Version ~a." (lisp-implementation-version))
(log-content "        ASDF Version ~a." (asdf:asdf-version))
(log-content "   Quicklisp Version ~a." (quicklisp-client:client-version))
(log-footer "")

(require :hunchentoot)
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port *port*))
(loop (sleep 1000))
