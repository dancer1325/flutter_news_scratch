import 'package:flutter/material.dart';
import 'package:flutter_news_scratch/app/pages/tab1_page.dart';
import 'package:flutter_news_scratch/app/pages/tab2_page.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // The ChangeNotifier is accessible just to the child
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

    // Get access to the NavegacionModel Provider via context
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,           // Indicate which item is selected
      onTap: (i) => navegacionModel.paginaActual = i,       // Invoke to the setter in which we added the `notifyListeners()`
      items: [      // Good practise to specify the type. >=2 items
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

    // Get access to the NavegacionModel Provider via context
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,     // Controls which page is visible in the view === the navigation
      // BouncingScrollPhysics()         Allows scrolling beyond the limits, although there are no widgets. Default behaviour in IoS
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),          // Avoid navigating
      children: <Widget>[

        Tab1Page(),

        Tab2Page()

      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();    // initialPage      by default is 0
  //PageController _pageController = new PageController(initialPage: 1);    // Second item in the PageView would be displayed


  int get paginaActual => this._paginaActual;
  set paginaActual( int valor ) {
    this._paginaActual = valor;

    // Change the item of the PageView to be displayed === navigate
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut );

    notifyListeners();    // Notify to all widget that it has been changed --> Force to redraw all the widgets
  }

  PageController get pageController => this._pageController;

}