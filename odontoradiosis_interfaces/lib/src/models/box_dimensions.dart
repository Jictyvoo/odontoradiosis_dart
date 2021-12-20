class BoxDimensions {
  final double x;
  final double y;
  final double width;
  final double heigth;

  static const empty = BoxDimensions(0, 0, 0, 0);

  const BoxDimensions(this.x, this.y, this.width, this.heigth);

  BoxDimensions.fromList(List<double> values)
      : assert(values.length == 4),
        x = values[0],
        y = values[1],
        width = values[2],
        heigth = values[3];
}
