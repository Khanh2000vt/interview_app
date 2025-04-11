import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:interview_app/firebase/remote_config/remote_config_key.dart';

class RemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;
  String getGeminiKey() {
    return remoteConfig.getString(RemoteConfigKey.geminiKey);
  }
}
