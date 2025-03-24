import 'package:agents_explorer/core/configs/constants/app_size.dart';
import 'package:agents_explorer/core/configs/constants/app_strings.dart';
import 'package:agents_explorer/core/configs/theme/app_colors.dart';
import 'package:agents_explorer/core/configs/theme/app_text_styles.dart' show AppTextStyles;
import 'package:agents_explorer/core/models/agents/api/agent_model.dart';
import 'package:agents_explorer/ui/widgets/custom_network_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/services/localization/localization_service.dart';
import '../../../widgets/scaffold.dart';
import '../../base_screen_view.dart';
import '../../skeletons/agent_detail_screen_skeleton.dart';
import '../../skeletons/skeleton_builder.dart';
import 'agent_detail_screen_args.dart';
import 'agent_detail_screen_controller.dart';

const double _imageHeight = 350;
const double _listViewHeight = 250;
const double _abitilityImageSize = 150;

@RoutePage<void>()
final class AgentDetailScreenView extends BaseScreenView<AgentDetailScreenController, AgentDetailScreenArgs> {
  AgentDetailScreenView({
    Key? key,
    required super.args,
  }) : super(key: key ?? UniqueKey());

  @override
  State<AgentDetailScreenView> createState() => _AgentDetailScreenViewState();
}

final class _AgentDetailScreenViewState extends BaseScreenViewState<AgentDetailScreenView, AgentDetailScreenController, AgentDetailScreenArgs> {
  @override
  CustomScaffold builder(BuildContext context, AgentDetailScreenController controller) {
    Widget image(AgentData agent) => SizedBox(
          height: _imageHeight,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomNetworkImage(
                imageUrl: agent.bustPortrait,
                fit: BoxFit.contain,
                fallbackIcon: Icons.image_not_supported,
                fallbackIconSize: AppSize.icon,
                fallbackIconColor: AppColors.primary,
              ),
            ],
          ),
        );

    Widget detail(AgentData agent) => Padding(
          padding: const EdgeInsets.all(AppSize.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(AppStrings.abilities(), context),
              const SizedBox(height: AppSize.paddingLow),
              _buildAbilitiesSection(agent.abilities ?? [], context),
              const SizedBox(height: AppSize.paddingLow),
              _buildInfoSection(AppStrings.description(), agent.description ?? '', Icons.info_outline),
              if (agent.characterTags != null && agent.characterTags!.isNotEmpty) const SizedBox(height: AppSize.padding),
              _buildCharacterTags(agent.characterTags ?? []),
              const SizedBox(height: AppSize.padding),
              _buildInfoSection(AppStrings.developer(), agent.developerName ?? '', Icons.code),
              const SizedBox(height: AppSize.padding),
              _buildInfoSection(AppStrings.releaseDate(), agent.releaseDate ?? '', Icons.calendar_today),
              const SizedBox(height: AppSize.padding),
              _buildInfoSection(AppStrings.role(), agent.role?.description ?? '', Icons.security, subTitle: agent.role?.displayName ?? ''),
            ],
          ),
        );

    Widget displayName(AgentData agent) => Positioned(
          bottom: AppSize.padding,
          left: AppSize.padding,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh, vertical: AppSize.paddingLow),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSize.paddingLow),
            ),
            child: Text(
              agent.displayName ?? '',
              style: AppTextStyles.title.call(
                color: AppColors.onPrimary,
              ),
            ),
          ),
        );

    Widget favoriteButton(AgentData agent) => Positioned(
          bottom: AppSize.padding,
          right: AppSize.padding,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSize.padding),
            ),
            child: IconButton(
              onPressed: () {
                controller.saveFavorites();
              },
              icon: Icon(
                Icons.favorite_rounded,
                size: AppSize.icon,
                color: agent.isFavorite ? AppColors.primary : AppColors.onSurfaceLow,
              ),
            ),
          ),
        );

    final Widget backButton = Positioned(
      left: AppSize.padding,
      top: AppSize.padding,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSize.padding),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: AppSize.icon,
          ),
          onPressed: () => controller.pop(),
        ),
      ),
    );

    return CustomScaffold(
      body: ViewModelBuilder<AgentDetailScreenController>.reactive(
          viewModelBuilder: () => controller,
          builder: (context, controller, child) {
            return SkeletonBuilder(
              enabled: controller.isBusy,
              skeleton: const AgentDetailScreenSkeleton(),
              builder: (BuildContext context) {
                final AgentData? agent = controller.agentDetail;

                return agent == null
                    ? const SizedBox()
                    : SafeArea(
                        child: Scaffold(
                          body: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    image(agent),
                                    displayName(agent),
                                    favoriteButton(agent),
                                    backButton,
                                  ],
                                ),
                                detail(agent),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            );
          }),
    );
  }

  Widget _buildCharacterTags(List<String> tags) {
    return Wrap(
      spacing: AppSize.paddingLow,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingHigh, vertical: AppSize.paddingLow),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSize.paddingLow),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Text(
            tag,
            style: AppTextStyles.body2_medium.call(color: AppColors.primary),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon, {String? subTitle}) {
    String formattedContent = '';

    try {
      final requestLangCode = LanguageCode.fromString(Intl.shortLocale(Intl.getCurrentLocale())).getLocale();
      DateTime dateTime = DateTime.parse(content);
      formattedContent = DateFormat.yMd(requestLangCode).add_jm().format(dateTime);
    } catch (e) {
      formattedContent = content;
    }

    return PhysicalModel(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSize.paddingLow),
        shape: BoxShape.rectangle,
        child: Container(
          padding: const EdgeInsets.all(AppSize.padding),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(AppSize.paddingLow),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.primary,
                    size: AppSize.iconHigh,
                  ),
                  const SizedBox(width: AppSize.paddingLow),
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.body3_high.call(color: AppColors.primary),
                      ),
                      if (subTitle != null && subTitle.isNotEmpty)
                        Text(
                          '- $subTitle',
                          style: AppTextStyles.body3_high.call(color: AppColors.primary),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSize.paddingLow),
              Text(
                formattedContent,
                style: AppTextStyles.body2_medium.call(color: Theme.of(context).colorScheme.onPrimary),
                maxLines: 5,
              ),
            ],
          ),
        ));
  }

  Widget _buildAbilityCard(Abilities ability, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.paddingLow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (ability.displayIcon != null)
            Container(
              alignment: Alignment.center,
              height: _abitilityImageSize,
              width: _abitilityImageSize,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSize.paddingLow),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.paddingLow),
                child: CustomNetworkImage(
                  imageUrl: ability.displayIcon,
                  fit: BoxFit.contain,
                  fallbackIcon: Icons.image_not_supported,
                  fallbackIconSize: AppSize.icon,
                  fallbackIconColor: AppColors.primary,
                ),
              ),
            ),
          const SizedBox(height: AppSize.paddingLow),
          Text(
            ability.displayName ?? '',
            style: AppTextStyles.body2_high.call(fontWeight: FontWeight.bold, color: AppColors.primary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSize.paddingLow),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLow, vertical: AppSize.paddingLowest),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.paddingLowest),
            ),
            child: Text(
              'Slot: ${ability.slot ?? ''}',
              style: AppTextStyles.body3_high.call(color: AppColors.onSurfaceLow),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.body3_high.call(color: AppColors.primary),
    );
  }

  Widget _buildAbilitiesSection(List<Abilities> abilities, BuildContext context) {
    return SizedBox(
      height: _listViewHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: abilities.length,
        itemBuilder: (context, index) {
          final ability = abilities[index];
          return Padding(
            padding: const EdgeInsets.all(AppSize.paddingLow),
            child: _buildAbilityCard(ability, context),
          );
        },
      ),
    );
  }
}
