import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const nasio = IRoutineDescription(
  landmark: "Násio (N)",
  accessedCurves: ["sutura-fronto-nasal"],
  instructions: [
    ["load_curve", "sutura-fronto-nasal", null, "curvePoints"],
    ["access_point", 1, "curvePoints", "foundedNasio"],
    [
      "point_to_var",
      "foundedNasio",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
