class Dept {
  int? id;
  String name;
  String? description;
  String type;
  bool? paid;
  double? amount;
  dynamic createdAt;
  dynamic client;
  dynamic creditor;
  dynamic article;
  bool? added2Bill;

  Dept({
     this.id,
     required this.name,
    this.description,
     required this.type,
    this.paid,
    this.amount,
    this.createdAt,
    this.client,
    this.creditor,
    this.article,
    this.added2Bill,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'type': type,
      'amount': amount,
    };
  }


  factory Dept.fromJson(Map<String, dynamic> json) {
    return Dept(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      paid: json['paid'] as bool?,
      amount: json['amount'] as double?,
      createdAt: json['createdAt'],
      client: json['client'],
      creditor: json['creditor'],
      article: json['article'],
      added2Bill: json['added2Bill'] as bool?,
    );
  }
}
