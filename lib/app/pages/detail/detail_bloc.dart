import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBloc extends Disposable{

  String _shareWa;

  String get shareWa =>_shareWa;

  setShareWa(var val){
    _shareWa='https://wa.me/?text=$val';
  }

  String formatDate(DateTime _date) {
    String formattedDate = DateFormat('dd MMM yyyy').format(_date);
    return formattedDate;
  }

  @override
  void dispose() {
  }

}