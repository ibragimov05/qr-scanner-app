import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class GoToUrlWidget extends StatefulWidget {
  final String _data;
  const GoToUrlWidget({super.key, required String data}) : _data = data;

  @override
  State<GoToUrlWidget> createState() => _GoToUrlWidgetState();
}

class _GoToUrlWidgetState extends State<GoToUrlWidget> {
  void _launchUrl() async {
    if (widget._data.startsWith('https://') ||
        widget._data.startsWith('http://')) {
      if (!await launchUrl(
        Uri.parse(widget._data),
        mode: LaunchMode.externalApplication,
      )) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error launching url'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _launchUrl,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.ff333333,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data',
              style: AppTextStyles.workSansW500.copyWith(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget._data,
              style: AppTextStyles.workSansW500.copyWith(
                color: AppColors.white,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
