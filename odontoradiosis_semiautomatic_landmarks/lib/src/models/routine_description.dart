// TODO: Create a class for this, and a parse in compile-time (save it as a AST)
typedef IOperation = dynamic;

class IRoutineDescription {
  final String landmark;
  final List<String> accessedCurves;
  final List<IOperation> instructions;

  const IRoutineDescription({
    required this.landmark,
    required this.accessedCurves,
    required this.instructions,
  });
}
