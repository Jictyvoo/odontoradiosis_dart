import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const proNasal = IRoutineDescription(
  landmark: "Pró-nasal (Pn)",
  accessed_curves: ["perfil-mole"],
  instructions: [
    ["load_curve", "perfil-mole", null, "curvePoints"],
    ["access_point", 4, "curvePoints", "foundedPn"],
    [
      "point_to_var",
      "foundedPn",
      null,
      {"x": "x", "y": "y"}
    ],
    ["return", "x", "y", null]
  ],
);
