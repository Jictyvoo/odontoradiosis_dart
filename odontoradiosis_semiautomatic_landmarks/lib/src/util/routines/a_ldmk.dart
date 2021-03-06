import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const a = IRoutineDescription(
  landmark: "Ponto subespinhal (A)",
  accessedCurves: ["maxila"],
  instructions: [
    ["load_curve", "maxila", null, "curvePoints"],
    ["access_point", 8, "curvePoints", "foundedA"],
    [
      "point_to_var",
      "foundedA",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
