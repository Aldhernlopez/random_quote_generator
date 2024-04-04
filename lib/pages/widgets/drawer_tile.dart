import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawerTile extends StatelessWidget {
  const CustomDrawerTile({
    super.key,
    required this.title,
    required this.leading,
    this.onTap,
  });

  final String title;
  final Widget leading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
        style: GoogleFonts.poppins(
          fontSize: 20
        ),
      ),
      leading: leading,
      onTap: onTap,
    );
  }
}
