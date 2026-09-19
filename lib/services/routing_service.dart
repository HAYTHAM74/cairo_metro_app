import 'package:collection/collection.dart';
import 'package:cairo_metro_app/models/station.dart';
import 'package:cairo_metro_app/data/metro_network.dart';
import 'package:cairo_metro_app/models/traversal_state.dart';

class RoutingService {
  final MetroNetwork network;

  RoutingService(this.network);

  List<Station> findShortestPath(
    Station start,
    Station destination, {
    bool prioritizeLeastTransitions = false,
  }) {
    int stationCost = prioritizeLeastTransitions ? 1 : 10;
    int transferPenalty = prioritizeLeastTransitions ? 100 : 1;

    TraversalState startState = TraversalState(
      station: start,
      cost: 0,
      currentLine: null,
      path: [start],
    );

    PriorityQueue<TraversalState> queue = PriorityQueue<TraversalState>();
    queue.add(startState);
    
    // FIX 1: Map tracks the Station ID + the Line you arrived on
    Map<String, int> costs = {};
    costs['${start.id}_null'] = 0;

    while (queue.isNotEmpty) {
      TraversalState current = queue.removeFirst();
      
      if (current.station.id == destination.id) {
        return current.path;
      }
      
      for (Station neighbor in network.graph[current.station]!) {
        Set<int> sharedLines = current.station.lines.toSet().intersection(
          neighbor.lines.toSet(),
        );
        if (sharedLines.isEmpty) continue;
        
        int newLine;
        if (current.currentLine != null &&
            sharedLines.contains(current.currentLine)) {
          newLine = current.currentLine!;
        } else {
          newLine = sharedLines.first;
        }
        
        bool isTransfer =
            current.currentLine != null && current.currentLine != newLine;
        int newCost =
            current.cost + stationCost + (isTransfer ? transferPenalty : 0);
            
        // FIX 2: Create the composite key for evaluation
        String stateKey = '${neighbor.id}_$newLine';
        
        // FIX 3: Check against the specific station+line combination
        if (!costs.containsKey(stateKey) || newCost < costs[stateKey]!) {
          costs[stateKey] = newCost;
          List<Station> newPath = List.from(current.path)..add(neighbor);
          queue.add(
            TraversalState(
              station: neighbor,
              cost: newCost,
              currentLine: newLine,
              path: newPath,
            ),
          );
        }
      }
    }
    return [];
  }

  Map<String, List<Station>> generateTripOptions({
    required Station start,
    required Station destination,
  }) {
    final shortestRoute = findShortestPath(start, destination);
    final leastTransfersRoute = findShortestPath(
      start,
      destination,
      prioritizeLeastTransitions: true,
    );
    final routesAreEqual = ListEquality().equals(
      shortestRoute,
      leastTransfersRoute,
    );
    Map<String, List<Station>> routes = {};
    routesAreEqual
        ? routes.addAll({'primary': shortestRoute})
        : routes.addAll({
            'shortest': shortestRoute,
            'leastTransfers': leastTransfersRoute,
          });
    return routes;
  }
}
