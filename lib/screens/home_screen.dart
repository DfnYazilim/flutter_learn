import 'package:flutter/material.dart';
import 'package:flutter_learn/models/product_model.dart';
import 'package:flutter_learn/providers/product_provider.dart';
import 'package:flutter_learn/screens/new_product_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<ProductProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
      ),
      body: FutureBuilder(
          builder: (BuildContext context,
              AsyncSnapshot<bool> snapshot) {
            print(snapshot.hasData);
            if (snapshot.hasData) {
              return Consumer<ProductProvider>(builder: (BuildContext context, provider, Widget? child) {
                  return ListView.builder(
                  itemBuilder: (context, index) {
                    var item = provider.list[index];
                    return Card(
                      child: ListTile(
                        title: Text("${item.name}"),
                        subtitle: Text("${item.description}"),
                        leading: Text("${item.price} TL"),
                      ),
                    );
                  },
                  itemCount: provider.list.length,
                );
              },);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: pp.getProducts()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NewProduct()))
              .then((value) {
            pp.getProducts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
