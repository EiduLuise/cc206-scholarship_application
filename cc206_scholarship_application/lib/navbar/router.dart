import 'package:cc206_scholarship_application/pages/calendar_page.dart';
import 'package:cc206_scholarship_application/pages/my_scholarships_page.dart';
import 'package:cc206_scholarship_application/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cc206_scholarship_application/navbar/layout_scaffold.dart';
import 'package:cc206_scholarship_application/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:cc206_scholarship_application/pages/notifications_page.dart';
import 'package:cc206_scholarship_application/features/log_in_page.dart'; // Import LogIn Page
import 'package:cc206_scholarship_application/features/sign_up_page.dart'; // Import SignUp Page

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// GlobalKey for pages that need to be refreshed to fetch new updated data from firebase and firestore
final GlobalKey<MyScholarshipsPageState> myScholarshipPage = GlobalKey<MyScholarshipsPageState>();
final GlobalKey<NotificationsPageState> notificationsPage = GlobalKey<NotificationsPageState>();
final GlobalKey<CalendarPageState> calendarPage = GlobalKey<CalendarPageState>();

// Routes navigator
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  // First ever screen to show is login page
  initialLocation: '/login',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return LayoutScaffold(
          navigationShell: navigationShell,
          onItemTapped: (index) {
            // Refresh specific pages to update information
            if (index == 0) { 
              calendarPage.currentState?.refreshPage();
            }
            if (index == 1) { 
              notificationsPage.currentState?.refreshPage();
            }
            if (index == 3) {
              myScholarshipPage.currentState?.refreshPage();
            }
            
          },
        );
      },
      branches: [
        // Calendar page
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              builder: (context, state) => const CalendarPage(),
            ),
          ],
        ),
        // Notifications page
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notifications',
              builder: (context, state) => NotificationsPage(key: notificationsPage),
            ),
          ],
        ),
        // Home Page page
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        // My Scholarships page
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/applied',
              builder: (context, state) => MyScholarshipPage(key: myScholarshipPage),
            ),
          ],
        ),
        // Profile page
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(), // Customize profile route
            ),
          ],
        ),
      ],
    ),
    // Login page
    GoRoute(
      path: '/login',
      builder: (context, state) => LogIn(),
    ),
    // Sign up page
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),
  ],
  redirect: (context, state) {
    // Redirect to login if no user is signed in
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.uri.toString() == '/login';

    if (!isLoggedIn && !isGoingToLogin) {
      return '/login';
    }
    if (isLoggedIn && isGoingToLogin) {
      return '/home';
    }
    return null;
  },
);
