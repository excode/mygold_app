class ResponseData {
  final String _error;
  final List<dynamic> _list;
  final Map<String, dynamic> _data;
  final bool _status;
  final bool _forceLogin;

  ResponseData(
      {bool status = false,
      String error = "",
      Map<String, dynamic> data = const {},
      List<dynamic> list = const [],
      bool forceLogin = false})
      : _status = status,
        _error = error,
        _data = data,
        _list = list,
        _forceLogin = forceLogin;

  String get error => _error;

  Map<String, dynamic> get data => _data;
  List<dynamic> get list => _list;

  bool get status => _status;
  bool get forceLogin => _forceLogin;
}
