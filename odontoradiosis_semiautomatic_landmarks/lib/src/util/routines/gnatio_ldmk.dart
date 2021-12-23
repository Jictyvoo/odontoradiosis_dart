import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const gnatio = IRoutineDescription(
  landmark: "Gnátio (Gn)",
  accessedCurves: ["mandíbula"],
  instructions: [
    ["load_curve", "mandíbula", null, "curvePoints"],
    ["access_point", 8, "curvePoints", "foundedGnatio"],
    [
      "point_to_var",
      "foundedGnatio",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
