abstract final class ApiPaths {
  static const String servicePath = 'https://valorant-api.com/v1';

  static const String agents = '/agents';
  static const String agentsDetail = '/agents/:uuid';
  static const String agentsPlayable = '/agents?isPlayableCharacter=true';
}
