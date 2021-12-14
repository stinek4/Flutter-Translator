import 'package:flutter/material.dart';
import 'package:tema8/Models/languagedata.dart';
import 'package:translator/translator.dart';

class TranslationData{
  late final String text;
  late final String source;
  late final LanguageData sourceLanguage;
  late final LanguageData targetLanguage;

  TranslationData(this.text, this.source, this.sourceLanguage, this.targetLanguage);

  TranslationData.fromTranslation(Translation translation){
    this.text = translation.text;
    this.source = translation.source;
    this.sourceLanguage = LanguageData.fromLanguage(translation.sourceLanguage);
    this.targetLanguage = LanguageData.fromLanguage(translation.targetLanguage);
  }

  TranslationData.fromJson(Map<String,dynamic> json)
  : text = json["txt"],
  source = json["source"],
  sourceLanguage = LanguageData.fromJson(json["srcLanguage"]),
  targetLanguage = LanguageData.fromJson(json["targetLanguage"]);

  Map<String, dynamic> toJson() => {
    "text" : text,
    "source" : source,
    "srcLanguage" : sourceLanguage.toJson(),
    "targetLanguage" : targetLanguage.toJson(),
  };
}