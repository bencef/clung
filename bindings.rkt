#lang racket

(require ffi/unsafe
         ffi/unsafe/define)

(define-ffi-definer clang-define (ffi-lib "libclang"))

;; Typedefs from http://clang.llvm.org/doxygen/group__CINDEX.html
(define _CXClientData (_cpointer 'void))

(define _CXIndex (_cpointer 'void))

(define _CXString (_cpointer 'void))

(define _CXTranslationUnit (_cpointer 'CXTranslationUnitImpl)) ; acculy struct CXTranslationUnitImpl*

;; enums
(define _CXChildVisitResult (_enum '(CXChildVisit_Break
                                     CXChildVisit_Continue
                                     CXChildVisit_Recurse)))

;; Typedef for visitor procedures
(define _CXCursorVisitor (_cprocedure '(_CXCursor _CXCursor _CXClientData) _CXChildVisitResult))

;; Various structs
(define-cstruct _CXUnsavedFile ([Filename _string]
                                [Contents _string]
                                [Length _uint]))

(define-cstruct _CXCursor ([kind _CXChildVisitResult]
                           [xdata _int]
                           [data (_cpointer 'void)])) ; TODO "void * data[3]" so i guess array 3 of void* ?

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX.html
(clang-define clang_createIndex
  (_fun _int     ; exclude declarations from precompiled header
   _int          ; display diagnostics
   -> _CXIndex)) ; return

(clang-define clang_CXIndex_getGlobalOptions (_fun _CXIndex -> _uint))

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX__TRANSLATION__UNIT.html
(clang-define clang_createTranslationUnitFromSourceFile
  (_fun _CXIndex                     ; mutual index for linking
   _string                           ; file path
   _int                              ; number of command line arguments
   (_or-null (_cpointer 'string))    ; command line arguments
   _uint                             ; number of unsaved files
   (_or-null _CXUnsavedFile-pointer) ; array of unsaved files
   -> _CXTranslationUnit))           ; return

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX__CURSOR__MANIP.html
(clang-define clang_getTranslationUnitCursor (_fun _CXTranslationUnit -> _CXCursor))

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX__CURSOR__TRAVERSAL.html
(clang-define clang_visitChildren
  (_fun _CXCursor    ; root node
    _CXCursorVisitor ; TODO !!!!! function pointers provided by us. oh boi
    _CXClientData    ; passed to visitor function TODO clarify
    -> _uint))       ; return TODO check this (enum CXChildVisitResult)

(clang-define clang_getTranslationUnitSpelling (_fun _CXTranslationUnit -> _CXString))

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX__STRING.html
(clang-define clang_getCString (_fun _CXString -> _string))

(clang-define clang_disposeString (_fun _CXString -> _void))

(provide (except-out (all-defined-out)
           clang-define))
