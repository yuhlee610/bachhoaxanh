import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/category.dart';
import '../models/user.dart';
import '../providers/CategoryProvider.dart';
import '../providers/ProductProvider.dart';
import '../providers/UserProvider.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  @override
  void initState() {
    super.initState();

    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
  }

  List<Widget> _buildCategoryMenu(List<Category> data, String selectedSubcategory) {
    return data
        .map(
          (category) =>
          ExpansionTile(
            title: Text(
              category.name,
              style: TextStyle(fontFamily: 'Spartan'),
            ),
            children: category.subcategories
                .map((e) =>
                ListTile(
                  onTap: () {
                    Provider.of<CategoryProvider>(context, listen: false).setSelectedSubcategory(e);
                    Provider.of<ProductProvider>(context, listen: false)
                        .fetchProducts(
                        e, true);
                  },
                  title: Text(
                    e,
                    style: TextStyle(fontFamily: 'Spartan'),
                  ),
                ))
                .toList(),
          ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider
        .of<UserProvider>(context)
        .user;
    List<Category> categories =
        Provider
            .of<CategoryProvider>(context)
            .categories;
    String selectedSubcategory = Provider.of<CategoryProvider>(context).selectedSubcategory;
    return SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  user.name,
                  style: TextStyle(color: Colors.white, fontFamily: 'Spartan'),
                ),
                accountEmail: Text(user.email,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Spartan')),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://ui-avatars.com/api/?name=${user
                          .name}&&background=F08080&&color=ffffff',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Thông tin tài khoản',
                  style: TextStyle(fontFamily: 'Spartan'),
                ),
                onTap: () => Navigator.pushNamed(context, profileRoute),
              ),
              ListTile(
                leading: Icon(Icons.all_inbox_rounded),
                title: Text('Orders', style: TextStyle(fontFamily: 'Spartan')),
                onTap: () => Navigator.pushNamed(context, orderRoute),
              ),
              Divider(),
              ListTile(
                title: Text(
                    'Đăng xuất', style: TextStyle(fontFamily: 'Spartan')),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).signOut();
                  Navigator.pushReplacementNamed(context, loginRoute);
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginRoute, (route) => false);
                },
              ),
              Column(
                children: _buildCategoryMenu(categories, selectedSubcategory),
              )
            ],
          ),
        ));
  }
}
