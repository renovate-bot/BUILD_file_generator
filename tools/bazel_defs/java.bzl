# Enable some Error Prone checks that are not on by default.  Then, enable warnings:
# Bazel as of 0.5.1 doesn't enable the default warnings for Error Prone (see
# https://github.com/bazelbuild/bazel/issues/2237), so we enable them individually here.
JAVACOPTS = [
    "-XepDisableWarningsInGeneratedCode",
    "-Xep:MissingCasesInEnumSwitch:ERROR",
    "-Xep:ReferenceEquality:ERROR",
    "-Xep:StringEquality:ERROR",
    "-Xep:WildcardImport:ERROR",
    "-Xep:AmbiguousMethodReference:WARN",
    "-Xep:BadAnnotationImplementation:WARN",
    "-Xep:BadComparable:WARN",
    "-Xep:BoxedPrimitiveConstructor:ERROR",
    "-Xep:CannotMockFinalClass:WARN",
    "-Xep:ClassCanBeStatic:WARN",
    "-Xep:ClassNewInstance:WARN",
    "-Xep:DefaultCharset:WARN",
    "-Xep:DoubleCheckedLocking:WARN",
    "-Xep:ElementsCountedInLoop:WARN",
    "-Xep:EqualsHashCode:WARN",
    "-Xep:EqualsIncompatibleType:WARN",
    "-Xep:Finally:WARN",
    "-Xep:FloatingPointLiteralPrecision:WARN",
    "-Xep:FragmentInjection:WARN",
    "-Xep:FragmentNotInstantiable:WARN",
    "-Xep:FunctionalInterfaceClash:WARN",
    "-Xep:FutureReturnValueIgnored:WARN",
    "-Xep:GetClassOnEnum:WARN",
    "-Xep:ImmutableAnnotationChecker:WARN",
    "-Xep:ImmutableEnumChecker:WARN",
    "-Xep:IncompatibleModifiers:WARN",
    "-Xep:InjectOnConstructorOfAbstractClass:WARN",
    "-Xep:InputStreamSlowMultibyteRead:WARN",
    "-Xep:IterableAndIterator:WARN",
    "-Xep:JUnit3FloatingPointComparisonWithoutDelta:WARN",
    "-Xep:JUnitAmbiguousTestClass:WARN",
    "-Xep:LiteralClassName:WARN",
    "-Xep:MissingFail:WARN",
    "-Xep:MissingOverride:WARN",
    "-Xep:MutableConstantField:WARN",
    "-Xep:NarrowingCompoundAssignment:WARN",
    "-Xep:NonAtomicVolatileUpdate:WARN",
    "-Xep:NonOverridingEquals:WARN",
    "-Xep:NullableConstructor:WARN",
    "-Xep:NullablePrimitive:WARN",
    "-Xep:NullableVoid:WARN",
    "-Xep:OperatorPrecedence:WARN",
    "-Xep:OverridesGuiceInjectableMethod:WARN",
    "-Xep:PreconditionsInvalidPlaceholder:WARN",
    "-Xep:ProtoFieldPreconditionsCheckNotNull:WARN",
    "-Xep:ProtocolBufferOrdinal:WARN",
    "-Xep:RequiredModifiers:WARN",
    "-Xep:ShortCircuitBoolean:WARN",
    "-Xep:SimpleDateFormatConstant:WARN",
    "-Xep:StaticGuardedByInstance:WARN",
    "-Xep:SynchronizeOnNonFinalField:WARN",
    "-Xep:TruthConstantAsserts:WARN",
    "-Xep:TypeParameterShadowing:WARN",
    "-Xep:TypeParameterUnusedInFormals:WARN",
    "-Xep:URLEqualsHashCode:WARN",
    "-Xep:UnsynchronizedOverridesSynchronized:WARN",
    "-Xep:WaitNotInLoop:WARN",
]

def java_library(javacopts=[], **kwargs):
    updated_opts = []
    updated_opts += javacopts
    if native.repository_name() == '@':
        # When building any java target in our repository (i.e. not ones that are loaded into the WORKSPACE with
        # http_archive and friends), apply our javac options.  We don't apply them to external code because that code
        # may not adhere to our rules.
        updated_opts += JAVACOPTS
    native.java_library(javacopts=updated_opts, **kwargs)
