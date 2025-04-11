import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:interview_app/firebase/remote_config/remote_config_key.dart';

Future<void> setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(hours: 1),
    ),
  );
  await remoteConfig.setDefaults({RemoteConfigKey.geminiKey: ''});
  await remoteConfig.fetchAndActivate();
}
