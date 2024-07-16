import 'package:flutter/material.dart';
import 'package:mygold/apps/mygold/views/bank/add_bank.dart';
import 'package:mygold/realm/bank/bank.dart';
import 'package:mygold/realm/realm_services.dart';
import 'package:provider/provider.dart';

enum MenuOption { edit, delete }

class BankItem extends StatelessWidget {
  final Banks bank;

  const BankItem(this.bank, {super.key});

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    //bool isMine = (bank.createby == realmServices.myGoldUser?.email);
    return bank.isValid
        ? ListTile(
            leading: Checkbox(
              value: bank.active,
              onChanged: (bool? value) async {},
            ),
            title: Text(bank.accountname ?? ""),
            subtitle: Text(bank.accountnumber ?? ""),
            trailing: SizedBox(
              width: 25,
              child: PopupMenuButton<MenuOption>(
                onSelected: (menuItem) =>
                    handleMenuClick(context, menuItem, bank, realmServices),
                itemBuilder: (context) => [
                  const PopupMenuItem<MenuOption>(
                    value: MenuOption.edit,
                    child: ListTile(
                        leading: Icon(Icons.edit), title: Text("Edit item")),
                  ),
                  const PopupMenuItem<MenuOption>(
                    value: MenuOption.delete,
                    child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text("Delete item")),
                  ),
                ],
              ),
            ),
            shape: const Border(bottom: BorderSide()),
          )
        : Container();
  }

  void handleMenuClick(BuildContext context, MenuOption menuItem, Banks item,
      RealmServices realmServices) {
    bool isMine = (item.createby == realmServices.myGoldUser?.email);
    switch (menuItem) {
      case MenuOption.edit:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBankScreen(
              bank: item,
            ),
          ),
        );

        break;
      case MenuOption.delete:
        if (isMine) {
          //realmServices.deleteItem(item);
        } else {}
        break;
    }
  }
}
