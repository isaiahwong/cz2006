class Ticker {
  const Ticker();
  Stream<int> tick({required Duration ticks}) {
    return Stream.periodic(Duration(milliseconds: 100), (x) => x)
        .take(ticks.inMilliseconds);
  }
}
