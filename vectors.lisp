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

(defpackage #:net.tuxee.vectors
  (:use #:cl #:net.tuxee.aa #:net.tuxee.paths)
  (:nicknames #:vectors)
  (:export #:update-state))

(in-package #:net.tuxee.vectors)

(defun update-state (state paths)
  (if (listp paths)
      (dolist (path paths)
        (update-state state path))
      (let ((iterator (path-iterator-segmented paths)))
        (multiple-value-bind (i1 k1 e1) (path-iterator-next iterator)
          (declare (ignore i1))
          (when (and k1 (not e1))
            ;; at least 2 knots
            (let ((first-knot k1))
              (loop
                 (multiple-value-bind (i2 k2 e2) (path-iterator-next iterator)
                   (declare (ignore i2))
                   (line-f state
                           (point-x k1) (point-y k1)
                           (point-x k2) (point-y k2))
                   (setf k1 k2)
                   (when e2
                     (return))))
              (line-f state
                      (point-x k1) (point-y k1)
                      (point-x first-knot) (point-y first-knot)))))))
  state)
