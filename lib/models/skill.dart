class Skill {
  final int? id;
  final String name;
  final String? description;
  final String level;
  Skill({
    this.id,
    required this.name,
    this.description,
    required this.level,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'level': level,
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      level: map['level'],
    );
  }
}
