const mento = {
  "landmark": "Mento (Me)",
  "accessed_curves": ["mandíbula"],
  "instructions": [
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
  ]
};
