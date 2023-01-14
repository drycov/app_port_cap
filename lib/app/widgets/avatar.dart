import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:tiny_avatar/tiny_avatar.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final bool useLetterAvatar;
  final Shape shape;
  final double dimension;
  final bool female;

  const AvatarWidget(
      {super.key,
      this.shape = Shape.Circular,
      this.dimension = 24,
      this.avatarUrl = '',
      this.userName = '',
      this.firstName = '',
      this.lastName = '',
      this.useLetterAvatar = false,
      this.female = false});

  @override
  Widget build(BuildContext context) {
    final String? userNameToDisplay =
        userName!.isEmpty ? '$firstName $lastName' : userName;

// print(backgroundColorHex); // #FFFF0000
    if (avatarUrl!.isEmpty) {
      if (useLetterAvatar) {
        return TinyAvatar(
          baseString: userNameToDisplay.toString(),
          dimension: dimension,
          circular: true,
        );
      } else {
        if (female) {
          return const Image(
              image: AssetImage('assets/images/avatars/female.png'));
        } else {
          return const Image(
              image: AssetImage("assets/images/avatars/default.png"));
        }
      }
    }
    // Если URL аватара не указан, используем виджет Letter Avatar

    // Иначе, загружаем аватар с сервера с помощью CachedNetworkImage
    return CachedNetworkImage(
      imageUrl: avatarUrl.toString(),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
