class Car {
  int id;
  double x, y, direction;

  Car({this.id, this.x, this.y, this.direction});

  @override
  String toString() {
    return 'Car{id: $id, x: $x, y: $y, direction: $direction}';
  }
}