import 'package:flutter/material.dart';

class GoodsListModel with ChangeNotifier {
  List<Goods> _goodList =
      List.generate(10, (index) => Goods(false, 'Goods No. $index'));

  get goodsList => _goodList;

  get total => _goodList.length;

  collect(int index) {
    var good = _goodList[index];
    _goodList[index] = Goods(!good.isCollection, good.goodsNo);
    notifyListeners();
  }
}

class Goods {
  bool isCollection;
  String goodsNo;

  Goods(this.isCollection, this.goodsNo);
}
