import 'package:go_router/go_router.dart';
import 'package:mobile/home.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
);
