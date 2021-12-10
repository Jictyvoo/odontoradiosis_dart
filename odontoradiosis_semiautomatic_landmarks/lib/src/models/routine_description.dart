// TODO: Create a class for this, and a parse in compile-time (save it as a AST)
typedef IOperation = dynamic;

class IRoutineDescription {
  final String landmark;
  final List<String> accessed_curves;
  final List<IOperation> instructions;

  IRoutineDescription(this.landmark, this.accessed_curves, this.instructions);
}
