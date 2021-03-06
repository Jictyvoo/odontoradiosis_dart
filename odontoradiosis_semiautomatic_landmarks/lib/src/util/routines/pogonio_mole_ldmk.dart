import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const pogonioMole = IRoutineDescription(
  landmark: "Pogônio Mole (Pg)",
  accessedCurves: ["perfil-mole"],
  instructions: [
    ["load_curve", "perfil-mole", null, "curvePoints"],
    ["access_point", 19, "curvePoints", "foundedPg"],
    [
      "point_to_var",
      "foundedPg",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
