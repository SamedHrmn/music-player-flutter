# music-player-flutter
#### Flutter music player application which is my personal project published to play store. Project structures as following,
<pre>
     lib--                                        App Features:
         |                                           - Dynamic theme and save with Shared Preferences
         |__core                                     - Shuffle and Play Random Song
                |__cache
                     |__app_shared_pref.dart
                |__components
                     |__circulat_button_atom.dart
                |__constants
                     |__asset_constants.dart
                     |__size_constants.dart
                |__extension
                     |__size_extension.dart
                |__init
                     |__notifier
                           |__audio_process_notifier.dart
                           |__theme_notifier.dart
                     |__theme
                           |__app_theme_dark.dart
                           |__app_theme_light.dart
                           |__app_theme.dart
         |__utils                           
                |__helper_functions.dart
         |__viewmodel
                |__song_view_model.dart
         |__views
                |__control_panel_screen.dart
                |__home_screen.dart
         |__widgets
                |__album_widget.dart
                |__blur_widget.dart
                |__custom_appbar_widget.dart
                |__custom_avatar_widget.dart
                |__next_song_button_widget.dart
                |__pause_button_widget.dart
                |__play_button_widget.dart
                |__previous_button_widget.dart
                |__song_listview_widget.dart
         main.dart
</pre><br>

#### Which packages used?<br>
 * flutter_audio_query
 * just_audio
 * shared_preferences
 * provider
 * audio_video_progress_bar <br><br>

<img src="https://user-images.githubusercontent.com/60006881/125139402-2704f380-e119-11eb-9802-670d23e2e5d2.png" width="300px"></img> &nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/60006881/125139487-47cd4900-e119-11eb-907a-5118d5ec1a18.png" width="300px"> &nbsp;&nbsp;  <img src="https://user-images.githubusercontent.com/60006881/125139817-e6f24080-e119-11eb-944c-338c9f558f87.png" width="300px"><br><br>


