extension NumExtension on num? {
  String convertToPercentString() {
    return ((this ?? 0) * 10).toStringAsFixed(0) + '%';
  }
}