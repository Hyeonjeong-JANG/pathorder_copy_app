import 'package:flutter/material.dart';
import 'package:pathorder_app/ui/home/store_detail/menu/option/widgets/menu_option_body.dart';
import 'package:pathorder_app/ui/home/store_detail/menu/option/widgets/menu_option_bottom_app_bar.dart';
import 'package:pathorder_app/ui/widgets/custom_back_app_bar.dart';

class OptionPage extends StatelessWidget {
  final storeId;
  final menuId;
  final storeName;

  OptionPage(this.storeId, this.menuId, this.storeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: "${storeId}와${menuId}와$storeName"),
      body: MenuOptionBody([storeId, menuId]),
      bottomNavigationBar: MenuOptionBottomAppBar(),
    );
  }
}

// }
