import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_2_restaurant_app/providers/preference_provider.dart';
import 'package:submission_2_restaurant_app/providers/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferenceProvider>(
        builder: (context, preference, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Notification'),
                    subtitle: const Text(
                      'Enabled Notification',
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduling, child) {
                        return Switch.adaptive(
                          value: preference.isEnabledNotification, 
                          onChanged: (value) {
                            preference.enabledNotification(value);
                            scheduling.scheduledNews(value);
                          }
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
}