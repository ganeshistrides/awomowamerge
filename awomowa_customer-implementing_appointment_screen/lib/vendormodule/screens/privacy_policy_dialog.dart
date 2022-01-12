import 'package:awomowa/vendormodule/import_barrel.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AboutUsProvider>(builder:
        (BuildContext context, AboutUsProvider aboutUsProvider, Widget child) {
      return AlertDialog(
        title: ListTile(
          title: Text('Terms & policies'),
        ),
        content: aboutUsProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      '${aboutUsProvider.aboutUsResponse.appContent.privacyPolicy}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
}
