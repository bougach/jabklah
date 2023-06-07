class Creanciers {
  final String image;
  final String name;
  final int ?id ;
  final String?  type ;


  final String? arg1;
  final String? arg2;
  final String? arg3;

  Creanciers({
    required this.name,
     required this.image,

     this.id,
     this.type,


    this.arg1,
    this.arg2,
    this.arg3,
  });
  factory Creanciers.fromMap(Map<String, dynamic> json) {
    final name =json['name'] as String;
    final image =json['image'] as String;
    final id =json['id'] as int ;
    return Creanciers(
      name: name,
      image: image,
        id: id

    );
  }
}
