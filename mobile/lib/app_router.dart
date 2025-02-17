import 'package:go_router/go_router.dart';
import 'package:mobile/home.dart';
import 'package:mobile/trip.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/trip/:id',
      name: 'trip',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return TripPage(title: 'Trip $id');
      },
    ),
  ],
);
