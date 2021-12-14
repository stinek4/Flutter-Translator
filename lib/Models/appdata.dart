import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tema8/Consts/consts.dart';
import 'package:tema8/Models/languagedata.dart';
import 'package:tema8/Models/translationdata.dart';
import 'package:tema8/Models/translationmodel.dart';
import 'package:translator/translator.dart';
import 'package:tema8/Consts/availablelanguages.dart';

//ChangeNotifier for API
class AppData extends ChangeNotifier{

  AppData(){
    initializeTheLanguages();
    _getFromSharedPrefs("History", historyKey);
    _getFromSharedPrefs("Favorites", favoritesKey);
  }

  late LanguageData fromLang;
  late LanguageData toLang;

  final textFieldController = TextEditingController();
  final translator = GoogleTranslator();
  TranslationModel? currentTranslationModel;

  void setLanguage(enumFromOrTo fromOrTo, LanguageData lang){
    fromOrTo == enumFromOrTo.TO ? toLang = lang: fromLang = lang;
    notifyListeners();
  }

  void switchLanguages(){
    LanguageData thisFrom = fromLang;
    LanguageData thisTo = toLang;

    if(thisFrom != thisTo){
      fromLang = thisTo;
      toLang = thisFrom;
    }
    notifyListeners();
  }

  void delayedTranslation(String input){
    Future.delayed(const Duration(milliseconds: 500), () {
      if(input == textFieldController.text){
        _checkTranslation(input);
      }
    });
  }

  LanguageData getLanguagesFromString(String input){
    var entry = listOfLanguages.entries.firstWhere((element) => element.value == input);
    return LanguageData(entry.key, entry.value);
/*    return languages.values.firstWhere((element) => element.toString() == languages+lang);*/
  }


  void _translate(String input) {
    if (textFieldController.text != "") {
      translator.translate(input, from: fromLang.code, to: toLang.code).then((
          value) {
        TranslationModel model = TranslationModel(
            TranslationData.fromTranslation(value));
        currentTranslationModel = model;
        notifyListeners();
      });
    } else {
      currentTranslationModel = null;
      notifyListeners;
    }
  }

    void setCurrentTranslationModel(TranslationModel newCurrent) {
      currentTranslationModel = newCurrent;
      notifyListeners();
    }

    void _checkTranslation(String input) {
      currentTranslationModel != null ? {
        if(currentTranslationModel!.translation.source != input){
          _translate(input),
        }
      }
          : {
        _translate(input)
      };
    }

    void initializeTheLanguages() {
      fromLang = getLanguagesFromString("Automatic");
      toLang = getLanguagesFromString("English");
    }

    //History
    bool shouldShowHistory = false;
    List<TranslationModel> history = [];

    void showHistory(bool newValue) {
      shouldShowHistory = newValue;
      notifyListeners();
    }

    void historyAddCheck() {
      if (currentTranslationModel != null && !currentIsInHistory()) {
        _addToHistory(currentTranslationModel!);
      }
    }

    void _addToHistory(TranslationModel translation) {
      history.add(translation);
      showHistory(true);
      _listChanges();
    }

    bool currentIsInHistory() =>
        history.contains(currentTranslationModel);

    void _checkIfItIsHistory() {
      if (history.isEmpty && favorites.isNotEmpty) {
        showHistory(false);
      } else if (favorites.isEmpty && history.isNotEmpty){
      showHistory(true);
      }
    }

    void _listChanges() {
      _checkIfItIsHistory();
      _saveToSharedPrefs();
      notifyListeners();
    }

    void _moveBetweenLists(TranslationModel translationModel,
        List<TranslationModel> fromList, List<TranslationModel> toList) {
      if (fromList.contains(translationModel)) {
        fromList.remove(translationModel);
      }
      toList.add(translationModel);
      _listChanges();
    }

    void deleteFromList(TranslationModel translationModel, List<TranslationModel> listToDeleteFrom){
      if (listToDeleteFrom.contains(translationModel)) {
        listToDeleteFrom.remove(translationModel);
      }
      if (translationModel == currentTranslationModel) {
        currentTranslationModel = null;
      }
      _listChanges();
    }

    //Favorites

    List<TranslationModel> favorites = [];

    void changeFavorites(TranslationModel translationModel) {
      translationModel.setFavorite();
      translationModel.isFavorite ?
      _moveBetweenLists(translationModel, history, favorites) :
      _moveBetweenLists(translationModel, favorites, history);

      currentTranslationModel = translationModel;
      showHistory(!translationModel.isFavorite);
    }

    bool currentIsFavorite() => currentTranslationModel!.isFavorite;

    //Shared Prefs

    void _getFromSharedPrefs(String theListToGet, String key) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(key);
      if (json != null) {
        final decoded = jsonDecode(json);
        final iterable = decoded as Iterable<dynamic>;
        var list = List<TranslationModel>.of(
            iterable.map((e) => TranslationModel.fromJson(e)));
        if (theListToGet == "History") {
          history = list;
        } else if (theListToGet == "Favorites") {
          favorites = list;
        }
        notifyListeners();
      } else {
        return;
      }
    }

    void _saveToSharedPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var historyList = history.map((e) => e.toJson()).toList();
      var encodedHistory = json.encode(historyList);
      var favoritesList = favorites.map((e) => e.toJson()).toList();
      var encodedFavorites = json.encode(favoritesList);

      prefs.setString(historyKey, encodedHistory);
      prefs.setString(favoritesKey, encodedFavorites);
    }
}



