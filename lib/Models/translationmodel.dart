import 'package:flutter/material.dart';
import 'package:tema8/Models/translationdata.dart';
import 'package:translator/translator.dart';

class TranslationModel{
  final TranslationData translation;
  bool isFavorite;

  TranslationModel(this.translation, [this.isFavorite = false]);

  void setFavorite(){
    isFavorite = !isFavorite;
  }

/*  static TranslationModel fromJson2(dynamic json){
    return TranslationModel(json["translation"]);
  }*/

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