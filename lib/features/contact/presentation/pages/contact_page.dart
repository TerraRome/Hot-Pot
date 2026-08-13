import 'package:flutter/material.dart';
import 'package:hot_pot/core/utils/extensions.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent! I\'ll get back to you soon.')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get in Touch', style: context.textTheme.headlineMedium),
              8.verticalSpace,
              Text(
                'Have a project in mind? Let\'s talk.',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              32.verticalSpace,
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required.' : null,
              ),
              16.verticalSpace,
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required.';
                  if (!v.contains('@')) return 'Enter a valid email.';
                  return null;
                },
              ),
              16.verticalSpace,
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Message is required.' : null,
              ),
              24.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Send Message'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
