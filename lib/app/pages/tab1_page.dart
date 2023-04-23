import 'package:flutter/material.dart';
import 'package:flutter_news_scratch/app/services/news_service.dart';
import 'package:flutter_news_scratch/app/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

// Page which displays the top headlines
class Tab1Page extends StatefulWidget {

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    // Get access to the NewsService Provider via context
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: ( headlines.isEmpty )
          ? const Center(child: CircularProgressIndicator() )
                // CircularProgressIndicator     Widget which shows a circular loading
          : ListaNoticias( headlines )
   );
  }

  @override
  bool get wantKeepAlive => true;
}