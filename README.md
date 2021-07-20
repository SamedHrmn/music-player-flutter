# music-player-flutter
#### Flutter music player application which is my personal project published to play store. Project structures are as following,
<pre>
     lib--                                        App Features:
         |                                           - Dynamic theme and save with Shared Preferences
         |__core                                     - Shuffle and play random song
                |__cache                             - Volume controller (Thanks for cihatislamdede)  
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
 * volume_controller
 * audio_video_progress_bar <br><br>

<img src="https://user-images.githubusercontent.com/60006881/125201500-220a8600-e278-11eb-86fa-eeda6447af99.png" width="30%"></img> &nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/60006881/125139487-47cd4900-e119-11eb-907a-5118d5ec1a18.png" width="30%"> &nbsp;&nbsp;  <img src="https://user-images.githubusercontent.com/60006881/125139817-e6f24080-e119-11eb-944c-338c9f558f87.png" width="30%"><br><br>

<h3> Licence </h3>
MIT License

Copyright (c) 2021 SamedHrmn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
