import 'package:flutter/material.dart';
import 'package:random_quotes_generator/pages/homepage.dart';
import 'package:random_quotes_generator/pages/savedpage.dart';
import 'package:random_quotes_generator/pages/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Icon(Icons.view_agenda_outlined,
            size: 40,
          ),
          const SizedBox(height: 35),
          CustomDrawerTile(
            title: "Home",
            leading: const Icon(Icons.home,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) => const HomePage(),
                  ),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomDrawerTile(
            title: "My Quotes",
            leading: const Icon(Icons.star_border_purple500,
              size: 30,
            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) => const SavedQuotesPage(),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }
}
