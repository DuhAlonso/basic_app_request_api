class Post {
  int _userId;
  int? _id;
  String _title;
  String _body;

  Post(this._userId, this._id, this._title, this._body);

  Map toJson() {
    return {
      "userId": _userId,
      "id": _id,
      "title": _title,
      "body": _body,
    };
  }

  int get userId => _userId;

  set userId(int value) => _userId = value;

  get id => _id;

  set id(value) => _id = value;

  get title => _title;

  set title(value) => _title = value;

  get body => _body;

  set body(value) => _body = value;
}
