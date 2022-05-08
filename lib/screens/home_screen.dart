import 'package:bachhoaxanh/screens/searchScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/bottom_navigation.dart';
import '../components/navbar.dart';
import '../components/product_widget.dart';
import '../constant.dart';
import '../providers/CategoryProvider.dart';
import '../providers/ProductProvider.dart';
import '../providers/SearchProvider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  final List<String> imgList = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner4.jpg'
  ];


  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    Provider.of<ProductProvider>(context, listen: false).fetchBestSeller();
    Provider.of<ProductProvider>(context, listen: false).fetchHotDeals();
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProducts("All", true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        final selectedSubcategory =
            Provider.of<CategoryProvider>(context, listen: false).selectedSubcategory;
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts(selectedSubcategory, false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context).products;
    final bestSeller = Provider.of<ProductProvider>(context).bestSeller;
    final selectedSubcategory =
        Provider.of<CategoryProvider>(context).selectedSubcategory;
    final hotdeals = Provider.of<ProductProvider>(context).hotDeals;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          appName,
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                height: 74,
                margin: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFEDEEEF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 28,
                    ),
                    Image.asset('assets/images/search.png'),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      onSubmitted: (String value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen(searchValue: value)));
                      },
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'Spartan', height: 1.7),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                    ),
                    items: imgList
                        .map((item) => Container(
                              child: Center(
                                child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                    defaultPadding, defaultPadding / 2),
                child: Text(
                  'Hot deals',
                  style: TextStyle(fontSize: 18, fontFamily: 'Spartan'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: defaultPadding - 4),
                child: SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotdeals.length,
                    itemBuilder: (context, index) => ProductWidget(
                      tap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  product: hotdeals[index],
                                )));
                      },
                      product: hotdeals[index],
                      isMargin: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding,
                    defaultPadding, defaultPadding / 2),
                child: Text(
                  'Bán chạy',
                  style: TextStyle(fontSize: 18, fontFamily: 'Spartan'),
                ),
              ),
              // recommend product list view
              Padding(
                padding: EdgeInsets.only(left: defaultPadding - 4),
                child: SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bestSeller.length,
                    itemBuilder: (context, index) => ProductWidget(
                      tap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      product: bestSeller[index],
                                    )));
                      },
                      product: bestSeller[index],
                      isMargin: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding / 2,
                    defaultPadding, defaultPadding / 2),
                child: Text(
                  selectedSubcategory,
                  style: TextStyle(fontSize: 18, fontFamily: 'Spartan'),
                ),
              ),
              // products grid
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
              SizedBox(
                height: defaultPadding,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(selectedItem: 'home'),
      drawer: Navbar(),
    );
  }
}
