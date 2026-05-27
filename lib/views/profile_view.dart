import 'package:flutter/material.dart';
import 'package:news_app/widgets/profile/go_premium_card.dart';
import 'package:news_app/widgets/profile/interface_section.dart';
import 'package:news_app/widgets/profile/personal_info_dection.dart';
import 'package:news_app/widgets/profile/security_section.dart';
import 'package:news_app/widgets/profile/user_header_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserHeader(),
          const GoPremiumCard(),
          PersonalInfoDection(),
          SecuritySection(),
          InterfaceSection(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
