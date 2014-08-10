;;; Compiled by f2cl version:
;;; ("$Id: f2cl1.l,v 1.209 2008/09/11 14:59:55 rtoy Exp $"
;;;  "$Id: f2cl2.l,v 1.37 2008/02/22 22:19:33 rtoy Rel $"
;;;  "$Id: f2cl3.l,v 1.6 2008/02/22 22:19:33 rtoy Rel $"
;;;  "$Id: f2cl4.l,v 1.7 2008/02/22 22:19:34 rtoy Rel $"
;;;  "$Id: f2cl5.l,v 1.197 2008/09/11 15:03:25 rtoy Exp $"
;;;  "$Id: f2cl6.l,v 1.48 2008/08/24 00:56:27 rtoy Exp $"
;;;  "$Id: macros.l,v 1.106 2008/09/15 15:27:36 rtoy Exp $")

;;; Using Lisp International Allegro CL Enterprise Edition 8.1 [64-bit Linux (x86-64)] (Oct 7, 2008 17:13)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t)
;;;           (:relaxed-array-decls t) (:coerce-assigns :as-needed)
;;;           (:array-type ':array) (:array-slicing t)
;;;           (:declare-common nil) (:float-format double-float))

(in-package :clml.lapack)


(let* ((one 1.0) (zero 0.0))
  (declare (type (double-float 1.0 1.0) one)
   (type (double-float 0.0 0.0) zero) (ignorable one zero))
  (defun dgetf2 (m n a lda ipiv info)
    (declare (type (array double-float (*)) a)
     (type (array f2cl-lib:integer4 (*)) ipiv)
     (type (f2cl-lib:integer4) info lda n m))
    (f2cl-lib:with-multi-array-data ((ipiv f2cl-lib:integer4
                                      ipiv-%data% ipiv-%offset%)
                                     (a double-float a-%data%
                                      a-%offset%))
      (prog ((j 0) (jp 0))
            (declare (type (f2cl-lib:integer4) j jp))
            (setf info 0)
            (cond ((< m 0) (setf info -1))
                  ((< n 0) (setf info -2))
                  ((< lda
                      (max (the f2cl-lib:integer4 1)
                           (the f2cl-lib:integer4 m)))
                   (setf info -4)))
            (cond ((/= info 0)
                   (xerbla "DGETF2" (f2cl-lib:int-sub info))
                   (go end_label)))
            (if (or (= m 0) (= n 0)) (go end_label))
            (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                          ((> j
                              (min (the f2cl-lib:integer4 m)
                                   (the f2cl-lib:integer4 n)))
                           nil)
                          (tagbody
                              (setf jp
                                    (f2cl-lib:int-add (f2cl-lib:int-sub j
                                                                        1)
                                                      (idamax
                                                       (f2cl-lib:int-add (f2cl-lib:int-sub m
                                                                                           j)
                                                                         1)
                                                       (f2cl-lib:array-slice a
                                                                             double-float
                                                                             (j
                                                                              j)
                                                                             ((1
                                                                               lda)
                                                                              (1
                                                                               *)))
                                                       1)))
                              (setf (f2cl-lib:fref ipiv-%data% (j)
                                                   ((1 *))
                                                   ipiv-%offset%)
                                    jp)
                              (cond ((/= (f2cl-lib:fref a (jp j)
                                                        ((1 lda)
                                                         (1 *)))
                                         zero)
                                     (if (/= jp j)
                                         (dswap n
                                          (f2cl-lib:array-slice a
                                                                double-float
                                                                (j 1)
                                                                ((1
                                                                  lda)
                                                                 (1
                                                                  *)))
                                          lda
                                          (f2cl-lib:array-slice a
                                                                double-float
                                                                (jp 1)
                                                                ((1
                                                                  lda)
                                                                 (1
                                                                  *)))
                                          lda))
                                     (if (< j m)
                                         (dscal (f2cl-lib:int-sub m j)
                                          (/ one
                                             (f2cl-lib:fref a-%data%
                                                            (j j)
                                                            ((1 lda)
                                                             (1 *))
                                                            a-%offset%))
                                          (f2cl-lib:array-slice a
                                                                double-float
                                                                ((+ j
                                                                    1)
                                                                 j)
                                                                ((1
                                                                  lda)
                                                                 (1
                                                                  *)))
                                          1)))
                                    ((= info 0) (setf info j)))
                              (cond ((< j
                                        (min (the f2cl-lib:integer4 m)
                                             (the f2cl-lib:integer4
                                                  n)))
                                     (dger (f2cl-lib:int-sub m j)
                                      (f2cl-lib:int-sub n j) (- one)
                                      (f2cl-lib:array-slice a
                                                            double-float
                                                            ((+ j 1) j)
                                                            ((1 lda)
                                                             (1 *)))
                                      1
                                      (f2cl-lib:array-slice a
                                                            double-float
                                                            (j
                                                             (f2cl-lib:int-add j
                                                                               1))
                                                            ((1 lda)
                                                             (1 *)))
                                      lda
                                      (f2cl-lib:array-slice a
                                                            double-float
                                                            ((+ j 1)
                                                             (f2cl-lib:int-add j
                                                                               1))
                                                            ((1 lda)
                                                             (1 *)))
                                      lda)))
                            label10))
            (go end_label)
       end_label (return (values nil nil nil nil nil info))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dgetf2
                 fortran-to-lisp::*f2cl-function-info*)
        (fortran-to-lisp::make-f2cl-finfo :arg-types '((fortran-to-lisp::integer4)
                                                       (fortran-to-lisp::integer4)
                                                       (array
                                                        double-float
                                                        (*))
                                                       (fortran-to-lisp::integer4)
                                                       (array
                                                        fortran-to-lisp::integer4
                                                        (*))
                                                       (fortran-to-lisp::integer4))
          :return-values '(nil nil nil nil nil fortran-to-lisp::info)
          :calls '(fortran-to-lisp::dger fortran-to-lisp::dscal
                   fortran-to-lisp::dswap fortran-to-lisp::idamax
                   fortran-to-lisp::xerbla))))

