(defpackage #:qlot/tests/utils
  (:use #:cl
        #:rove
        #:qlot/utils))
(in-package #:qlot/tests/utils)

(deftest with-in-directory-tests
  (let ((cwd (uiop:getcwd)))
    #+(or mswindows win32)
    (with-in-directory #P"C:/"
      (ok (equal (uiop:native-namestring (uiop:getcwd)) "C:\\\\")))
    #-(or mswindows win32)
    (with-in-directory #P"/"
      (ok (equal (uiop:getcwd) #P"/")))
    (ok (equal (uiop:getcwd) cwd))))

(deftest make-keyword-tests
  (ok (eq (make-keyword "foo") :foo))
  (ok (eq (make-keyword "FOO") :foo))
  (ok (eq (make-keyword "Foo") :foo))
  (ok (eq (make-keyword :|foo|) :foo))
  (ok (eq (make-keyword '|foo|) :foo))
  (ok (signals (make-keyword 1))))

(deftest split-with-tests
  (ok (equal (split-with #\Space "a b c")
             '("a" "b" "c")))
  (ok (equal (split-with #\Space "  a   b c ")
             '("a" "b" "c")))
  (ok (equal (split-with #\Space "abc")
             '("abc")))
  (ok (equal (split-with #\Space "a b c " :limit 2)
             '("a" "b c "))))
