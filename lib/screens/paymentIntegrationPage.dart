import 'package:flutter/material.dart';

class PaymentIntegrationPage extends StatefulWidget {
  final double totalAmount;

  PaymentIntegrationPage({this.totalAmount = 500.0}); // example

  @override
  _PaymentIntegrationPageState createState() => _PaymentIntegrationPageState();
}

class _PaymentIntegrationPageState extends State<PaymentIntegrationPage> {
  String _selectedPayment = "COD";
  bool _saveCard = false;
  String? _wallet = "Paytm";
  TextEditingController _couponController = TextEditingController();

  double get finalAmount {
    double discount = _couponController.text == "SAVE50" ? 50 : 0;
    return widget.totalAmount + 20 - discount; // +20 delivery fee
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Integration"),
        centerTitle: size.width < 600,
        elevation: 6,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    _summaryRow("Items Total", "₹${widget.totalAmount}"),
                    _summaryRow("Delivery Fee", "₹20"),
                    _summaryRow(
                      "Discount",
                      _couponController.text == "SAVE50" ? "-₹50" : "₹0",
                    ),
                    Divider(),
                    _summaryRow(
                      "Grand Total",
                      "₹${finalAmount.toStringAsFixed(2)}",
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Coupon
            TextField(
              controller: _couponController,
              decoration: InputDecoration(
                labelText: "Enter Coupon Code",
                suffixIcon: IconButton(
                  icon: Icon(Icons.local_offer, color: Colors.red),
                  onPressed: () => setState(() {}),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Payment Methods
            _paymentOption(
              "COD",
              "Cash on Delivery",
              Icons.money,
              Colors.green,
            ),
            _paymentOption(
              "Card",
              "Card Payment",
              Icons.credit_card,
              Colors.blue,
            ),
            _paymentOption(
              "Wallet",
              "Wallets",
              Icons.account_balance_wallet,
              Colors.orange,
            ),
            _paymentOption("UPI", "UPI Payment", Icons.qr_code, Colors.purple),

            SizedBox(height: 20),

            // Dynamic Inputs
            if (_selectedPayment == "Card") _buildCardForm(isTablet),
            if (_selectedPayment == "Wallet") _buildWalletDropdown(),
            if (_selectedPayment == "UPI") _buildUpiInput(),

            SizedBox(height: 20),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Pay ₹${finalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OrderSuccessPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets ---
  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(
    String value,
    String title,
    IconData icon,
    Color color,
  ) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedPayment,
      title: Text(title),
      secondary: Icon(icon, color: color),
      onChanged: (val) => setState(() => _selectedPayment = val!),
    );
  }

  Widget _buildCardForm(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(decoration: InputDecoration(labelText: "Card Number")),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: "Expiry Date"),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(decoration: InputDecoration(labelText: "CVV")),
            ),
          ],
        ),
        CheckboxListTile(
          value: _saveCard,
          onChanged: (val) => setState(() => _saveCard = val!),
          title: Text("Save this card for future payments"),
        ),
      ],
    );
  }

  Widget _buildWalletDropdown() {
    return DropdownButtonFormField<String>(
      value: _wallet,
      items: ["Paytm", "PhonePe", "Amazon Pay"].map((w) {
        return DropdownMenuItem(value: w, child: Text(w));
      }).toList(),
      onChanged: (val) => setState(() => _wallet = val),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Select Wallet",
      ),
    );
  }

  Widget _buildUpiInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter UPI ID",
        border: OutlineInputBorder(),
      ),
    );
  }
}

class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Successful")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 20),
            Text(
              "Your order has been placed!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Order ID: #12345", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
