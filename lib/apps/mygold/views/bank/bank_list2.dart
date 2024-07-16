import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mygold/apps/mygold/controller/mygold_controller.dart';
import 'package:mygold/apps/mygold/views/bank/add_bank.dart';
import 'package:mygold/locator.dart';
import 'package:mygold/realm/bank/bank.dart';
import 'package:mygold/apps/mygold/views/bank/bank_item.dart';
import 'package:mygold/utils/apiResponse.dart';
import 'package:mygold/widgets/material/extra/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class BankList2 extends StatefulWidget {
  const BankList2({super.key});

  @override
  State<BankList2> createState() => _BankListState();
}

class _BankListState extends State<BankList2> {
  List<Banks>? _banks;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBanks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchBanks() async {
    setState(() {
      _isLoading = true;
    });
    final mygoldService = getIt<MyGoldService>();
    ApiResponse<Banks> apiResponse = await mygoldService.getList<Banks>(
      path: '/bank',
      queryString: {},
      context: context,
      fromJsonT: (json) => Banks.fromJson(json),
    );
    // print("apiResponse.count");
    // print(apiResponse.count);
    // print(apiResponse.docs);
    setState(() {
      _banks = apiResponse.docs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Icon(Icons.add_alarm),
                  ),
                  const Expanded(
                    child: Text("Show All Tasks", textAlign: TextAlign.right),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: _isLoading
                    ? Loading()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _banks?.length ?? 0,
                        itemBuilder: (context, index) {
                          final bank = _banks![index];
                          return bank.isValid ? BankItem(bank) : Container();
                        },
                      ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(15, 0, 40, 15),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'To see your changes in Atlas, ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'tap here.',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 98, 255)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(url: "mygold.ai"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(15, 0, 40, 15),
              child: const Text(
                "Log in with the same account on another device to see your list sync in real-time.",
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        _isLoading ? Loading() : Container(),
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
