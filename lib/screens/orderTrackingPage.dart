import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  int currentStep = 0;

  final List<String> steps = [
    "Pending",
    "Accepted",
    "Preparing",
    "Out for Delivery",
    "Delivered",
  ];

  // Fake ETA times
  final List<String> eta = [
    "Waiting for restaurant confirmation",
    "Your order has been accepted",
    "Chef is preparing your food",
    "Rider is on the way",
    "Enjoy your meal 🎉",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isTablet = MediaQuery.of(context).size.width > 600;

    double progress = (currentStep + 1) / steps.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Contacting support...")));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  color: Colors.deepPurple,
                  backgroundColor: Colors.grey[300],
                  minHeight: 8,
                ),
                SizedBox(height: 8),
                Text(
                  "Order Progress: ${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Stepper
          Expanded(
            child: Stepper(
              type: StepperType.vertical,
              currentStep: currentStep,
              physics: BouncingScrollPhysics(),
              onStepTapped: (index) {
                setState(() {
                  currentStep = index;
                });
              },
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    if (currentStep < steps.length - 1)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          setState(() {
                            if (currentStep < steps.length - 1) {
                              currentStep++;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Status: ${steps[currentStep]}",
                                  ),
                                ),
                              );
                            }
                          });
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (currentStep > 0) SizedBox(width: 10),
                    if (currentStep > 0)
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            currentStep--;
                          });
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 14,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                  ],
                );
              },
              steps: List.generate(
                steps.length,
                (index) => Step(
                  title: Text(
                    steps[index],
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    eta[index],
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  isActive: index <= currentStep,
                  state: index < currentStep
                      ? StepState.complete
                      : index == currentStep
                      ? StepState.editing
                      : StepState.indexed,
                ),
              ),
            ),
          ),

          // Fake Map Tracking
          Container(
            height: isTablet ? 250 : 180,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple, width: 1),
            ),
            child: Center(
              child: Text(
                "🗺️ Delivery Location Tracking (Map Placeholder)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),

          // Bottom Action Buttons
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: Icon(Icons.cancel, color: Colors.white),
                    label: Text(
                      "Cancel Order",
                      style: TextStyle(fontSize: isTablet ? 18 : 14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Order Cancelled ❌")),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: Icon(Icons.phone, color: Colors.white),
                    label: Text(
                      "Contact Rider",
                      style: TextStyle(fontSize: isTablet ? 18 : 14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Calling Rider 📞")),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
