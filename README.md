# Music Player - Flutter
#### Flutter music player application which is my personal project published to play store. Project structures are as following,
<pre>
     lib--                                        App Features:
         |                                           - Vintage ui
         |__core                                     - Shuffle and play random song
                |__cache                             - Volume controller (Thanks for cihatislamdede)  
                     |__app_shared_pref.dart
                |__components
                     |__circulat_button_atom.dart
                |__constants
                     |__asset_constants.dart
                     |__color_constants.dart
                     |__string_constants.dart
                |__extension
                     |__size_extension.dart
                
         |__utils                           
                |__helper_functions.dart
                |__audio_process_notifier.dart
         |__viewmodel
                |__song_view_model.dart
         |__views
                |__control_panel_screen.dart
                |__home_screen.dart
         |__widgets
                |__album_widget.dart
                |__app_text.dart
                |__next_song_button_widget.dart
                |__pause_button_widget.dart
                |__play_button_widget.dart
                |__previous_button_widget.dart
                |__song_listview_widget.dart
                |__volume_control_widget.dart
         main.dart
</pre><br>

#### Which packages used?<br>
 * on_audio_query
 * just_audio
 * shared_preferences
 * provider
 * volume_controller
 * audio_video_progress_bar <br><br>

<img src="https://github.com/SamedHrmn/music-player-flutter/assets/60006881/69e48545-28ad-48a3-a722-9a949079c337" width="30%"></img> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://github.com/SamedHrmn/music-player-flutter/assets/60006881/c80e5908-8356-46aa-8333-54dae22a78bf" width="30%">;

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
