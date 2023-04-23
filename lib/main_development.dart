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


    return MultiProvider(
      providers: [
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