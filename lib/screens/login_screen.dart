import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  final ValueChanged<String> onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _role = 'Farmer';
  bool _createAccount = false;
  bool _obscure = true;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_email.text.trim().isEmpty || _password.text.isEmpty ||
        (_createAccount && _name.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }
    // This UI-only project has no authentication backend configured.
    // Continue in demo mode; connect Supabase/Firebase before production use.
    widget.onLogin(_role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.softBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 82, width: 82,
                    decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(24)),
                    child: const Icon(Icons.agriculture_rounded, color: Colors.white, size: 42),
                  ),
                  const SizedBox(height: 22),
                  const Text('AgriSense', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppTheme.primary)),
                  const SizedBox(height: 6),
                  const Text('Smart farming. Better decisions.', style: TextStyle(color: AppTheme.textGrey, fontSize: 15)),
                  const SizedBox(height: 28),
                  const Text('Continue as', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: _RoleCard(
                      title: 'Farmer', subtitle: 'Manage crops & upload photos',
                      icon: Icons.grass_rounded, selected: _role == 'Farmer',
                      onTap: () => setState(() => _role = 'Farmer'),
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _RoleCard(
                      title: 'Dealer', subtitle: 'Connect with farmers',
                      icon: Icons.storefront_rounded, selected: _role == 'Dealer',
                      onTap: () => setState(() => _role = 'Dealer'),
                    )),
                  ]),
                  const SizedBox(height: 24),
                  Text(_createAccount ? 'Create your account' : 'Welcome back',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  if (_createAccount) ...[
                    TextField(controller: _name, textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline))),
                    const SizedBox(height: 12),
                  ],
                  TextField(controller: _email, keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Email address', prefixIcon: Icon(Icons.email_outlined))),
                  const SizedBox(height: 12),
                  TextField(controller: _password, obscureText: _obscure,
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () => setState(() => _obscure = !_obscure)))),
                  const SizedBox(height: 20),
                  SizedBox(height: 52, child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(_createAccount ? 'Create account' : 'Login as $_role'),
                  )),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() => _createAccount = !_createAccount),
                    child: Text(_createAccount ? 'Already have an account? Login' : 'New to AgriSense? Create account'),
                  ),
                  const SizedBox(height: 8),
                  const Text('Demo UI: authentication is not connected to a server yet.',
                    textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textGrey, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _RoleCard({required this.title, required this.subtitle, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(18), onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selected ? AppTheme.primary.withOpacity(.09) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: selected ? AppTheme.primary : Colors.black12, width: selected ? 2 : 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppTheme.primary, size: 28),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(fontSize: 11.5, color: AppTheme.textGrey)),
      ]),
    ),
  );
}
