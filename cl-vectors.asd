;;;; -*- Lisp -*- mode

;;;; cl-vectors -- Rasterizer and paths manipulation library
;;;; Copyright (C) 2007-2013  Frédéric Jolliton <frederic@jolliton.com>
;;;; This code is licensed under the MIT license.

(defsystem "cl-vectors"
  :description "cl-paths: vectorial paths manipulation"
  ;; :version "$VERSION$"
  :author "Frederic Jolliton <frederic@jolliton.com>"
  :licence "MIT"
  :depends-on ("cl-aa" "cl-paths")
  :components ((:file "vectors")))
