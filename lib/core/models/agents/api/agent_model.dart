import 'package:agents_explorer/core/models/base_model.dart';

final class AgentModel extends BaseModel {
  final int? status;
  final List<AgentData>? data;

  AgentModel._({
    this.status,
    this.data,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel._(
      status: json['status'] as int?,
      data: json['data'] != null ? (json['data'] as List).map((e) => AgentData.fromJson(e as Map<String, dynamic>)).toList() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data?.map((e) => e.toMap()).toList(),
    };
  }
}

final class FavoriteModel extends BaseModel {
  final String? title;
  final String? description;

  FavoriteModel({
    this.title,
    this.description,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}

final class AgentData extends BaseModel {
  final String? uuid;
  final String? displayName;
  final String? description;
  final String? developerName;
  final String? releaseDate;
  final List<String>? characterTags;
  final String? displayIcon;
  final String? displayIconSmall;
  final String? bustPortrait;
  final String? fullPortrait;
  final String? fullPortraitV2;
  final String? killfeedPortrait;
  final String? background;
  final List<String>? backgroundGradientColors;
  final String? assetPath;
  final bool? isFullPortraitRightFacing;
  final bool? isPlayableCharacter;
  final bool? isAvailableForTest;
  final bool? isBaseContent;
  final Role? role;
  final RecruitmentData? recruitmentData;
  final List<Abilities>? abilities;
  final String? voiceLine;
  final bool isFavorite;
  final FavoriteModel? favoriteModel;

  const AgentData._({
    this.uuid,
    this.displayName,
    this.description,
    this.developerName,
    this.releaseDate,
    this.characterTags,
    this.displayIcon,
    this.displayIconSmall,
    this.bustPortrait,
    this.fullPortrait,
    this.fullPortraitV2,
    this.killfeedPortrait,
    this.background,
    this.backgroundGradientColors,
    this.assetPath,
    this.isFullPortraitRightFacing,
    this.isPlayableCharacter,
    this.isAvailableForTest,
    this.isBaseContent,
    this.role,
    this.recruitmentData,
    this.abilities,
    this.voiceLine,
    this.isFavorite = false,
    this.favoriteModel,
  });

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData._(
      uuid: json['uuid'] as String?,
      displayName: json['displayName'] as String?,
      description: json['description'] as String?,
      developerName: json['developerName'] as String?,
      releaseDate: json['releaseDate'] as String?,
      characterTags: (json['characterTags'] as List<dynamic>?)?.map((tag) => tag.toString()).toList(),
      displayIcon: json['displayIcon'] as String?,
      displayIconSmall: json['displayIconSmall'] as String?,
      bustPortrait: json['bustPortrait'] as String?,
      fullPortrait: json['fullPortrait'] as String?,
      fullPortraitV2: json['fullPortraitV2'] as String?,
      killfeedPortrait: json['killfeedPortrait'] as String?,
      background: json['background'] as String?,
      backgroundGradientColors: (json['backgroundGradientColors'] as List<dynamic>?)?.map((color) => color.toString()).toList(),
      assetPath: json['assetPath'] as String?,
      isFullPortraitRightFacing: json['isFullPortraitRightFacing'] as bool?,
      isPlayableCharacter: json['isPlayableCharacter'] as bool?,
      isAvailableForTest: json['isAvailableForTest'] as bool?,
      isBaseContent: json['isBaseContent'] as bool?,
      role: json['role'] != null ? Role.fromJson(json['role'] as Map<String, dynamic>) : null,
      recruitmentData: json['recruitmentData'] != null ? RecruitmentData.fromJson(json['recruitmentData'] as Map<String, dynamic>) : null,
      abilities: json['abilities'] != null ? (json['abilities'] as List).map((e) => Abilities.fromJson(e as Map<String, dynamic>)).toList() : null,
      voiceLine: json['voiceLine'] as String?,
      favoriteModel: json['favoriteModel'] != null ? FavoriteModel.fromJson(json['favoriteModel'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'displayName': displayName,
      'description': description,
      'developerName': developerName,
      'releaseDate': releaseDate,
      'characterTags': characterTags,
      'displayIcon': displayIcon,
      'displayIconSmall': displayIconSmall,
      'bustPortrait': bustPortrait,
      'fullPortrait': fullPortrait,
      'fullPortraitV2': fullPortraitV2,
      'killfeedPortrait': killfeedPortrait,
      'background': background,
      'backgroundGradientColors': backgroundGradientColors,
      'assetPath': assetPath,
      'isFullPortraitRightFacing': isFullPortraitRightFacing,
      'isPlayableCharacter': isPlayableCharacter,
      'isAvailableForTest': isAvailableForTest,
      'isBaseContent': isBaseContent,
      'role': role?.toMap(),
      'recruitmentData': recruitmentData?.toMap(),
      'abilities': abilities?.map((ability) => ability.toMap()).toList(),
      'voiceLine': voiceLine,
      'isFavorite': isFavorite,
      'favoriteModel': favoriteModel?.toMap(),
    };
  }

  AgentData copyWith({
    bool? isFavorite,
    FavoriteModel? favoriteModel,
  }) {
    return AgentData._(
      uuid: uuid,
      displayName: displayName,
      description: description,
      developerName: developerName,
      releaseDate: releaseDate,
      characterTags: characterTags,
      displayIcon: displayIcon,
      displayIconSmall: displayIconSmall,
      bustPortrait: bustPortrait,
      fullPortrait: fullPortrait,
      fullPortraitV2: fullPortraitV2,
      killfeedPortrait: killfeedPortrait,
      background: background,
      backgroundGradientColors: backgroundGradientColors,
      assetPath: assetPath,
      isFullPortraitRightFacing: isFullPortraitRightFacing,
      isPlayableCharacter: isPlayableCharacter,
      isAvailableForTest: isAvailableForTest,
      isBaseContent: isBaseContent,
      role: role,
      recruitmentData: recruitmentData,
      abilities: abilities,
      voiceLine: voiceLine,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteModel: favoriteModel ?? this.favoriteModel,
    );
  }
}

final class Role extends BaseModel {
  final String? uuid;
  final String? displayName;
  final String? description;
  final String? displayIcon;
  final String? assetPath;

  const Role._({
    this.uuid,
    this.displayName,
    this.description,
    this.displayIcon,
    this.assetPath,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role._(
      uuid: json['uuid'] as String?,
      displayName: json['displayName'] as String?,
      description: json['description'] as String?,
      displayIcon: json['displayIcon'] as String?,
      assetPath: json['assetPath'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'displayName': displayName,
      'description': description,
      'displayIcon': displayIcon,
      'assetPath': assetPath,
    };
  }
}

final class RecruitmentData extends BaseModel {
  final String? counterId;
  final String? milestoneId;
  final int? milestoneThreshold;
  final bool? useLevelVpCostOverride;
  final int? levelVpCostOverride;
  final String? startDate;
  final String? endDate;

  const RecruitmentData._({
    this.counterId,
    this.milestoneId,
    this.milestoneThreshold,
    this.useLevelVpCostOverride,
    this.levelVpCostOverride,
    this.startDate,
    this.endDate,
  });

  factory RecruitmentData.fromJson(Map<String, dynamic> json) {
    return RecruitmentData._(
      counterId: json['counterId'] as String?,
      milestoneId: json['milestoneId'] as String?,
      milestoneThreshold: json['milestoneThreshold'] as int?,
      useLevelVpCostOverride: json['useLevelVpCostOverride'] as bool?,
      levelVpCostOverride: json['levelVpCostOverride'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'counterId': counterId,
      'milestoneId': milestoneId,
      'milestoneThreshold': milestoneThreshold,
      'useLevelVpCostOverride': useLevelVpCostOverride,
      'levelVpCostOverride': levelVpCostOverride,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

final class Abilities extends BaseModel {
  final String? slot;
  final String? displayName;
  final String? description;
  final String? displayIcon;

  const Abilities._({
    this.slot,
    this.displayName,
    this.description,
    this.displayIcon,
  });

  factory Abilities.fromJson(Map<String, dynamic> json) {
    return Abilities._(
      slot: json['slot'] as String?,
      displayName: json['displayName'] as String?,
      description: json['description'] as String?,
      displayIcon: json['displayIcon'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slot': slot,
      'displayName': displayName,
      'description': description,
      'displayIcon': displayIcon,
    };
  }
}
