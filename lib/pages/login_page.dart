import 'dart:ffi';

import 'package:atividade_aula_navegacao/widget/account_user.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import 'notes_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confPassword = TextEditingController();

  bool isLogin = true;
  late String title;
  late String actionButtom;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      limparCampo();

      if (isLogin) {
        title = 'Seja ben vindo!';
        actionButtom = 'Entrar';
        toggleButton = 'Você possui conta: Cadastre-se.';
      } else {
        title = 'Crie sua conta';
        actionButtom = 'Cadastrar';
        toggleButton = 'Voltar ao login.';
      }
    });
  }

  AccountUser accountUser = AccountUser();

  limparCampo() {
    setState(() {
      nome.clear();
      email.clear();
      password.clear();
      confPassword.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Visibility(
                  visible: !isLogin,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      controller: nome,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome completo',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o seu nome completo!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o e-mail correto!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha!';
                      } else if (value.length < 5) {
                        return 'Sua senha deve ter 6 caracteres no mínimo';
                      }
                      return null;
                    },
                  ),
                ),
                Visibility(
                  visible: !isLogin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: confPassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirme a senha',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha!';
                        } else if (value != password.value.text) {
                          return 'Sua senha está diferente!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        if (isLogin) {
                          User? user = accountUser.login(
                              email.value.text, password.value.text);

                          debugPrint(user.toString());
                          if (user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotesPage(
                                        user: user,
                                      )),
                            );
                            limparCampo();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Alerta!!"),
                                  content: const Text(
                                      "E-mail ou Senha inválidos. Cadastre um usuário!"),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setFormAction(!isLogin);
                                        limparCampo();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          if (!accountUser.cadastrar(
                            name: nome.value.text,
                            email: email.value.text,
                            password: password.value.text,
                          )) {
                          } else {
                            setFormAction(!isLogin);
                            limparCampo();
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            actionButtom,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggleButton),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
