import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/interactive_widgets.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  String? _imageName;
  bool _loading = false;

  Future<void> _chooseImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1800,
      );
      if (picked == null) return;
      final bytes = await picked.readAsBytes();
      if (!mounted) return;
      setState(() {
        _imageBytes = bytes;
        _imageName = picked.name;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open image source. Please try again.')),
      );
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Add crop photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded, color: AppTheme.primary),
              title: const Text('Take a photo'),
              subtitle: const Text('Use your device camera'),
              onTap: () { Navigator.pop(context); _chooseImage(ImageSource.camera); },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded, color: AppTheme.primary),
              title: const Text('Choose from gallery'),
              subtitle: const Text('Upload an existing crop image'),
              onTap: () { Navigator.pop(context); _chooseImage(ImageSource.gallery); },
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBg,
      appBar: AppBar(title: const Text('Crop Photo')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Upload a crop photo', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Take a clear picture of the affected leaf or select one from your gallery.',
            style: TextStyle(color: AppTheme.textGrey, height: 1.5)),
          const SizedBox(height: 20),
          InteractiveCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 310,
                color: Colors.grey.shade100,
                child: _imageBytes == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined, size: 72, color: AppTheme.primary),
                          SizedBox(height: 16),
                          Text('Your crop photo will appear here', style: TextStyle(color: AppTheme.textGrey)),
                        ],
                      )
                    : Image.memory(_imageBytes!, fit: BoxFit.contain),
              ),
            ),
          ),
          if (_imageName != null) ...[
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.check_circle, color: AppTheme.primary, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(_imageName!, maxLines: 1, overflow: TextOverflow.ellipsis)),
              IconButton(
                tooltip: 'Remove photo',
                onPressed: () => setState(() { _imageBytes = null; _imageName = null; }),
                icon: const Icon(Icons.close_rounded),
              ),
            ]),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _showImageOptions,
              icon: const Icon(Icons.upload_file_rounded),
              label: Text(_imageBytes == null ? 'Take Photo / Upload Photo' : 'Change Photo'),
            ),
          ),
          const SizedBox(height: 14),
          if (_imageBytes != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppTheme.primary.withOpacity(.08), borderRadius: BorderRadius.circular(16)),
              child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.info_outline_rounded, color: AppTheme.primary),
                SizedBox(width: 10),
                Expanded(child: Text(
                  'Photo selected on this device. Cloud storage and AI disease analysis are not connected in this UI build, so the image is not yet sent to a server.',
                  style: TextStyle(height: 1.45),
                )),
              ]),
            ),
          const SizedBox(height: 18),
          const Text('Photo tips', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('• Use natural light\n• Keep the affected leaf in focus\n• Include both healthy and affected areas if possible',
            style: TextStyle(color: AppTheme.textGrey, height: 1.7)),
        ],
      ),
    );
  }
}
