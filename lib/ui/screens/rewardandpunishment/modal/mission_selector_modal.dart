import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';

typedef OnMissionSelected = void Function(Mission selected);

void showPaginatedMissionSelector({
  required BuildContext context,
  required ScrollController scrollController,
  required List<Mission> missions,
  required bool isFetchingMore,
  required OnMissionSelected onSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: StatefulBuilder(builder: (context, setModalState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Pilih Misi",
                  style: blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: missions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/no_data.png',
                              width: 150.w,
                              height: 150.h,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Belum ada misi yang tersedia',
                              style: blackTextStyle.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: missions.length,
                        itemBuilder: (context, index) {
                          final mission = missions[index];
                          return GestureDetector(
                            onTap: () {
                              onSelected(mission);
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(color: lightBlueColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mission.name ?? "",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  if (mission.description != null &&
                                      mission.description!.isNotEmpty)
                                    Text(
                                      mission.description!,
                                      style: grayTextStyle.copyWith(
                                        fontSize: 13.sp,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (isFetchingMore)
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        }),
      );
    },
  );
}
