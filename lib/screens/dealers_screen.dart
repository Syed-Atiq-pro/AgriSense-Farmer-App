import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/interactive_widgets.dart';

class DealersScreen extends StatelessWidget {
  const DealersScreen({super.key});

  final List<Map<String, dynamic>> dealers = const [
    {'name': 'Green Harvest Agro', 'type': 'Seeds & Fertilizers', 'distance': '2.4 km', 'rating': 4.7},
    {'name': 'Krishi Seva Kendra', 'type': 'Pesticides & Tools', 'distance': '5.1 km', 'rating': 4.5},
    {'name': 'FarmCare Suppliers', 'type': 'Organic Manure', 'distance': '3.8 km', 'rating': 4.8},
    {'name': 'AgriTech Solutions', 'type': 'Irrigation Equipment', 'distance': '7.2 km', 'rating': 4.3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBg,
      appBar: AppBar(title: const Text('Nearby Dealers')),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: dealers.length,
        itemBuilder: (context, index) {
          final dealer = dealers[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: InteractiveCard(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.store_rounded, color: AppTheme.primary, size: 26),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dealer['name'], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                            const SizedBox(height: 2),
                            Text(dealer['type'], style: const TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                            const SizedBox(width: 3),
                            Text('${dealer['rating']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(dealer['distance'], style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      const Spacer(),
                      SoftButton(
                        text: 'Call',
                        icon: Icons.call_rounded,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}