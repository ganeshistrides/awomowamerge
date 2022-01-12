import 'package:awomowa/vendormodule/import_barrel.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static const routeName = '/vendortransactionHistory';
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<TransactionHistoryProvider>(context, listen: false)
            .getHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionHistoryProvider>(
      builder: (BuildContext context,
          TransactionHistoryProvider transactionHistoryProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Payment History'),
          ),
          body: transactionHistoryProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: transactionHistoryProvider
                      .transactionHistoryResponse.transactionHistory.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                        child: ListTile(
                      title: Text(transactionHistoryProvider
                          .transactionHistoryResponse
                          .transactionHistory[index]
                          .packageInforamtion
                          .packageName),
                      subtitle: Text(transactionHistoryProvider
                          .transactionHistoryResponse
                          .transactionHistory[index]
                          .subscribeStartDate),
                      trailing: Text(
                          '\$ ${transactionHistoryProvider.transactionHistoryResponse.transactionHistory[index].packageInforamtion.packageAmountwithTax}'),
                    ));
                  }),
        );
      },
    );
  }
}
