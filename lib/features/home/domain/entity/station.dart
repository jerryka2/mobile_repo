class Station {
  final String id;
  final String name;
  final String description;

  Station({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  String toString() => 'Station(id: $id, name: $name, description: $description)';
}