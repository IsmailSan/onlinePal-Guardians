import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class AppUsageProgressRow extends StatelessWidget {
  final String title;
  final List<double> progressValues;
  final List<String> timeLabels;

  const AppUsageProgressRow({
    Key? key,
    required this.title,
    required this.progressValues,
    required this.timeLabels,
  })  : assert(progressValues.length == 3),
        assert(timeLabels.length == 3),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                  fontSize: 10.sp, fontWeight: bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          ...List.generate(3, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progressValues[index].clamp(0.0, 1.0),
                          backgroundColor: Colors.white,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFD6DDFF),
                          ),
                          minHeight: 26,
                        ),
                      ),
                    ),
                    Text(
                      timeLabels[index],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
