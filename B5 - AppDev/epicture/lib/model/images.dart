class Img {
  String postName;
  String postAuthor;
  String link;
  int postFav;
  int postViews;
  int postUp;
  int date;
  int postDown;
  List imgsInfo;

  Img(
      {this.postName,
      this.postAuthor,
      this.link,
      this.postFav,
      this.postViews,
      this.date,
      this.postUp,
      this.postDown,
      this.imgsInfo});

  factory Img.fromJson(Map<String, dynamic> json) {
    final list = json['images'] as List;
    List<MyImg> myImgs;
    if (list != null && list.length > 0) {
      myImgs = list.map((e) => MyImg.fromJson(e)).toList();
    }
    return Img(
        postName: json["title"] as String,
        postAuthor: json["account_url"] as String,
        link: json["link"] as String,
        postFav: json["favorite_count"],
        postViews: json["views"] as int,
        date: json["datetime"] as int,
        postUp: json['ups'] as int,
        postDown: json['downs'] as int,
        imgsInfo: myImgs);
  }
}

class MyImg {
  String url;
  String type;
  String id;
  bool isFavorite;

  MyImg({
    this.url,
    this.type,
    this.id,
    this.isFavorite,
  });

  factory MyImg.fromJson(Map<String, dynamic> json) {
    return MyImg(
      url: json['link'] as String,
      type: json['type'] as String,
      id: json['id'] as String,
      isFavorite: json['favorite'] as bool,
    );
  }
}
