class Station {
  Station({required this.id, required this.name, required this.lines});
  final String id;
  final String name;
  final List<int> lines;

  bool get isTransfer => lines.length > 1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Station && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
