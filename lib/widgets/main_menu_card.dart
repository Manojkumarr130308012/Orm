import 'package:dms_dealers/router.dart';
import 'package:dms_dealers/utils/image_resources.dart';
import 'package:flutter/material.dart';


class MainMenuCard extends StatelessWidget {
  final String img;

  final String title;
  final String subTitle;
  final bool isProfile;
  final bool isDrawer;
  const MainMenuCard({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
    this.isProfile = false,
    this.isDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Padding(
      padding: const EdgeInsets.only(left: 10),
      child: img.isNotEmpty
          ? FadeInImage.assetNetwork(
        placeholder: ImageResource.vehicle1, // Path to your placeholder image
        image: img,
        height: 50,
        width: 80,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImageResource.vehicle1,
            height: 50,
            width: 80,
          ); // Show placeholder image on error
        },
        fit: BoxFit.cover,
      )
          : Image.asset(
        ImageResource.vehicle1,
        height: 50,
        width: 80,
      ), // Show placeholder image if img is null or empty
    ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                subTitle,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          isProfile
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.profile_details);
                    },
                    child: const Text(
                      'View',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ),
                )
              : isDrawer
                  ? IconButton(
                      onPressed: () {}, icon: const Icon(Icons.navigate_next))
                  : Container()
        ],
      ),
    );
  }
}
