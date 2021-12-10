import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

const b = IRoutineDescription(
  landmark: "Ponto pupramental (B)",
  accessed_curves: ["mandíbula", "perfil-mole"],
  instructions: [
    ["load_curve", "mandíbula", null, "curvePoints_1"],
    ["load_curve", "perfil-mole", null, "curvePoints_2"],
    ["access_point", 18, "curvePoints_2", "perfilMolePoint"],
    ["access_point", 16, "curvePoints_1", "mandibulaPoint"],
    [
      "point_to_var",
      "perfilMolePoint",
      null,
      {"x": "x1", "y": "y1"}
    ],
    [
      "point_to_var",
      "mandibulaPoint",
      null,
      {"x": "x2", "y": "y2"}
    ],
    ["add", "x1", "x2", "tempX"],
    ["add", "y1", "y2", "tempY"],
    ["div", "tempX", "2", "x"],
    ["div", "tempY", "2", "y"],
    ["return", "x", "y", null]
  ],
);
