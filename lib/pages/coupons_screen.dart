import 'package:flutter/material.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class Coupon {
  String code;
  String title;
  String description;
  String priceTag;
  bool expanded;

  Coupon({
    required this.code,
    required this.title,
    required this.description,
    required this.priceTag,
    this.expanded = false,
  });
}

class _CouponsPageState extends State<CouponsPage> {
  final List<Coupon> coupons = [
    Coupon(
      code: 'LONGSTAY',
      title: 'LONGSTAY',
      description:
      '15% off when you book for 5 days or more and 20% off when you book for 30 days or more.',
      priceTag: '₹6,900',
    ),
    Coupon(
      code: 'LONGSTAY',
      title: 'LONGSTAY',
      description:
      '15% off when you book for 5 days or more and 20% off when you book for 30 days or more.',
      priceTag: '₹6,900',
    ),
  ];

  //============================= COMMON UTILS =============================//
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _editPriceTag(int index) async {
    final controller = TextEditingController(text: coupons[index].priceTag);

    final newPrice = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit price tag'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Price'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Save')),
        ],
      ),
    );

    if (newPrice != null && newPrice.isNotEmpty) {
      setState(() {
        coupons[index].priceTag = newPrice;
      });
      _showSuccess("Price updated");
    }
  }

  //============================= HEADER =============================//
  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TOP BAR: LOGO + MENU
        Container(
          padding: const EdgeInsets.fromLTRB(25, 45, 25, 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.home, color: Colors.brown, size: 32),
                  const SizedBox(width: 5),
                  Text(
                    "SPACEZ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.brown, size: 28),
                onPressed: () => _showSuccess("Menu clicked"),
              )
            ],
          ),
        ),

        Container(height: 2, color: Colors.grey.shade300),

        // PAGE TITLE
        Container(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 15),
          color: Colors.white,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, size: 27),
              ),
              const SizedBox(width: 12),
              const Text(
                "Coupons",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ],
    );
  }

  //============================= PRICE SIDE BAR =============================//
  Widget _sidePriceTag(String price) {
    return Container(
      width: 68,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFB7633D),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  //============================= COUPON CARD =============================//
  Widget _buildCouponCard(int index) {
    final c = coupons[index];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _editPriceTag(index),
              child: _sidePriceTag(c.priceTag),
            ),
            const SizedBox(width: 12),

            // Right Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Apply Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(c.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                      InkWell(
                        onTap: () => _showSuccess("${c.code} applied"),
                        child: Row(
                          children: const [
                            Icon(Icons.local_offer_outlined, color: Color(0xFFB7633D)),
                            SizedBox(width: 6),
                            Text("Apply",
                                style: TextStyle(
                                    color: Color(0xFFB7633D), fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    c.description,
                    style: const TextStyle(color: Colors.black54),
                    maxLines: c.expanded ? 10 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () => setState(() => c.expanded = !c.expanded),
                    child: Text(
                      c.expanded ? "Read less" : "Read more",
                      style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //============================= PAYMENT OFFER =============================//
  Widget _buildPaymentOffer() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _sidePriceTag("₹6,900"),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text("LONGSTAY",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                      ),
                      InkWell(
                        onTap: () => _showSuccess("Payment offer applied"),
                        child: Row(
                          children: const [
                            Icon(Icons.local_offer_outlined, color: Color(0xFFB7633D)),
                            SizedBox(width: 6),
                            Text("Apply",
                                style: TextStyle(
                                    color: Color(0xFFB7633D), fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "15% off when you book for 5 days or more and 20% off when you book for 30 days or more.",
                    style: TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () => _showSuccess("Read more on payment offer"),
                    child: const Text(
                      "Read more",
                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //============================= GREEN REWARD BAR =============================//
  Widget _rewardBar() {
    return Positioned(
      bottom: 72,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
        color: const Color(0xFF2E7D32),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: Colors.white),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Book now & Unlock exclusive rewards!",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () => _showSuccess("Learn clicked"),
              child: const Text("Learn", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  //============================= BOTTOM RESERVE BAR =============================//
  Widget _reserveBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("₹16,000 for 2 nights",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("24 Apr - 26 Apr | 8 guests",
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB7633D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              onPressed: () => _showSuccess("Reserved!"),
              child: const Text("Reserve",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }

  //============================= MAIN BUILD =============================//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          _buildHeader(),

          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(bottom: 150),
                  children: [
                    const SizedBox(height: 8),
                    ...List.generate(coupons.length, _buildCouponCard),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text("Payment offers:",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    _buildPaymentOffer(),
                    const SizedBox(height: 50),
                  ],
                ),

                _rewardBar(),
                _reserveBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
