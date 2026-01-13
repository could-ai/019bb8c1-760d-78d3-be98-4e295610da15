import 'package:flutter/material.dart';
import '../models/reaction_role_config.dart';

class CreateReactionScreen extends StatefulWidget {
  const CreateReactionScreen({super.key});

  @override
  State<CreateReactionScreen> createState() => _CreateReactionScreenState();
}

class _CreateReactionScreenState extends State<CreateReactionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String _channelName = '#general';
  String _messageContent = '';
  String _emoji = '👍';
  String _roleName = '';

  final List<String> _channels = ['#general', '#welcome', '#announcements', '#roles', '#rules'];
  final List<String> _commonEmojis = ['👍', '❤️', '✅', '🎉', '🔥', '🎮', '🎵', '🎨'];

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final newConfig = ReactionRoleConfig(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        channelName: _channelName,
        messageContent: _messageContent,
        emoji: _emoji,
        roleName: _roleName,
      );

      Navigator.pop(context, newConfig);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Reaction Role'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Target Channel',
                style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF202225),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _channelName,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF2F3136),
                    style: const TextStyle(color: Colors.white),
                    items: _channels.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _channelName = newValue!;
                      });
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Message Content',
                style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'e.g., React to get the Gamer role!',
                  hintStyle: TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: Color(0xFF202225),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter message content';
                  }
                  return null;
                },
                onSaved: (value) => _messageContent = value!,
              ),

              const SizedBox(height: 24),

              const Text(
                'Select Emoji',
                style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _commonEmojis.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final emoji = _commonEmojis[index];
                    final isSelected = _emoji == emoji;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _emoji = emoji;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF5865F2) : const Color(0xFF202225),
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
                        ),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),

              const Text(
                'Role Name',
                style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'e.g., Gamer',
                  prefixText: '@',
                  prefixStyle: TextStyle(color: Color(0xFF5865F2), fontWeight: FontWeight.bold),
                  hintStyle: TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: Color(0xFF202225),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a role name';
                  }
                  return null;
                },
                onSaved: (value) => _roleName = value!,
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5865F2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Create Reaction Role',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
