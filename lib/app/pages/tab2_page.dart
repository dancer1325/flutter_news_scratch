import 'package:flutter/material.dart';
import 'package:flutter_news_scratch/app/models/category_model.dart';
import 'package:flutter_news_scratch/app/services/news_service.dart';
import 'package:flutter_news_scratch/app/theme/tema.dart';
import 'package:flutter_news_scratch/app/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Get access to the NewsService Provider via context
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            
            _ListaCategorias(),

            if ( !newsService.isLoading )
              Expanded(
                child: ListaNoticias( newsService.getArticulosCategoriaSeleccionada! )
              ),

            if ( newsService.isLoading )
            const Expanded(
              child: Center(
                // CircularProgressIndicator     Widget which shows a circular loading
                child: CircularProgressIndicator(),
              )
            )



          ],
        )
   ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Get access to the NewsService Provider via context
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        // Allows scrolling beyond the limits, although there are no widgets. Default behaviour in IoS
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        // itemBuilder      Define how to create each Widget of the list
        itemBuilder: (BuildContext context, int index) {

          final cName = categories[index].name;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _CategoryButton( categories[index] ),
              const SizedBox( height: 5),
              Text( '${ cName[0].toUpperCase() }${ cName.substring(1) }' )
            ],
          ),
        );
       },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton( this.categoria );

  @override
  Widget build(BuildContext context) {

    // Get access to the NewsService Provider via context
    final newsService = Provider.of<NewsService>(context);

    // It allows doing navigation based on Tap event
    return GestureDetector(
      onTap: (){
        // print('${ categoria.name }');
        // listen: false    If it's true, it would throw an error since it's into the method
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric( horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name  )
                ? miTema.accentColor
                : Colors.black54,
        ),
      ),
    );
  }
}