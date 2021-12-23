import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const enp = IRoutineDescription(
  landmark: "Espinha nasal posterior (ENP)",
  accessedCurves: ["maxila"],
  instructions: [
    ["load_curve", "maxila", null, "curvePoints"],
    ["access_point", 4, "curvePoints", "foundedENP"],
    [
      "point_to_var",
      "foundedENP",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
