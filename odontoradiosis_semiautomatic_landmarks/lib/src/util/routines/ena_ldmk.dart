import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const ena = IRoutineDescription(
  landmark: "Espinha nasal anterior (ENA)",
  accessedCurves: ["maxila"],
  instructions: [
    ["load_curve", "maxila", null, "curvePoints"],
    ["access_point", 7, "curvePoints", "foundedENA"],
    [
      "point_to_var",
      "foundedENA",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
