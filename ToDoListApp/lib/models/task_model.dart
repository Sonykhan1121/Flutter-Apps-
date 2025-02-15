class Task{
  final int? id;
  final String  title;
  final String description;
  final String dueDate;
  final int priority;
  final String category;

  Task({ this.id, required this.title, required this.description, required this.dueDate, required this.priority,
      required this.category});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        dueDate: map['dueDate'],
        priority: map['priority'],
        category: map['category']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'category': category
    };
  }
  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? dueDate,
    int? priority,
    String? category,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
    );
  }
}