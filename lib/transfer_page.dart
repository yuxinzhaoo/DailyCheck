import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  final double availableAmount;
  final String username;

  const TransferPage({required this.availableAmount, required this.username});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final List<String> germanBanks = [
    'Deutsche Bank',
    'Commerzbank',
    'Sparkasse',
    'Volksbank',
    'N26',
    'DKB',
    'HypoVereinsbank',
    'Web3 Wallet (EUROe / EURe)',
  ];

  late String selectedAccount;
  late double transferAmount;
  final double fee = 2.00;
  late TextEditingController amountController;
  String walletAddress = '';

  @override
  void initState() {
    super.initState();
    transferAmount = widget.availableAmount;
    selectedAccount = germanBanks[0];
    amountController = TextEditingController(
      text: transferAmount.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalAfterFee = (transferAmount - fee).clamp(
      0,
      widget.availableAmount,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Transfer Earnings')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, ${widget.username}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(
              'Available: \$${widget.availableAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text('Transfer to', style: TextStyle(fontSize: 16)),
            PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  selectedAccount = value;
                });
              },
              itemBuilder: (context) => germanBanks.map((bank) {
                return PopupMenuItem<String>(value: bank, child: Text(bank));
              }).toList(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedAccount),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (selectedAccount.contains('Web3 Wallet')) ...[
              SizedBox(height: 20),
              Text('Recipient Wallet Address', style: TextStyle(fontSize: 16)),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: '0x...'),
                onChanged: (value) {
                  setState(() {
                    walletAddress = value;
                  });
                },
              ),
            ],
            SizedBox(height: 20),
            Text('Amount to transfer', style: TextStyle(fontSize: 16)),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
              onChanged: (value) {
                setState(() {
                  transferAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Transfer Fee: \$${fee.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              'Total after fee: \$${totalAfterFee.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green[700]),
            ),
            Spacer(),
            ElevatedButton(
              onPressed:
                  transferAmount > fee &&
                      transferAmount <= widget.availableAmount &&
                      (!selectedAccount.contains('Web3 Wallet') ||
                          walletAddress.isNotEmpty)
                  ? () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Transfer Successful'),
                          content: Text(
                            selectedAccount.contains('Web3 Wallet')
                                ? 'You transferred \$${transferAmount.toStringAsFixed(2)} to Web3 wallet at $walletAddress.'
                                : 'You transferred \$${transferAmount.toStringAsFixed(2)} to $selectedAccount.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Confirm Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
