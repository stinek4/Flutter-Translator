import 'package:tema8/Models/translationdata.dart';

//Setting up TM to connect with json through TranslationData
class TranslationModel{
  final TranslationData translation;
  bool isFavorite;

  TranslationModel(this.translation, [this.isFavorite = false]);

  void setFavorite(){
    isFavorite = !isFavorite;
  }

  TranslationModel.fromJson(Map<String, dynamic> json)
  : translation = TranslationData.fromJson(json["translation"]),
  isFavorite = json["isFavorite"];

  Map<String, dynamic> toJson() => {
    "translation": {
      "text": translation.text,
      "source": translation.source,
      "targetLanguage": translation.targetLanguage,
      "sourceLanguage": translation.sourceLanguage
    },
  };
}