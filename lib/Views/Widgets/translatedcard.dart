import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Models/appdata.dart';


class TranslatedCard extends StatelessWidget {
  const TranslatedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _translatedCard(context);
  }

  Widget _translatedCard(BuildContext context) {
    final provider = Provider.of<AppData>(context);

    return Card(
        color: Colors.blue[500],
        child: Container(
          height: (1 / 5 * MediaQuery
              .of(context)
              .size
              .height),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _languageTitle(provider),
                              _translationText(provider),
                              Divider(),
                              _sourceLanguageTitle(provider),
                              _sourceText(provider),
                            ],
                        )
                    ),
                  ],
              ),
          ),
        )
    );
  }

  Widget _languageTitle(AppData provider){
    return Row(
      children: [
        Text(
          provider.currentTranslationModel!.translation.targetLanguage.name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          )
        ),
        IconButton(onPressed: () {
          provider.changeFavorites(provider.currentTranslationModel!);
          if(provider.textFieldController.text != ""){
            provider.textFieldController.clear();
          }
        }, icon: provider.currentIsFavorite() ? Icon(Icons.star) : Icon(Icons.star_border),
        )
      ],
    );
  }

  Widget _translationText(AppData provider) {
    return Text(
        provider.currentTranslationModel!.translation.text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        )
    );
  }

  Widget _sourceText(AppData provider){
    return Text(
      provider.currentTranslationModel!.translation.source,
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
      )
    );
  }

  Widget _sourceLanguageTitle(AppData provider){
    return Text(
      provider.currentTranslationModel!.translation.sourceLanguage.name,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }
}
