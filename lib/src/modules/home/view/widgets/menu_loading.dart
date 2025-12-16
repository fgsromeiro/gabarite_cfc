import '../../../../shared/export/app_export.dart';

class MenuLoading extends StatelessWidget {
  const MenuLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppInsets.lg),
      decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: context.colorScheme.onSecondaryFixedVariant,
            width: 1,
          )),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: context.sz.height * 0.1,
                width: double.infinity,
                child: Row(
                  spacing: AppSpacing.med,
                  children: [
                    ContainerPlaceholder(width: context.sz.width * 0.0415),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContainerPlaceholder(
                            width: double.infinity,
                            height: context.sz.height * 0.02,
                          ),
                          ContainerPlaceholder(
                            width: double.infinity,
                            height: context.sz.height * 0.02,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                ContainerPlaceholder(
                  width: double.infinity,
                  height: context.sz.height * 0.12,
                ),
                ContainerPlaceholder(
                  width: double.infinity,
                  height: context.sz.height * 0.12,
                ),
                ContainerPlaceholder(
                  width: double.infinity,
                  height: context.sz.height * 0.12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
