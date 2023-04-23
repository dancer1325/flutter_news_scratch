import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_scratch/app/pages/tabs_page.dart';
import 'package:flutter_news_scratch/app/services/news_service.dart';
import 'package:flutter_news_scratch/app/theme/tema.dart';
import 'package:provider/provider.dart';

// void main() {
//   bootstrap(() => const App());
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light );

    // Required in case you need several providers
    return MultiProvider(
      providers: [
        // NewsService Provider at highest level of the application
        // lazy   By default, it's true === Just instantiated once some Widget needs it
        ChangeNotifierProvider(create: (_)=> new NewsService() ),
      ],
      child: MaterialApp(
          title: 'Material App',
          theme: miTema,
          debugShowCheckedModeBanner: false,
          home: TabsPage()
      ),
    );
  }
}