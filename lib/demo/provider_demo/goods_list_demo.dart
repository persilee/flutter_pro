import 'package:flutter/material.dart';
import 'package:pro_flutter/model/goods_list_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class GoodsListDemo extends StatelessWidget {
  final String title;

  GoodsListDemo({this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoodsListModel(),
      child: goodsList(context),
    );
  }

  Widget goodsList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Selector<GoodsListModel, GoodsListModel>(
        shouldRebuild: (pre, next) => false,
        selector: (context, provider) => provider,
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.total,
            itemBuilder: (context, index) {
              return Selector<GoodsListModel, Goods>(
                selector: (context, provider) => provider.goodsList[index],
                builder: (context, data, child) {
                  print('No.${index + 1} rebuild');

                  return ListTile(
                    title: Text(data.goodsNo),
                    trailing: GestureDetector(
                      onTap: () {
                        provider.collect(index);
                        Toast.show(
                          'No.${index + 1} rebuild',
                          context,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black87,
                        );
                      },
                      child: Icon(
                        data.isCollection ? Icons.star : Icons.star_border,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
