import 'package:translator/src/langs/language.dart';


//Connection between the code (json) to Languages API
class LanguageData{
  late final String code;
  late final String name;

  LanguageData(this.code, this.name);

  LanguageData.fromLanguage(Language language){
    this.code = language.code;
    this.name = language.name;
  }

  LanguageData.fromJson(Map<String, dynamic> json)
  : code = json["code"],
  name = json["name"];

  Map<String,dynamic> toJson() => {
    "code" : code,
    "name" : name,
  };
}