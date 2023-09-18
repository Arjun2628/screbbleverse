import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:scribbleverse/domain/provider/daily_quotes/daily_quotes_provider.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/books/screens/view_books.dart';
import 'package:scribbleverse/presentation/views/daily_quotes/screens/view_daily_quotes.dart';
import 'package:scribbleverse/presentation/views/home/widgets/daily_quotes_section.dart';
import 'package:scribbleverse/presentation/views/home/widgets/main_home_section.dart';
import 'package:scribbleverse/presentation/views/profile/screens/view_other_user_profile.dart';
import 'package:scribbleverse/presentation/widgets/public_widgets/home_bar.dart';
import 'package:scribbleverse/presentation/widgets/public_widgets/main_background.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/home/daily_quotes_skeleton.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/home/home_page.skeleton.dart';
import '../../../../config/theams/fonts.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [
        MainBackground(),
        Column(
          children: [
            DailyQuotesSection(),
            HomeBar(
              index: 0,
            ),
            MainHomeSection(),
          ],
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 2'),
    );
  }
}
