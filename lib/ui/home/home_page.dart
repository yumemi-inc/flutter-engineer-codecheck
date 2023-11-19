import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/profile/profile_page.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_search_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final destinations = const [
    Destination(
      page: RepoSearchPage(),
      navigationDestination:
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    ),
    Destination(
      page: ProfilePage(),
      navigationDestination:
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    ),
  ];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: destinations[currentPageIndex].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        destinations: destinations.map((e) => e.navigationDestination).toList(),
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}

class Destination {
  const Destination({
    required this.page,
    required this.navigationDestination,
  });
  final Widget page;
  final NavigationDestination navigationDestination;
}
