/// Helper functions to convert date time, age

/// Get date based on timestamp (int)
int getAge(int timestamp) {
  var result =
      DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestamp));
  print("Age: ${(result.inDays / 365).floor()}");
  return (result.inDays / 365).floor();
}
