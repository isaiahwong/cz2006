String prettyDP(double num) =>
    num % 1 == 0 ? num.toInt().toString() : num.toString();

String zeroPrefix(int num) =>
    num.toString().length < 2 ? "0${num.toString()}" : num.toString();

double? tryDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  }
  return null;
}

int? tryInt(dynamic value) {
  if (value is String) {
    return int.parse(value);
  } else if (value is double) {
    return value.toInt();
  } else if (value is int) {
    return value;
  }
  return null;
}
