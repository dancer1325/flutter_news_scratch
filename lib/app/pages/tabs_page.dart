import 'package:flutter/material.dart';
import 'package:flutter_news_scratch/app/pages/tab1_page.dart';
import 'package:flutter_news_scratch/app/pages/tab2_page.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
   ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);


    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        // BottomNavigationBarItem( icon: Icon( Icons.person_outline ), title: Text('Para ti') ),
        // BottomNavigationBarItem( icon: Icon( Icons.public ), title: Text('Encabezados') ),
        // BottomNavigationBarItem( icon: Icon( Icons.person_outline ), tooltip: 'Para ti' ),
        // BottomNavigationBarItem( icon: Icon( Icons.public ), tooltip: 'Encabezados' ),
        BottomNavigationBarItem( icon: Icon( Icons.person_outline ), label: 'Para ti' ),
        BottomNavigationBarItem( icon: Icon( Icons.public ), label: 'Encabezados' ),
      ]
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[

        Tab1Page(),

        Tab2Page()

      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();


  int get paginaActual => this._paginaActual;
  
  set paginaActual( int valor ) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut );

    notifyListeners();
  }

  PageController get pageController => this._pageController;

}