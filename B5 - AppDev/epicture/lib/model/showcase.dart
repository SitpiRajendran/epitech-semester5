class Showcase {
  String title;
  String picSrc;
  String picDesc;
  String author;
  String link;
  int date;
  int views;
  int upvote;
  int downvote;
  int favorite;

  Showcase(title, picSrc, picDesc, link, author, date, views, upvote, downvote,
      favorite) {
    this.title = title;
    this.picSrc = picSrc;
    this.link = link;
    this.picDesc = picDesc;
    this.author = author;
    this.downvote = downvote;
    this.favorite = favorite;
    this.date = date;
    this.upvote = upvote;
    this.views = views;
  }
}
