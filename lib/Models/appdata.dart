import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tema8/Consts/consts.dart';
import 'package:tema8/Models/languagedata.dart';
import 'package:tema8/Models/translationdata.dart';
import 'package:tema8/Models/translationmodel.dart';
import 'package:translator/translator.dart';
import 'package:tema8/Consts/availablelanguages.dart';

//ChangeNotifier for API, connected to ChangeNotifierProvider in main.dart
class AppData extends ChangeNotifier{

  //Initializes default languages in the dropdownbuttons + gets history and favorites from SharedPrefs
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

  List<TranslationModel> history = [];
  List<TranslationModel> favorites = [];

  bool shouldShowHistory = false;
  bool currentIsInHistory() => history.contains(currentTranslationModel);
  bool currentIsFavorite() => currentTranslationModel!.isFavorite;

  //Sets which languange via languages API in LanguageData to be default initialized
  void setLanguage(enumFromOrTo fromOrTo, LanguageData lang){
    fromOrTo == enumFromOrTo.TO ? toLang = lang: fromLang = lang;
    notifyListeners();
  }

  //Button between dropdown buttons
  void switchLanguages(){
    LanguageData thisFrom = fromLang;
    LanguageData thisTo = toLang;

    if(thisFrom != thisTo){
      fromLang = thisTo;
      toLang = thisFrom;
    }
    notifyListeners();
  }

  //Throttles the input with 0.5 secs
  void delayedTranslation(String input){
    Future.delayed(const Duration(milliseconds: 500), () {
      if(input == textFieldController.text){
        _checkTranslation(input);
      }
    });
  }

 //Entry in input set up against available languages
  LanguageData getLanguagesFromString(String input){
    var entry = listOfLanguages.entries.firstWhere((element) => element.value == input);
    return LanguageData(entry.key, entry.value);
  }

  //Entry in input calls on TM, using API translator to translate against chosen language
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

    //If check to check translation
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
    //Called upon in init of AppData
    void initializeTheLanguages() {
      fromLang = getLanguagesFromString("Norwegian");
      toLang = getLanguagesFromString("English");
    }

//HISTORY

    void showHistory(bool newValue) {
      shouldShowHistory = newValue;
      notifyListeners();
    }

    //If check on history
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


    void _checkIfItIsHistory() {
      if (history.isEmpty && favorites.isNotEmpty) {
        showHistory(false);
      } else if (favorites.isEmpty && history.isNotEmpty){
      showHistory(true);
      }
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

//FAVORITES

    //The switch button in SwitchListTile
    void _moveBetweenLists(TranslationModel translationModel,
        List<TranslationModel> fromList, List<TranslationModel> toList) {
      if (fromList.contains(translationModel)) {
        fromList.remove(translationModel);
      }
      toList.add(translationModel);
      _listChanges();
    }

    //The switch button in SwitchListTile
    void changeToFavorites(TranslationModel translationModel) {
      translationModel.setFavorite();
      translationModel.isFavorite ?
      _moveBetweenLists(translationModel, history, favorites) :
      _moveBetweenLists(translationModel, favorites, history);

      currentTranslationModel = translationModel;
      showHistory(!translationModel.isFavorite);
    }

    void _listChanges() {
      _checkIfItIsHistory();
      _saveToSharedPrefs();
      notifyListeners();
    }


//SHARED PREFS

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



