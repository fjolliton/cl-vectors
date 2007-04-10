;;;; -*- Lisp -*- mode

;;;; cl-vectors -- Rasterizer and paths manipulation library
;;;; Copyright (C) 2007  Frédéric Jolliton <frederic@jolliton.com>
;;;; 
;;;; This library is free software; you can redistribute it and/or
;;;; modify it under the terms of the Lisp Lesser GNU Public License
;;;; (http://opensource.franz.com/preamble.html), known as the LLGPL.
;;;; 
;;;; This library is distributed in the hope that it will be useful, but
;;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Lisp
;;;; Lesser GNU Public License for more details.

(defpackage #:cl-vectors-system
  (:use #:cl #:asdf))

(in-package #:cl-vectors-system)

(defsystem #:cl-vectors
  :description "cl-paths: vectorial paths manipulation"
  :version "$VERSION$"
  :author "Frederic Jolliton <frederic@jolliton.com>"
  :licence "LLGPL (http://opensource.franz.com/preamble.html)"
  :depends-on ("cl-aa" "cl-paths")
  :components ((:file "vectors")))