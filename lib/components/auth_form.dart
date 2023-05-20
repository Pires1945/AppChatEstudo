import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: (Text(msg)),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSingUp) {
      return _showError('Imagem não selecionada');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSingUp)
                  UserImagePicker(
                    onImagePick: _handleImagePick,
                  ),
                if (_formData.isSingUp)
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (value) => _formData.name = value,
                    validator: (_value) {
                      final name = _value ?? '';
                      if (name.trim().length < 5) {
                        return 'O nome deve ter pelo menos 5 caracteres';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (value) => _formData.email = value,
                  validator: (_value) {
                    final email = _value ?? '';
                    if (!email.contains('@')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (value) => _formData.password = value,
                  validator: (_value) {
                    final password = _value ?? '';
                    if (password.length < 5) {
                      return 'A senha deve conter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                  child: Text(_formData.isLogin
                      ? 'Criar uma nova conta ?'
                      : 'Já possui conta ?'),
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  },
                )
              ],
            )),
      ),
    );
  }
}
