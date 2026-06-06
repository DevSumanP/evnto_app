# --- Flutter engine & embedding -------------------------------------------
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# --- Play Core / deferred components --------------------------------------
# Flutter's embedding references Play Core split-install classes that may not
# be on the classpath; suppress the missing-class warnings R8 would error on.
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# --- Annotations & generic signatures (needed by some JSON/reflection libs)-
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable