import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

typedef IPreFunction = Map<String, dynamic>;

typedef ISymbolTable = Map<String, dynamic>;

typedef ICallbackOperations = IPointBidimensional Function(
  double firstParam,
  String secondParam,
  String resultName,
);
