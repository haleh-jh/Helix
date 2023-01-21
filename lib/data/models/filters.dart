class FiltersModel{
   int id;
   String name;

  FiltersModel({required this.id, required this.name});
  
  factory FiltersModel.fromJson(Map<String, dynamic> json){
    return FiltersModel(id: json['id'] , name: json['name']??"");
  }
  
  }
