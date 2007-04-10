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

(defpackage #:cl-paths-system
  (:use #:cl #:asdf))

(in-package #:cl-paths-system)

(defsystem #:cl-paths
  :description "cl-paths: vectorial paths manipulation"
  :version "$VERSION$"
  :author "Frederic Jolliton <frederic@jolliton.com>"
  :licence "LLGPL (http://opensource.franz.com/preamble.html)"
  :components ((:file "paths-package")
               (:file "paths" :depends-on ("paths-package"))
               (:file "paths-annotation" :depends-on ("paths-package" "paths"))))