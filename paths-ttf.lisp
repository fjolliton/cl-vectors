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

(defpackage #:net.tuxee.paths-ttf
  (:use #:cl #:net.tuxee.paths #:zpb-ttf)
  (:nicknames #:paths-ttf)
  (:export #:paths-from-glyph
           #:paths-from-string))

(in-package #:net.tuxee.paths-ttf)

(defun paths-from-glyph (glyph &key (offset (make-point 0 0)) (scale-x 1.0) (scale-y 1.0))
  (flet ((point (p) (p+ (make-point (* (x p) scale-x)
                                    (* (y p) scale-y))
                        offset)))
    (let (result)
      (do-contours (contour glyph)
        (let ((path (create-path :polygon))
              (last-point nil))
          (do-contour-segments (a b c) contour
            (let ((pa (point a))
                  (pb (when b (point b)))
                  (pc (point c)))
              (if last-point
                  (assert (and (= (point-x last-point) (point-x pa))
                               (= (point-y last-point) (point-y pa))))
                  (path-reset path pa))
              (if b
                  (path-extend path (make-bezier-curve (list pb)) pc)
                  (path-extend path (make-straight-line) pc))
              (setf last-point pc)))
          (when (minusp (* scale-x scale-y))
            (path-reverse path))
          (push path result)))
      (nreverse result))))

(defun paths-from-string (font-loader text &key (offset (make-point 0 0)) (scale-x 1.0) (scale-y 1.0))
  (let (result)
    (loop
       for previous-char = nil then char
       for char across text
       for previous-glyph = nil then glyph
       for glyph = (zpb-ttf:find-glyph char font-loader)
       do (when previous-char
            (setf offset
                  (paths::p+ offset
                             (make-point (* scale-x
                                            (+ (zpb-ttf:advance-width previous-glyph)
                                               (zpb-ttf:kerning-offset previous-char
                                                                       char
                                                                       font-loader)))
                                         0))))
       (let ((glyph-paths (paths-from-glyph glyph
                                            :offset offset :scale-x scale-x :scale-y scale-y)))
         (push glyph-paths result)))
    (apply #'nconc (nreverse result))))