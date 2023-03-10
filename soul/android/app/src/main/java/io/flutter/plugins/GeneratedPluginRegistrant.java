package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    flutterEngine.getPlugins().add(new com.ryanheise.audio_session.AudioSessionPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin());
      io.flutter.plugins.firebase.functions.FlutterFirebaseFunctionsPlugin.registerWith(shimPluginRegistry.registrarFor("io.flutter.plugins.firebase.functions.FlutterFirebaseFunctionsPlugin"));
    flutterEngine.getPlugins().add(new com.mr.flutter.plugin.filepicker.FilePickerPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin());
      com.roughike.facebooklogin.facebooklogin.FacebookLoginPlugin.registerWith(shimPluginRegistry.registrarFor("com.roughike.facebooklogin.facebooklogin.FacebookLoginPlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.googlesignin.GoogleSignInPlugin());
    flutterEngine.getPlugins().add(new com.ryanheise.just_audio.JustAudioPlugin());
    flutterEngine.getPlugins().add(new com.homex.open_mail_app.OpenMailAppPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
  }
}
