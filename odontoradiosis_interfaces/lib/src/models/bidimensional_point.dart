class IPointBidimensional {
  final double x;
  final double y;

  IPointBidimensional(this.x, this.y);

  factory IPointBidimensional.create({double x = 0, double y = 0}) {
    return IPointBidimensional(x, y);
  }
}
