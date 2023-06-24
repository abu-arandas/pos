import '/exports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(dPadding),
          child: BootstrapCol(
            sizes: 'col-lg-6 col-md-9 col-sm-12',
            child: Container(
              height: screenHeight(context) * 0.5,
              padding: EdgeInsets.all(dPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                boxShadow: [
                  BoxShadow(
                    color: white.withOpacity(0.5),
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer,
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      App.logo,

                      // Email
                      TextInputFeild(text: 'email', controller: emailController),
                      SizedBox(height: dPadding),

                      // Password
                      TextInputFeild(
                        text: 'password',
                        icon: IconButton(
                          onPressed: () => setState(() => obscureText = !obscureText),
                          icon: Icon(obscureText ? Icons.remove_red_eye : Icons.lock, color: white),
                          iconSize: 16,
                        ),
                        controller: passwordController,
                        obscureText: obscureText,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) => validate(),
                      ),
                      SizedBox(height: dPadding),

                      // Button
                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(dPadding),
                        child: ElevatedButton(
                          onPressed: () => validate(),
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => states.contains(MaterialState.hovered) ||
                                      states.contains(MaterialState.focused) ||
                                      states.contains(MaterialState.pressed)
                                  ? white
                                  : primary,
                            ),
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => states.contains(MaterialState.hovered) ||
                                      states.contains(MaterialState.focused) ||
                                      states.contains(MaterialState.pressed)
                                  ? primary
                                  : white,
                            ),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(dPadding / 2)),
                            textStyle: const MaterialStatePropertyAll(
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          child: loading
                              ? CircularProgressIndicator(color: primary)
                              : const Text('Sign In'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate() async {
    setState(() => loading = !loading);
    if (formKey.currentState!.validate()) {
      AuthController.instance
          .signIn(email: emailController.text, password: passwordController.text);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => loading = !loading);
    }
  }
}
