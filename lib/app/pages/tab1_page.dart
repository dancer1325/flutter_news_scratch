import 'package:flutter/material.dart';
import 'package:flutter_news_scratch/app/services/news_service.dart';
import 'package:flutter_news_scratch/app/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

// 1. Page which displays the top headlines
// 2. Since once we switch and come back to this page, we would like to continue from we left --> use StatefulWidget
class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

// AutomaticKeepAliveClientMixin      Allows continue reading from we left
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // Get access to the NewsService Provider via context
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
        body: (headlines.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            // CircularProgressIndicator     Widget which shows a circular loading
            : ListaNoticias(headlines));
  }

  // Property to keep alive the state
  @override
  bool get wantKeepAlive => true;
}
