import 'package:awomowa/vendormodule/import_barrel.dart';

class ColorPickerScreen extends StatefulWidget {
  static const routeName = '/vendorcolorpicker';

  final VendorDetailsProvider vendorDetailsProvider;

  const ColorPickerScreen({this.vendorDetailsProvider});

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  int currentColorIndex = 0;
  List<String> colors = ['#FFC324', '#FF5252', '#03A9F4', '#4CAF50', '#7C4DFF'];
  int initialPage = 0;

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Color summy = Colors.green;

  @override
  void initState() {
    super.initState();

    initialPage = colors.indexOf(widget.vendorDetailsProvider
        .vendorDetailsResponse.merchantInformations.appColorCode);
    currentColorIndex = colors.indexOf(widget.vendorDetailsProvider
        .vendorDetailsResponse.merchantInformations.appColorCode);

    if (initialPage == -1) {
      initialPage = currentColorIndex = 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeColorProvider>(
      builder: (BuildContext context, ThemeColorProvider themeColorProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: hexToColor(colors[currentColorIndex]),
            title: Text(widget.vendorDetailsProvider.vendorDetailsResponse
                .merchantInformations.shopName),
          ),
          body: AnimatedContainer(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            duration: Duration(milliseconds: 500),
            child: Stack(
              children: [
                Container(
                  child: PageView.builder(
                      controller: PageController(
                          viewportFraction: 0.8, initialPage: initialPage),
                      itemCount: colors.length,
                      onPageChanged: (int page) {
                        currentColorIndex = page;
                        setState(() {});
                      },
                      itemBuilder: (ctx, index) {
                        return Container(
                          height: 100.0,
                          child: Center(
                            child: ShopInfoCard(
                              vendorDetailsProvider:
                                  widget.vendorDetailsProvider,
                              isClickable: false,
                              colorCode: colors[index],
                            ),
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: LoaderButton(
                            btnTxt: 'Select Color',
                            isLoading: themeColorProvider.isLoading,
                            btnColor: hexToColor(colors[currentColorIndex]),
                            onPressed: () async {
                              await themeColorProvider
                                  .updateColor(colors[currentColorIndex]);

                              if (themeColorProvider
                                      .updateThemeResponse['status'] ==
                                  'success') {
                                Navigator.pop(context);
                                Provider.of<VendorDetailsProvider>(context,
                                        listen: false)
                                    .getVendorDetails();
                              } else {
                                showSnackBar(themeColorProvider
                                    .updateThemeResponse['message']);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
