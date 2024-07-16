import 'package:flutter/material.dart';
import 'package:mygold/apps/mygold/views/bank/add_bank.dart';
import 'package:mygold/realm/bank/bank.dart';
import 'package:mygold/apps/mygold/views/bank/bank_item.dart';
import 'package:mygold/realm/realm_services.dart';
import 'package:mygold/widgets/material/extra/loading.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:url_launcher/url_launcher.dart';

class BankList extends StatefulWidget {
  const BankList({super.key});

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBankScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.add_box_rounded)),
                  const Expanded(
                    child: Text("Show All Tasks", textAlign: TextAlign.right),
                  ),
                  Switch(
                    value: realmServices.showBank,
                    onChanged: (value) async {
                      if (realmServices.offlineModeOn) {}
                      await realmServices.switchSubscription(value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: StreamBuilder<RealmResultsChanges<Banks>>(
                  stream: realmServices.realm
                      .query<Banks>("TRUEPREDICATE SORT(_id ASC)")
                      .changes,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    //print(data!.results.first);
                    if (data == null) return Loading();

                    final results = data.results;
                    // print("results.length");
                    // print(results.length);
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, index) => results[index].isValid
                          ? BankItem(results[index])
                          : Container(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        realmServices.isWaiting ? Loading() : Container(),
      ],
    );
  }

  _launchURL({required String url}) async {
    Uri parsedUrl = Uri.parse(url);

    if (url.isNotEmpty) {
      await launchUrl(parsedUrl);
    } else {
      throw 'Could not open $parsedUrl';
    }
  }
}
