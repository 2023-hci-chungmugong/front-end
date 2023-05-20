-keep class androidx.multidex.** { *; }
-keep class android.support.multidex.** { *; }
-keep public class YourMainApplicationClassName {
    public void attachBaseContext(android.content.Context);
}
