import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_router.dart';
import 'package:flutter_engineer_codecheck/ui/profile_update/profile_update_view_model.dart';
import 'package:flutter_engineer_codecheck/view_model/user/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileUpdatePage extends ConsumerStatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends ConsumerState<ProfileUpdatePage> {
  @override
  void initState() {
    final user = ref.read(userViewModelProvider);
    // 更新するユーザーがいない時はホームに戻す
    // そのため、この画面ではuser!にしてもよい
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        const HomeRoute().go(context);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(profileUpdateViewModelProvider.notifier);
    final state = ref.watch(profileUpdateViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () async {
              await viewModel.updateProfile();
              if (!mounted) {
                return;
              }
              const HomeRoute().go(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  _userAvatar(state.avatarUrl, viewModel),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onChanged: viewModel.updateDisplayName,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _userAvatar(String photoUrl, ProfileUpdateViewModel viewModel) {
    const imageDiameter = 100.0;
    final borderRadius = BorderRadius.circular(imageDiameter / 2);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: photoUrl.startsWith('http')
              ? Image.network(
                  photoUrl,
                  height: imageDiameter,
                  width: imageDiameter,
                )
              : Image.file(
                  File(photoUrl),
                  height: imageDiameter,
                  width: imageDiameter,
                  fit: BoxFit.cover,
                ),
        ),
        InkWell(
          borderRadius: borderRadius,
          onTap: () {
            viewModel.pickImageFromGallery();
          },
          child: Container(
            height: imageDiameter,
            width: imageDiameter,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.black.withOpacity(0.3),
            ),
            child: const Icon(
              Icons.camera_alt,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
