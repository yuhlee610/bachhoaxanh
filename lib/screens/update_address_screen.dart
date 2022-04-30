import 'package:bachhoaxanh/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/UserProvider.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  TextEditingController newAddressController = new TextEditingController();
  TextEditingController editAddressController = new TextEditingController();

  Widget _buildAddressCard(String address, String userId) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Sửa địa chỉ'),
                content: TextField(
                  controller: editAddressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Địa chỉ',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .editAddress(userId, editAddressController.text, address);
                      Navigator.pop(context, 'Add');
                      editAddressController.clear();
                    },
                    child: const Text('Sửa'),
                  ),
                ],
              )),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 2.0),
            borderRadius: BorderRadius.circular(4.0)),
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                        fontFamily: 'Spartan', fontSize: 15, height: 1.6),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .removeAddress(userId, address);
                  },
                  child: Icon(Icons.delete_outline),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Cập nhật địa chỉ',
          style: TextStyle(fontFamily: 'Spartan', color: Colors.black),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Thêm địa chỉ'),
                          content: TextField(
                            controller: newAddressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Địa chỉ',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .addAddress(currentUser.id,
                                        newAddressController.text);
                                Navigator.pop(context, 'Add');
                              },
                              child: const Text('Thêm'),
                            ),
                          ],
                        )),
                child: Icon(Icons.add),
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(defaultPadding - 4),
            child: Column(
              children: [
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: currentUser.address.length,
                  itemBuilder: (context, index) => _buildAddressCard(
                      currentUser.address[index], currentUser.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
