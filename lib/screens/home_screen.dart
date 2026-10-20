import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/interactive_widgets.dart';
import '../providers/crop_provider.dart';
import '../providers/expense_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimations = List.generate(6, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 0.6 + index * 0.1, curve: Curves.easeOutCubic),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.softBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Elegant App Bar
          true
              ? SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text('AgriSense', style: TextStyle(fontWeight: FontWeight.w700)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F5C3A), AppTheme.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
            ],
          )
              : const SliverToBoxAdapter(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weather Card
                  FadeTransition(
                    opacity: _fadeAnimations[0],
                    child: InteractiveCard(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.wb_sunny_rounded, color: AppTheme.primary, size: 32),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Today’s Weather', style: TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                                SizedBox(height: 4),
                                Text('28°C • Partly Cloudy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                SizedBox(height: 2),
                                Text('Humidity 65%  •  Rain 20%', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Quick Actions Title
                  FadeTransition(
                    opacity: _fadeAnimations[1],
                    child: const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 14),

                  // Quick Actions Grid
                  FadeTransition(
                    opacity: _fadeAnimations[2],
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.35,
                      children: [
                        _QuickAction(
                          icon: Icons.camera_alt_rounded,
                          title: 'Detect Disease',
                          color: const Color(0xFFE57373),
                          onTap: () {},
                        ),
                        _QuickAction(
                          icon: Icons.grass_rounded,
                          title: 'My Crops',
                          color: AppTheme.primary,
                          onTap: () {},
                        ),
                        _QuickAction(
                          icon: Icons.water_drop_rounded,
                          title: 'Irrigation',
                          color: const Color(0xFF42A5F5),
                          onTap: () {},
                        ),
                        _QuickAction(
                          icon: Icons.account_balance_wallet_rounded,
                          title: 'Expenses',
                          color: AppTheme.accent,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Summary Cards
                  FadeTransition(
                    opacity: _fadeAnimations[3],
                    child: Row(
                      children: [
                        Expanded(
                          child: InteractiveCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Active Crops', style: TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                                const SizedBox(height: 8),
                                Text('${cropProvider.crops.length}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: InteractiveCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Net Profit', style: TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                                const SizedBox(height: 8),
                                Text(
                                  '₹${expenseProvider.profit.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: expenseProvider.profit >= 0 ? AppTheme.primary : AppTheme.danger,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Recent Crops
                  FadeTransition(
                    opacity: _fadeAnimations[4],
                    child: const Text('Your Crops', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 14),

                  FadeTransition(
                    opacity: _fadeAnimations[5],
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cropProvider.crops.length,
                        itemBuilder: (context, index) {
                          final crop = cropProvider.crops[index];
                          return Padding(
                            padding: EdgeInsets.only(right: index == cropProvider.crops.length - 1 ? 0 : 14),
                            child: InteractiveCard(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary.withOpacity(0.12),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(Icons.eco, color: AppTheme.primary, size: 22),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(crop.stage, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(crop.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                                    const SizedBox(height: 2),
                                    Text(crop.variety, style: const TextStyle(color: AppTheme.textGrey, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 12),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
        ],
      ),
    );
  }
}