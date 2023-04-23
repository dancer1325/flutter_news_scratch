import 'package:flutter/material.dart';

import 'package:flutter_news_scratch/app/models/news_models.dart';
import 'package:flutter_news_scratch/app/theme/tema.dart';

// Widget to be reused in both pages
class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  ListaNoticias( this.noticias );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(    // Widget which allows making scroll
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {

        return _Noticia( noticia: this.noticias[index], index: index );
     }
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({ 
    required this.noticia,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Most of next Widgets pass through Article noticia
        _TarjetaTopBar( noticia, index ),

        _TarjetaTitulo( noticia ),

        _TarjetaImagen( noticia ),

        _TarjetaBody( noticia ),

        _TarjetaBotones(),

        SizedBox( height: 10 ),
        Divider(),
        

      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: Icon( Icons.star_border ),
          ),

          SizedBox( width: 10 ),

          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: Icon( Icons.more ),
          ),


        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaBody( this.noticia );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text( noticia.description ?? '')
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaImagen( this.noticia );

  @override
  Widget build(BuildContext context) {
    // Wrap under Container to adjust the margin
    return Container(
      margin: EdgeInsets.symmetric( vertical: 10 ),
      // Wrap under ClipRRect, in order to apply the blur just to the specific container and add the borderRadius
      child: ClipRRect(
        borderRadius: BorderRadius.only( topLeft: Radius.circular(50), bottomRight: Radius.circular(50) ),
        child: Container(
          child: ( noticia.urlToImage != null ) 
              ?
          buildFadeInImage()
              : Image( image: AssetImage('assets/img/no-image.png'), )
        ),
      ),
    );
  }

  FadeInImage buildFadeInImage() {
    print('noticia.urlToImage ${ noticia.toJson()['urlToImage']}');
    return FadeInImage(
                placeholder: const AssetImage( 'assets/img/giphy.gif' ),
                image: NetworkImage( noticia.urlToImage.toString() )
              );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;

  const _TarjetaTitulo( this.noticia );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 15 ),
      child: Text( noticia.title!, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700 ), ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar( this.noticia, this.index );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10),
      margin: EdgeInsets.only( bottom: 10 ),
      child: Row(
        children: <Widget>[
          Text('${ index + 1 }. ', style: TextStyle( color: miTema.accentColor ),),
          Text('${ noticia.source?.name }. '),
        ],
      ),

    );
  }
}