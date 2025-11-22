import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../utils/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // In a real app, you would check actual permissions here
    setState(() {
      _permissionGranted = true;
    });
  }

  Future<void> _requestPermissions() async {
    await NotificationService.requestPermissions();
    setState(() {
      _permissionGranted = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification permissions granted')),
      );
    }
  }

  Future<void> _sendTestNotification() async {
    await NotificationService.showNotification(
      id: 0,
      title: 'Test Notification',
      body: 'This is a test notification from Routiner!',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test notification sent!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Permission Status Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _permissionGranted
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _permissionGranted
                    ? AppColors.success.withOpacity(0.3)
                    : AppColors.warning.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _permissionGranted ? Icons.check_circle : Icons.warning,
                  color: _permissionGranted ? AppColors.success : AppColors.warning,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _permissionGranted
                            ? 'Notifications Enabled'
                            : 'Notifications Disabled',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _permissionGranted
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _permissionGranted
                            ? 'You will receive habit reminders'
                            : 'Enable to receive reminders',
                        style: TextStyle(
                          fontSize: 14,
                          color: _permissionGranted
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Configuration Section
          const Text(
            'Notification Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          // Request Permissions Button
          if (!_permissionGranted)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    color: AppColors.primary,
                  ),
                ),
                title: const Text('Enable Notifications'),
                subtitle: const Text('Grant permission to receive reminders'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: _requestPermissions,
              ),
            ),

          const SizedBox(height: 12),

          // Test Notification Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.send,
                  color: AppColors.accent,
                ),
              ),
              title: const Text('Send Test Notification'),
              subtitle: const Text('Test your notification settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _sendTestNotification,
            ),
          ),

          const SizedBox(height: 24),

          // Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.info.withOpacity(0.3),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Notifications',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.info,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Notifications help you stay on track with your habits. You can customize reminder times in the settings.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.info,
                          height: 1.4,
                        ),
                      ),
                    ],
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
