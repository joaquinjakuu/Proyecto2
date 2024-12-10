import 'package:go_router/go_router.dart';
import 'package:myapp/screen/codigoqr_screen.dart';
import 'package:myapp/screen/configdoc_screen.dart';
import 'package:myapp/screen/configuracionuser_screen.dart';
import 'package:myapp/screen/eligerol_screen.dart';
import 'package:myapp/screen/esperadoc_screen.dart';
import 'package:myapp/screen/formulariousuario_screen.dart';
import 'package:myapp/screen/home_screen.dart';
import 'package:myapp/screen/infoapp_screen.dart';
import 'package:myapp/screen/infoappdoc_screen.dart';
import 'package:myapp/screen/login_screen.dart';
import 'package:myapp/screen/qrinicial_screen.dart';
import 'package:myapp/screen/registro_screen.dart';
import 'package:myapp/screen/registrodoctor_screen.dart';
import 'package:myapp/entities/user.dart'; // Importa la clase User
import 'package:myapp/entities/fichamedica.dart'; // Importa la clase FichaMedica

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: QrInicialScreen.name,
      path: '/',
      builder: (context, state) => QrInicialScreen(),
    ),
    GoRoute(
      name: LoginScreen.name,
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: EligeRol.name,
      path: '/eligerol',
      builder: (context, state) => EligeRol(),
    ),
    GoRoute(
      name: RegisterScreen.name,
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      name: FormularioScreen.name,
      path: '/formulariousuario',
      builder: (context, state) => FormularioScreen(),
    ),
    GoRoute(
      name: RegisterDocScreen.name,
      path: '/registerDoc',
      builder: (context, state) => RegisterDocScreen(),
    ),
    GoRoute(
      name: CodigoQrScreen.name,
      path: '/codigoQr',
      builder: (context, state) => CodigoQrScreen(),
    ),
    GoRoute(
      name: ConfiguracionUser.name,
      path: '/configuracionuser',
      builder: (context, state) => ConfiguracionUser(),
    ),
    GoRoute(
      name: ConfiguracionDoc.name,
      path: '/configdoc',
      builder: (context, state) => ConfiguracionDoc(),
    ),
    GoRoute(
      name: InfoAppScreen.name,
      path: '/infoapp',
      builder: (context, state) => InfoAppScreen(),
    ),
    GoRoute(
      name: InfoAppDocScreen.name,
      path: '/infoappdoc',
      builder: (context, state) => InfoAppDocScreen(),
    ),
    GoRoute(
      name: EsperaDocScreen.name,
      path: '/esperadoc',
      builder: (context, state) => EsperaDocScreen(),
    ),
  ],
);
