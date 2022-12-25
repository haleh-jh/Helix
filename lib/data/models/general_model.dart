class GeneralModel{
   int key;
   String value;

  GeneralModel({required this.key, required this.value});
  
  factory GeneralModel.fromJson(Map<String, dynamic> json){
    return GeneralModel(key: json['key'], value: json['value']??'');
  }
  
  }