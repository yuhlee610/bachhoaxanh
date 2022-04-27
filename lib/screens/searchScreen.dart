import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/product_widget.dart';
import '../constant.dart';
import '../providers/SearchProvider.dart';
import 'detail_screen.dart';

class SearchScreen extends StatelessWidget {
  String searchValue;

  SearchScreen({Key? key, required this.searchValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<SearchProvider>(context).products;
    Provider.of<SearchProvider>(context).fetchSearchProducts(searchValue);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Search",
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding - 4, vertical: defaultPadding - 4),
              child: Text(
                "Kết quả tìm kiếm: " + searchValue,
                style: TextStyle(fontSize: 18, fontFamily: 'Spartan'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding - 4),
              child: productsData.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      itemCount: productsData.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: defaultPadding - 4,
                        crossAxisSpacing: defaultPadding - 4,
                      ),
                      itemBuilder: (context, index) => ProductWidget(
                        tap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        product: productsData[index],
                                      )));
                        },
                        product: productsData[index],
                        isMargin: false,
                      ),
                    )
                  : Text(
                      'Không có dữ liệu',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Spartan',
                          fontWeight: FontWeight.w700,
                          color: textPrimaryColor),
                    ),
            ),
          ],
        )),
      ),
    );
  }
}
