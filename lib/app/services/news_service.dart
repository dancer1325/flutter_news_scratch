import 'package:flutter/material.dart';
import 'package:flutter_news_scratch/app/models/category_model.dart';
import 'package:flutter_news_scratch/app/models/news_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = '431a2b39236d43baaafbf67530faa12d';     // It shouldn't be pushed

// ChangeNotifier      Declare as part of Material App's widgets, to share the information
// Required to make all about this class, to be accessible from the context in any part of the Flutter application
class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });

    getArticlesByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;

    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory];

  getTopHeadlines() async {
    // In CA, urlToImage is always null
    //final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]?.length != null &&
        this.categoryArticles[category]!.length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    // Nothing found in ca
    // final url =
    //     '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]?.addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
