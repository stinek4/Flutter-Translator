import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tema8/Models/appdata.dart';
import 'package:tema8/Models/translationmodel.dart';

//Widget used in mainpage.dart to show result of translation, showcased via SwitchListTile either as history or favorite

class TranslatedResult extends StatelessWidget {
  const TranslatedResult(this.showHistory, {Key? key}) : super(key: key);

  final bool showHistory;

  @override
  Widget build(BuildContext context){
    var provider = Provider.of<AppData>(context);
    return Flexible(
      child: ListView(
        children: showHistory ? provider.history.reversed.map((e) => _historyBuild(e, context)).toList() :
            provider.favorites.reversed.map((e) => _historyBuild(e, context)).toList(),
      )
    );
  }

  Widget _historyBuild(TranslationModel model, BuildContext context){
    var provider = Provider.of<AppData>(context, listen: false);
    return Dismissible(
        key: Key(model.translation.text),
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
          showHistory ?
              provider.deleteFromList(model, provider.history) :
              provider.deleteFromList(model, provider.favorites);
        },
        background: Container(
          color: Colors.redAccent,
          padding: EdgeInsets.only(right: 16.0),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.close),
        ),
        child: ListTile(
          title: Text(model.translation.text,
          maxLines: 3,
          ),
          subtitle: Text(model.translation.source,
          maxLines: 3,
          ),
          trailing: IconButton(
            onPressed: (){
              provider.changeToFavorites(model);
            },
            icon: model.isFavorite ?
                Icon(Icons.star) :
                Icon(Icons.star_border),
          ),
          onTap: (){
            provider.setCurrentTranslationModel(model);
          },

        ));
  }
}