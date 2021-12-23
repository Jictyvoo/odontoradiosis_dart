import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const mento = IRoutineDescription(
  landmark: "Mento (Me)",
  accessedCurves: ["mandíbula"],
  instructions: [
    ["load_curve", "mandíbula", null, "curvePoints"],
    ["access_point", 13, "curvePoints", "firstPoint"],
    ["access_point", 14, "curvePoints", "secondPoint"],
    [
      "average",
      ["firstPoint", "secondPoint"],
      null,
      "thirdPoint"
    ],
    [
      "average",
      ["firstPoint", "thirdPoint"],
      null,
      "result"
    ],
    [
      "point_to_var",
      "result",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
