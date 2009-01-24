Version history:

3.0.3
-----
- fixed cuepoint firing: Does not skip cuepoints any more
- Plugins can now be loaded from a different domain to the flowplayer.swf
- Specifying a clip to play by just using the 'clip' node in the configuration was not working, a playlist definition was required. This is now fixed.
- Fixed: A playlist with different providers caused the onMetadata event to fire events with metadata from the previous clip in the playlist. Occurred when moving in the playlist with next() and prev()
- the opacity setting now works with the logo
- fadeOut() call to the "screen" plugin was sending the listenerId and pluginName arguments in wrong order
- stop(), pause(), resume(), close() no longer return the flowplayer object to JS
- changing the size of the screen in a onFullscreen listener now always works, there was a bug that caused this to fail occasionally
- fixed using arbitrary SWFs as plugins
- the API method setPlaylist() no longer starts playing if autoPlay: true, neither it starts buffering if autoBuffering: true
- the API method play() now accepts an array of clip objects as an argument, the playlist is replaced with the specified clips and playback starts from the 1st clip

3.0.2
-----
- setting play: null now works again
- pressing the play again button overlay does not open a linkUrl associated with a clip
- now displays a live feed even when the RTMP server does not send any metadata and the onStart method is not therefore dispatched
- added onMetaData clip event
- fixed 'orig' scaling: the player went to 'fit' scaling after coming back from fullscreen. This is now fixed and the original dimensions are preserved in non-fullscreen mode.
- cuepoint times are now given in milliseconds, the firing precision is 100 ms. All cuepoint times are rounded to the nearest 100 ms value (for example 1120 rounds to 1100) 
- backgroundGradient was drawn over the background image in the canvas and in the content and controlbar plugins. Now it's drawn below the image.
- added cuepointMultiplier property to clips. This can be used to multiply the time values read from cuepoint metadata embedded into video files.
- the player's framerate was increased to 24 FPS, makes all animations smoother

3.0.1
-----
- Fixed negative cuepoints from common clip. Now these are properly propagated to the clips in playlist.
- buffering animation is now the same size as the play button overlay
- commercial version now supports license keys that allows the use of subdomains
- error messages are now automatically hidden after a 4 second delay. They are also hidden when a new clips
  starts playing (when onBeforeBegin is fired)
- added possibility to disable the buffering animation like so: buffering: false
- pressing the play button overlay does not open a linkUrl associated with a clip
- license key verification failed if a port number was used in the URL (like in this url: http://mydomain.com:8080/video.html)
- added audio support, clip has a new "image" property
- workaround for missing "NetStream.Play.Start" notfication that was happending with Red5. Because of this issue the video was not shown.
- commercial version has the possibility to change the zIndex of the logo

3.0.0
-----
- Removed security errors that happened when loading images from foreign domains (domains other than the domain of the core SWF).
  Using a backgroundImage on canvas, in the content plugin, and for the controls is also possible to be loaded
  from a foreign domain - BUT backgroundRepeat cannot be used for foreign images.
- Now allows the embedding HTML to script the player even if the player is loaded from another domain.
- Added a 'live' property to Clips, used for live streams.
- A player embedded to a foreign domain now loads images, css files and other resources from the domain where the palyer SWF was loaded from. This is to generate shorter embed-codes.
- Added linkUrl and linkWindow properties to the logo, in commercial version you can set these to point to a linked page. The linked page gets opened
  when the logo is clicked.  Possible values for linkWindow:
    * "_self" specifies the current frame in the current window.
    * "_blank" specifies a new window.
    * "_parent" specifies the parent of the current frame.
    * "_top" specifies the top-level frame in the current window.
- Added linkUrl and linkWindow properties to clips. The linked page is opened when the video are is clicked and the corresponding clip has a linkUrl specified.
- Made the play button overlay and the "Play again" button slightly bigger.

RC4
---
- Now shows a "Play again" button at the end of the video/playlist
- Commercial version shows a Flowplayer logo if invalidKey was supplied, but the otherwise the player works
- setting play: null in configuration will disable the play button overlay
- setting opacity for "play" also sets it for the buffering animation
- Fixed firing of cuepoints too early. Cuepoint firing is now based on stream time and does not rely on timers
- added onXMPData event listener
- Should not stop playback too early before the clip is really completed
- The START event is now delayed so that the metadata is available when the event is fired, METADATA event was removed,
  new event BEGIN that is dispatched when the playback has been successfully started. Metadata is not normally
  available when BEGIN is fired. 

RC3
---
- stopBuffering() now dispatches the onStop event first if the player is playing/paused/buffering at the time of calling it
- fixed detection of images based on file extensions
- fixed some issues with having images in the playlist
- made it possible to autoBuffer next video while showing an image (image without a duration)

RC2
---
- fixed: setting the screen height in configuration did not have any effect

RC1
-----
- better error message if plugin loading fails, shows the URL used
- validates our redesigned multidomain license key correctly
- fix to prevent the play button going visible when the onBufferEmpty event occurs
- the commercial swf now correctly loads the controls using version information
- fixed: the play button overlay became invisible with long fadeOutSpeeds

beta6
-----
- removed the onFirstFramePause event
- playing a clip for the second time caused a doubled sound
- pausing on first frame did not work on some FLV files

beta5
-----
- logo only uses percentage scaling if it's a SWF file (there is ".swf" in it's url)
- context menu now correctly builds up from string entries in configuration
-always closes the previous connection before starting a new clip

beta4
-----
- now it's possible to load a plugin into the panel without specifying any position/dimensions
 information, the plugin is placed to left: "50%", top: "50%" and using the plugin DisplayObject's width & height
- The Flowplayer API was not fully initialized when onLoad was invoked on Flash plugins

beta3
-----
- tweaking logo placement
- "play" did not show up after repeated pause/resume
- player now loads the latest controls SWF version, right now the latest SWF is called 'flowplayer.controls-3.0.0-beta2.swf'

beta2
-----
- fixed support for RTMP stream groups
- changed to loop through available fonts in order to find a suitable font also in IE
- Preloader was broken on IE: When the player SWf was in browser's cache it did not initialize properly
- Context menu now correctly handles menu items that are configured by their string labels only (not using json objects)
- fixed custom logo positioning (was moved to the left edge of screen in fullscreen)
- "play" now always follows the position and size of the screen
- video was stretched below the controls in fullscreen when autoHide: 'never'
- logo now takes 6.5% of the screen height, width is scaled so that the aspect ratio is preserved

beta1
-----
- First public beta release
