import 'package:flutter/material.dart';
import '../models/reaction_role_config.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Mock data for initial display
  final List<ReactionRoleConfig> _configs = [
    ReactionRoleConfig(
      id: '1',
      channelName: '#welcome',
      messageContent: 'React with 🎉 to get the Party role!',
      emoji: '🎉',
      roleName: 'Party People',
    ),
    ReactionRoleConfig(
      id: '2',
      channelName: '#rules',
      messageContent: 'Agree to rules by reacting with ✅',
      emoji: '✅',
      roleName: 'Verified',
    ),
  ];

  void _navigateAndCreate(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/create');
    if (result != null && result is ReactionRoleConfig) {
      setState(() {
        _configs.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reaction Role created successfully!'),
          backgroundColor: Color(0xFF3BA55C),
        ),
      );
    }
  }

  void _deleteConfig(int index) {
    setState(() {
      _configs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reaction Roles Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings placeholder
            },
          ),
        ],
      ),
      body: _configs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No reaction roles configured yet.',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _configs.length,
              itemBuilder: (context, index) {
                final config = _configs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: const Color(0xFF2F3136),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: Text(config.channelName),
                              backgroundColor: const Color(0xFF202225),
                              labelStyle: const TextStyle(color: Colors.white70),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _deleteConfig(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          config.messageContent,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF202225),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF5865F2).withOpacity(0.5)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                config.emoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5865F2).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '@${config.roleName}',
                                  style: const TextStyle(
                                    color: Color(0xFF5865F2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateAndCreate(context),
        backgroundColor: const Color(0xFF5865F2),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Reaction Role', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
