import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../widgets/interactive_widgets.dart';
import '../providers/crop_provider.dart';
import '../models/crop.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.softBg,
      appBar: AppBar(
        title: const Text('My Crops'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => _showAddCropDialog(context),
          ),
        ],
      ),
      body: cropProvider.crops.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grass_rounded, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('No crops yet', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
            const SizedBox(height: 20),
            SoftButton(
              text: 'Add Your First Crop',
              icon: Icons.add,
              onPressed: () => _showAddCropDialog(context),
            ),
          ],
        ),
      )
          : ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: cropProvider.crops.length,
        itemBuilder: (context, index) {
          final crop = cropProvider.crops[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
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
                    child: const Icon(Icons.eco_rounded, color: AppTheme.primary, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(crop.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                        const SizedBox(height: 4),
                        Text('Variety: ${crop.variety}', style: const TextStyle(color: AppTheme.textGrey, fontSize: 13)),
                        const SizedBox(height: 2),
                        Text(
                          'Planted: ${DateFormat('dd MMM yyyy').format(crop.plantedDate)}',
                          style: const TextStyle(color: AppTheme.textGrey, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            crop.stage,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.danger),
                    onPressed: () => cropProvider.removeCrop(crop.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: SoftButton(
        text: 'Add Crop',
        icon: Icons.add_rounded,
        onPressed: () => _showAddCropDialog(context),
      ),
    );
  }

  void _showAddCropDialog(BuildContext context) {
    final nameController = TextEditingController();
    final varietyController = TextEditingController();
    String selectedStage = 'Sowing';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Add New Crop'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Crop Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  prefixIcon: const Icon(Icons.grass),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: varietyController,
                decoration: InputDecoration(
                  labelText: 'Variety',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: selectedStage,
                decoration: InputDecoration(
                  labelText: 'Current Stage',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                items: ['Sowing', 'Growing', 'Flowering', 'Harvest']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => selectedStage = val!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          SoftButton(
            text: 'Add Crop',
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Provider.of<CropProvider>(context, listen: false).addCrop(
                  Crop(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text.trim(),
                    variety: varietyController.text.trim().isEmpty ? 'Local' : varietyController.text.trim(),
                    plantedDate: DateTime.now(),
                    stage: selectedStage,
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}