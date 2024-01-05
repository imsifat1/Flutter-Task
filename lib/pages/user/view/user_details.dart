import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../barrel/model.dart';
import '../../../route/route_manager.dart';

class UserDetails extends StatelessWidget {
  UserDetails({super.key, required this.user});
  User user;
  bool _isUpdated = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, _isUpdated);
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.of(context)
                    .pushNamed(RouteManager.editUser, arguments: user);

                if (result != null) {
                  _isUpdated = true;
                  user = result as User;
                }
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: user.profilepicture ?? '',
                    height: 60,
                    width: 60,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Text(user.name ?? ''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Email Address: ${user.email}'),
              const SizedBox(
                height: 10,
              ),
              Text('User Location: ${user.location}'),
              const SizedBox(
                height: 10,
              ),
              Text('Account created: ${user.createdat}'),
            ],
          ),
        ),
      ),
    );
  }
}
