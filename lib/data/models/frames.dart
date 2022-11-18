class FramesModel{
   int id;
   String name;
   String type;
   String filter;

  FramesModel({required this.id, required this.name, required this.type, required this.filter});
  
  factory FramesModel.fromJson(Map<String, dynamic> json){
    return FramesModel(id: json['id'] , name: json['name']??"", type: json['type']??"", filter: json['filter']??"");
  }
  
  }
