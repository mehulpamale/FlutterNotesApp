class Dog {
  int? id;
  String? name;
  int? age;

  Dog({this.id, required this.name, required this.age});

  // Dog.from({required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Dog(id: $id, name: $name, age: $age)';
  }
}
