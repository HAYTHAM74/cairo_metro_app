import 'package:cairo_metro_app/models/station.dart';

class TraversalState implements Comparable<TraversalState>
{
  TraversalState({required this.station, required this.cost, required this.currentLine, required this.path});
  final Station station;
  final int? currentLine;
  final int cost;
  final List<Station> path;
  @override
  int compareTo(TraversalState other) {
    return cost.compareTo(other.cost);
  }
}