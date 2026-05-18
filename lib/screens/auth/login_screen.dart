import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/language_selector.dart';
import '../../utils/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _isPatient = true;
  bool _obscurePassword = true;
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
      _rememberMe,
    );
    
    if (!mounted) return;
    
    if (success) {
      if (authProvider.isDoctor) {
        Navigator.of(context).pushReplacementNamed('/doctor-dashboard');
      } else {
        Navigator.of(context).pushReplacementNamed('/patient-dashboard');
      }
    } else {
      Helpers.showSnackBar(context, AppLocalizations.of(context)!.loginError, isError: true);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: const [LanguageSelector(), SizedBox(width: 8)],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medical_services, size: 80, color: Theme.of(context).primaryColor),
                  const SizedBox(height: 32),
                  
                  // User Type Toggle
                  SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(value: true, label: Text(l10n.patient), icon: const Icon(Icons.person)),
                      ButtonSegment(value: false, label: Text(l10n.doctor), icon: const Icon(Icons.medical_services)),
                    ],
                    selected: {_isPatient},
                    onSelectionChanged: (Set<bool> newSelection) {
                      setState(() => _isPatient = newSelection.first);
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  CustomTextField(
                    controller: _emailController,
                    label: l10n.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return l10n.requiredField;
                      if (!Helpers.isValidEmail(value)) return 'Invalid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _passwordController,
                    label: l10n.password,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return l10n.requiredField;
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  
                  CheckboxListTile(
                    title: Text(l10n.rememberMe),
                    value: _rememberMe,
                    onChanged: (value) => setState(() => _rememberMe = value ?? true),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),
                  //Deneme asd
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: l10n.login,
                      onPressed: _login,
                      isLoading: authProvider.isLoading,
                      icon: Icons.login,
                    ),
                  ),
                  const SizedBox(height: 16),
                  //
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed('/forgot-password'),
                    child: Text(l10n.forgotPassword),
                  ),
                  
                  const SizedBox(height: 32),
                  Text('Demo: ali@mail.com / 123456', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
