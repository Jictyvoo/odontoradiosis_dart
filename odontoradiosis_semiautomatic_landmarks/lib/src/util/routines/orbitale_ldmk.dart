const orbitale = {
  "landmark": "Órbitário (Or)",
  "accessed_curves": ["borda-póstero-inferior"],
  "instructions": [
    ["load_curve", "borda-póstero-inferior", null, "curvePoints"],
    ["access_point", 1, "curvePoints", "p1"],
    ["access_point", 3, "curvePoints", "p2"],
    ["access_point", 4, "curvePoints", "p3"],
    [
      "average",
      ["p1", "p2"],
      null,
      "firstAveragePoint"
    ],
    [
      "point_to_var",
      "p3",
      null,
      {"x": "x1", "y": "y1"}
    ],
    [
      "point_to_var",
      "p2",
      null,
      {"x": "x2", "y": "y2"}
    ],
    ["mul", "y1", "0.9", "tempY1"],
    ["mul", "y2", "0.1", "tempY2"],
    ["add", "tempY1", "tempY2", "y"],
    [
      "point_to_var",
      "firstAveragePoint",
      null,
      {"x": "x", "y": "noY"}
    ],
    ["return", "x", "y", null]
  ]
};
