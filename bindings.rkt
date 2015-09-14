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

(define _CXCursorKind (_enum '(CXCursor_UnexposedDecl = 1
                               CXCursor_StructDecl = 2
                               CXCursor_UnionDecl = 3
                               CXCursor_ClassDecl = 4
                               CXCursor_EnumDecl = 5
                               CXCursor_FieldDecl = 6
                               CXCursor_EnumConstantDecl = 7
                               CXCursor_FunctionDecl = 8
                               CXCursor_VarDecl = 9
                               CXCursor_ParmDecl = 10
                               CXCursor_ObjCInterfaceDecl = 11
                               CXCursor_ObjCCategoryDecl = 12
                               CXCursor_ObjCProtocolDecl = 13
                               CXCursor_ObjCPropertyDecl = 14
                               CXCursor_ObjCIvarDecl = 15
                               CXCursor_ObjCInstanceMethodDecl = 16
                               CXCursor_ObjCClassMethodDecl = 17
                               CXCursor_ObjCImplementationDecl = 18
                               CXCursor_ObjCCategoryImplDecl = 19
                               CXCursor_TypedefDecl = 20
                               CXCursor_CXXMethod = 21
                               CXCursor_Namespace = 22
                               CXCursor_LinkageSpec = 23
                               CXCursor_Constructor = 24
                               CXCursor_Destructor = 25
                               CXCursor_ConversionFunction = 26
                               CXCursor_TemplateTypeParameter = 27
                               CXCursor_NonTypeTemplateParameter = 28
                               CXCursor_TemplateTemplateParameter = 29
                               CXCursor_FunctionTemplate = 30
                               CXCursor_ClassTemplate = 31
                               CXCursor_ClassTemplatePartialSpecialization = 32
                               CXCursor_NamespaceAlias = 33
                               CXCursor_UsingDirective = 34
                               CXCursor_UsingDeclaration = 35
                               CXCursor_TypeAliasDecl = 36
                               CXCursor_ObjCSynthesizeDecl = 37
                               CXCursor_ObjCDynamicDecl = 38
                               CXCursor_CXXAccessSpecifier = 39
                               CXCursor_FirstDecl = 1
                               CXCursor_LastDecl = 39
                               CXCursor_ObjCSuperClassRef = 40
                               CXCursor_ObjCProtocolRef = 41
                               CXCursor_ObjCClassRef = 42
                               CXCursor_TypeRef = 43
                               CXCursor_CXXBaseSpecifier = 44
                               CXCursor_TemplateRef = 45
                               CXCursor_NamespaceRef = 46
                               CXCursor_MemberRef = 47
                               CXCursor_LabelRef = 48
                               CXCursor_OverloadedDeclRef = 49
                               CXCursor_VariableRef = 50
                               CXCursor_LastRef = 50
                               CXCursor_FirstInvalid = 70
                               CXCursor_InvalidFile = 70
                               CXCursor_NoDeclFound = 71
                               CXCursor_NotImplemented = 72
                               CXCursor_InvalidCode = 73
                               CXCursor_LastInvalid = 73
                               CXCursor_FirstExpr = 100
                               CXCursor_UnexposedExpr = 100
                               CXCursor_DeclRefExpr = 101
                               CXCursor_MemberRefExpr = 102
                               CXCursor_CallExpr = 103
                               CXCursor_ObjCMessageExpr = 104
                               CXCursor_BlockExpr = 105
                               CXCursor_IntegerLiteral = 106
                               CXCursor_FloatingLiteral = 107
                               CXCursor_ImaginaryLiteral = 108
                               CXCursor_StringLiteral = 109
                               CXCursor_CharacterLiteral = 110
                               CXCursor_ParenExpr = 111
                               CXCursor_UnaryOperator = 112
                               CXCursor_ArraySubscriptExpr = 113
                               CXCursor_BinaryOperator = 114
                               CXCursor_CompoundAssignOperator = 115
                               CXCursor_ConditionalOperator = 116
                               CXCursor_CStyleCastExpr = 117
                               CXCursor_CompoundLiteralExpr = 118
                               CXCursor_InitListExpr = 119
                               CXCursor_AddrLabelExpr = 120
                               CXCursor_StmtExpr = 121
                               CXCursor_GenericSelectionExpr = 122
                               CXCursor_GNUNullExpr = 123
                               CXCursor_CXXStaticCastExpr = 124
                               CXCursor_CXXDynamicCastExpr = 125
                               CXCursor_CXXReinterpretCastExpr = 126
                               CXCursor_CXXConstCastExpr = 127
                               CXCursor_CXXFunctionalCastExpr = 128
                               CXCursor_CXXTypeidExpr = 129
                               CXCursor_CXXBoolLiteralExpr = 130
                               CXCursor_CXXNullPtrLiteralExpr = 131
                               CXCursor_CXXThisExpr = 132
                               CXCursor_CXXThrowExpr = 133
                               CXCursor_CXXNewExpr = 134
                               CXCursor_CXXDeleteExpr = 135
                               CXCursor_UnaryExpr = 136
                               CXCursor_ObjCStringLiteral = 137
                               CXCursor_ObjCEncodeExpr = 138
                               CXCursor_ObjCSelectorExpr = 139
                               CXCursor_ObjCProtocolExpr = 140
                               CXCursor_ObjCBridgedCastExpr = 141
                               CXCursor_PackExpansionExpr = 142
                               CXCursor_SizeOfPackExpr = 143
                               CXCursor_LambdaExpr = 144
                               CXCursor_ObjCBoolLiteralExpr = 145
                               CXCursor_ObjCSelfExpr = 146
                               CXCursor_OMPArraySectionExpr = 147
                               CXCursor_LastExpr = 147
                               CXCursor_FirstStmt = 200
                               CXCursor_UnexposedStmt = 200
                               CXCursor_LabelStmt = 201
                               CXCursor_CompoundStmt = 202
                               CXCursor_CaseStmt = 203
                               CXCursor_DefaultStmt = 204
                               CXCursor_IfStmt = 205
                               CXCursor_SwitchStmt = 206
                               CXCursor_WhileStmt = 207
                               CXCursor_DoStmt = 208
                               CXCursor_ForStmt = 209
                               CXCursor_GotoStmt = 210
                               CXCursor_IndirectGotoStmt = 211
                               CXCursor_ContinueStmt = 212
                               CXCursor_BreakStmt = 213
                               CXCursor_ReturnStmt = 214
                               CXCursor_GCCAsmStmt = 215
                               CXCursor_AsmStmt = 215
                               CXCursor_ObjCAtTryStmt = 216
                               CXCursor_ObjCAtCatchStmt = 217
                               CXCursor_ObjCAtFinallyStmt = 218
                               CXCursor_ObjCAtThrowStmt = 219
                               CXCursor_ObjCAtSynchronizedStmt = 220
                               CXCursor_ObjCAutoreleasePoolStmt = 221
                               CXCursor_ObjCForCollectionStmt = 222
                               CXCursor_CXXCatchStmt = 223
                               CXCursor_CXXTryStmt = 224
                               CXCursor_CXXForRangeStmt = 225
                               CXCursor_SEHTryStmt = 226
                               CXCursor_SEHExceptStmt = 227
                               CXCursor_SEHFinallyStmt = 228
                               CXCursor_MSAsmStmt = 229
                               CXCursor_NullStmt = 230
                               CXCursor_DeclStmt = 231
                               CXCursor_OMPParallelDirective = 232
                               CXCursor_OMPSimdDirective = 233
                               CXCursor_OMPForDirective = 234
                               CXCursor_OMPSectionsDirective = 235
                               CXCursor_OMPSectionDirective = 236
                               CXCursor_OMPSingleDirective = 237
                               CXCursor_OMPParallelForDirective = 238
                               CXCursor_OMPParallelSectionsDirective = 239
                               CXCursor_OMPTaskDirective = 240
                               CXCursor_OMPMasterDirective = 241
                               CXCursor_OMPCriticalDirective = 242
                               CXCursor_OMPTaskyieldDirective = 243
                               CXCursor_OMPBarrierDirective = 244
                               CXCursor_OMPTaskwaitDirective = 245
                               CXCursor_OMPFlushDirective = 246
                               CXCursor_SEHLeaveStmt = 247
                               CXCursor_OMPOrderedDirective = 248
                               CXCursor_OMPAtomicDirective = 249
                               CXCursor_OMPForSimdDirective = 250
                               CXCursor_OMPParallelForSimdDirective = 251
                               CXCursor_OMPTargetDirective = 252
                               CXCursor_OMPTeamsDirective = 253
                               CXCursor_OMPTaskgroupDirective = 254
                               CXCursor_OMPCancellationPointDirective = 255
                               CXCursor_OMPCancelDirective = 256
                               CXCursor_OMPTargetDataDirective = 257
                               CXCursor_LastStmt = 257
                               CXCursor_TranslationUnit = 300
                               CXCursor_FirstAttr = 400
                               CXCursor_UnexposedAttr = 400
                               CXCursor_IBActionAttr = 401
                               CXCursor_IBOutletAttr = 402
                               CXCursor_IBOutletCollectionAttr = 403
                               CXCursor_CXXFinalAttr = 404
                               CXCursor_CXXOverrideAttr = 405
                               CXCursor_AnnotateAttr = 406
                               CXCursor_AsmLabelAttr = 407
                               CXCursor_PackedAttr = 408
                               CXCursor_PureAttr = 409
                               CXCursor_ConstAttr = 410
                               CXCursor_NoDuplicateAttr = 411
                               CXCursor_CUDAConstantAttr = 412
                               CXCursor_CUDADeviceAttr = 413
                               CXCursor_CUDAGlobalAttr = 414
                               CXCursor_CUDAHostAttr = 415
                               CXCursor_CUDASharedAttr = 416
                               CXCursor_VisibilityAttr = 417
                               CXCursor_LastAttr = 417
                               CXCursor_PreprocessingDirective = 500
                               CXCursor_MacroDefinition = 501
                               CXCursor_MacroExpansion = 502
                               CXCursor_MacroInstantiation = 502
                               CXCursor_InclusionDirective = 503
                               CXCursor_FirstPreprocessing = 500
                               CXCursor_LastPreprocessing = 503
                               CXCursor_ModuleImportDecl = 600
                               CXCursor_FirstExtraDecl = 600
                               CXCursor_LastExtraDecl = 600
                               CXCursor_OverloadCandidate = 700)))

;; Various structs
(define-cstruct _CXUnsavedFile ([Filename _string]
                                [Contents _string]
                                [Length _uint]))

(define-cstruct _CXCursor ([kind _CXCursorKind]
                           [xdata _int]
                           [data (_cpointer 'void)])) ; TODO "void * data[3]" so i guess array 3 of void* ?

;; Typedef for visitor procedures
(define _CXCursorVisitor (_cprocedure (list _CXCursor _CXCursor _CXClientData) _CXChildVisitResult))

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
   (arg_num : _int)                              ; number of command line arguments
   (_or-null (_array _string arg_num))    ; command line arguments
   _uint                             ; number of unsaved files
   (_or-null _CXUnsavedFile-pointer) ; array of unsaved files
   -> _CXTranslationUnit))           ; return

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX__CURSOR__MANIP.html
(clang-define clang_getTranslationUnitCursor (_fun _CXTranslationUnit -> _CXCursor))

;; Functions from http://clang.llvm.org/doxygen/group__CINDEX__CURSOR__XREF.html
(clang-define clang_getCursorSpelling (_fun _CXCursor -> _CXString))

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
