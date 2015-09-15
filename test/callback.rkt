#lang racket

(require "../bindings.rkt"
         ffi/unsafe)

(define idx (clang_createIndex 0 0))

(define tu (clang_createTranslationUnitFromSourceFile idx "./tu.cpp" '() '()))

(define (print-function-info cur)
  (let ([str-handle (clang_getCursorSpelling cur)])
    (begin
      (write "function name: ")
      (write (clang_getCString str-handle))
      (newline)
      (clang_disposeString str-handle))))

(define (dump-functions cur parent data)
  (begin
    (if (= (CXCursor-kind cur) 'CXCursor_FunctionDecl)
      (print-function-info cur)
      #f)
    'CXChildVisit_Continue))

;(let ((root (clang_getTranslationUnitCursor tu)))
;  (clang_visitChildren root dump-functions #f))

(let ((root (clang_getTranslationUnitCursor tu)))
  (cpointer? root))
