class Dog {
  final int id;
  String name;
  int age;

  Dog({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Dog(id: $id, name: $name, age: $age)';
  }
}
