#lang racket

(require "../bindings.rkt")

(define idx (clang_createIndex 0 0))

(define tu (clang_createTranslationUnitFromSourceFile idx "./tu.cpp" 0 #f 0 #f))

(let ([str-handle (clang_getTranslationUnitSpelling tu)])
  (begin
    (write (clang_getCString str-handle))
    (clang_disposeString str-handle)))
