import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const pterigoide = IRoutineDescription(
  landmark: "Pterigóide (Pt)",
  accessedCurves: ["fissura-pterigomaxilar"],
  instructions: [
    ["load_curve", "fissura-pterigomaxilar", null, "curvePoints"],
    ["access_point", 3, "curvePoints", "p1"],
    ["access_point", 4, "curvePoints", "p2"],
    [
      "point_to_var",
      "p1",
      null,
      {"x": "x1", "y": "y1"}
    ],
    [
      "point_to_var",
      "p2",
      null,
      {"x": "x2", "y": "y2"}
    ],
    ["mul", "x1", "0.1", "tempX1"],
    ["mul", "x2", "0.9", "tempX2"],
    ["mul", "y1", "0.8", "tempY1"],
    ["mul", "y2", "0.2", "tempY2"],
    ["add", "tempX1", "tempX2", "x"],
    ["add", "tempY1", "tempY2", "y"],
    ["return", "x", "y", null]
  ],
);
