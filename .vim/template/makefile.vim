" vim autocommand file for makefiles
:insert
DEBUG					= #-g
CC            = gcc
CXX           = g++
DEFINES       = 
CFLAGS        = -Wall -W
CXXFLAGS      = -Wall -Wno-write-strings -Wno-narrowing -Wno-delete-non-virtual-dtor
INCPATH       = -I/usr/include 
LINK          = g++
LFLAGS        = 
LIBS          = -lm -lX11 -lXrender 
RANLIB        = 
DEL_FILE      = rm -f
SOURCES       = main.cpp 
OBJECTS       = main.o 
TARGET        = main

first: all

all: $(TARGET)

$(TARGET):  $(OBJECTS)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)

main.o: main.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o main.o main.cpp

clean:
	$(DEL_FILE) *.o $(TARGET)

run:
	./$(TARGET)

strip:
	$(CXX) -x cpp -dD -E -fpreprocessed $(SOURCES)

#=============================================================================
#`pkg-config --cflags --libs alsa`
#`pkg-config --cflags --libs atk`
#`pkg-config --cflags --libs atk-bridge-2.0`
#`pkg-config --cflags --libs atkmm-1.6`
#`pkg-config --cflags --libs banshee-collection-indexer`
#`pkg-config --cflags --libs banshee-core`
#`pkg-config --cflags --libs banshee-hyena`
#`pkg-config --cflags --libs banshee-hyena-data-sqlite`
#`pkg-config --cflags --libs banshee-hyena-gui`
#`pkg-config --cflags --libs banshee-lastfm`
#`pkg-config --cflags --libs banshee-lastfm-gui`
#`pkg-config --cflags --libs banshee-mono-media`
#`pkg-config --cflags --libs banshee-musicbrainz`
#`pkg-config --cflags --libs banshee-nowplaying`
#`pkg-config --cflags --libs banshee-services`
#`pkg-config --cflags --libs banshee-thickclient`
#`pkg-config --cflags --libs banshee-webbrowser`
#`pkg-config --cflags --libs bash-completion`
#`pkg-config --cflags --libs bigreqsproto`
#`pkg-config --cflags --libs cairo`
#`pkg-config --cflags --libs cairo-fc`
#`pkg-config --cflags --libs cairo-ft`
#`pkg-config --cflags --libs cairo-gobject`
#`pkg-config --cflags --libs cairomm-1.0`
#`pkg-config --cflags --libs cairomm-ft-1.0`
#`pkg-config --cflags --libs cairomm-pdf-1.0`
#`pkg-config --cflags --libs cairomm-png-1.0`
#`pkg-config --cflags --libs cairomm-ps-1.0`
#`pkg-config --cflags --libs cairomm-svg-1.0`
#`pkg-config --cflags --libs cairomm-xlib-1.0`
#`pkg-config --cflags --libs cairomm-xlib-xrender-1.0`
#`pkg-config --cflags --libs cairo-pdf`
#`pkg-config --cflags --libs cairo-png`
#`pkg-config --cflags --libs cairo-ps`
#`pkg-config --cflags --libs cairo-script`
#`pkg-config --cflags --libs cairo-svg`
#`pkg-config --cflags --libs cairo-tee`
#`pkg-config --cflags --libs cairo-xcb`
#`pkg-config --cflags --libs cairo-xcb-shm`
#`pkg-config --cflags --libs cairo-xlib`
#`pkg-config --cflags --libs cairo-xlib-xrender`
#`pkg-config --cflags --libs cally-1.0`
#`pkg-config --cflags --libs clutter-1.0`
#`pkg-config --cflags --libs clutter-cogl-1.0`
#`pkg-config --cflags --libs clutter-gdk-1.0`
#`pkg-config --cflags --libs clutter-glx-1.0`
#`pkg-config --cflags --libs clutter-x11-1.0`
#`pkg-config --cflags --libs cogl-1.0`
#`pkg-config --cflags --libs cogl-2.0-experimental`
#`pkg-config --cflags --libs cogl-gl-1.0`
#`pkg-config --cflags --libs cogl-pango-1.0`
#`pkg-config --cflags --libs cogl-pango-2.0-experimental`
#`pkg-config --cflags --libs compositeproto`
#`pkg-config --cflags --libs damageproto`
#`pkg-config --cflags --libs dbus-1`
#`pkg-config --cflags --libs dbus-python`
#`pkg-config --cflags --libs ++dfb`
#`pkg-config --cflags --libs dfbegl`
#`pkg-config --cflags --libs direct`
#`pkg-config --cflags --libs directfb`
#`pkg-config --cflags --libs directfb-internal`
#`pkg-config --cflags --libs dmx`
#`pkg-config --cflags --libs dmxproto`
#`pkg-config --cflags --libs dri2proto`
#`pkg-config --cflags --libs dri3proto`
#`pkg-config --cflags --libs dri`
#`pkg-config --cflags --libs egl`
#`pkg-config --cflags --libs expat`
#`pkg-config --cflags --libs fixesproto`
#`pkg-config --cflags --libs fontconfig`
#`pkg-config --cflags --libs fontenc`
#`pkg-config --cflags --libs fontsproto`
#`pkg-config --cflags --libs fontutil`
#`pkg-config --cflags --libs form`
#`pkg-config --cflags --libs freetype2`
#`pkg-config --cflags --libs fusion`
#`pkg-config --cflags --libs gbm`
#`pkg-config --cflags --libs gdk-2.0`
#`pkg-config --cflags --libs gdk-3.0`
#`pkg-config --cflags --libs gdkglext-1.0`
#`pkg-config --cflags --libs gdkglextmm-1.2`
#`pkg-config --cflags --libs gdkglextmm-x11-1.2`
#`pkg-config --cflags --libs gdkglext-x11-1.0`
#`pkg-config --cflags --libs gdkmm-2.4`
#`pkg-config --cflags --libs gdkmm-3.0`
#`pkg-config --cflags --libs gdk-pixbuf-2.0`
#`pkg-config --cflags --libs gdk-pixbuf-xlib-2.0`
#`pkg-config --cflags --libs gdk-wayland-3.0`
#`pkg-config --cflags --libs gdk-x11-2.0`
#`pkg-config --cflags --libs gdk-x11-3.0`
#`pkg-config --cflags --libs gio-2.0`
#`pkg-config --cflags --libs giomm-2.4`
#`pkg-config --cflags --libs gio-unix-2.0`
#`pkg-config --cflags --libs glesv2`
#`pkg-config --cflags --libs glew`
#`pkg-config --cflags --libs gl`
#`pkg-config --cflags --libs glib-2.0`
#`pkg-config --cflags --libs glibmm-2.4`
#`pkg-config --cflags --libs glproto`
#`pkg-config --cflags --libs glu`
#`pkg-config --cflags --libs gmodule-2.0`
#`pkg-config --cflags --libs gmodule-export-2.0`
#`pkg-config --cflags --libs gmodule-no-export-2.0`
#`pkg-config --cflags --libs gnome-icon-theme`
#`pkg-config --cflags --libs gnome-icon-theme-symbolic`
#`pkg-config --cflags --libs gobject-2.0`
#`pkg-config --cflags --libs gthread-2.0`
#`pkg-config --cflags --libs gtk+-2.0`
#`pkg-config --cflags --libs gtk+-3.0`
#`pkg-config --cflags --libs gtkgl-2.0`
#`pkg-config --cflags --libs gtkglext-1.0`
#`pkg-config --cflags --libs gtkglextmm-1.2`
#`pkg-config --cflags --libs gtkglextmm-x11-1.2`
#`pkg-config --cflags --libs gtkglext-x11-1.0`
#`pkg-config --cflags --libs gtkmm-2.4`
#`pkg-config --cflags --libs gtkmm-3.0`
#`pkg-config --cflags --libs gtk+-unix-print-2.0`
#`pkg-config --cflags --libs gtk+-unix-print-3.0`
#`pkg-config --cflags --libs gtk+-wayland-3.0`
#`pkg-config --cflags --libs gtk+-x11-2.0`
#`pkg-config --cflags --libs gtk+-x11-3.0`
#`pkg-config --cflags --libs harfbuzz-gobject`
#`pkg-config --cflags --libs harfbuzz`
#`pkg-config --cflags --libs harfbuzz-icu`
#`pkg-config --cflags --libs hexchat-plugin`
#`pkg-config --cflags --libs ice`
#`pkg-config --cflags --libs inputproto`
#`pkg-config --cflags --libs iso-codes`
#`pkg-config --cflags --libs jack`
#`pkg-config --cflags --libs json-glib-1.0`
#`pkg-config --cflags --libs kbproto`
#`pkg-config --cflags --libs libdrm_amdgpu`
#`pkg-config --cflags --libs libdrm_intel`
#`pkg-config --cflags --libs libdrm`
#`pkg-config --cflags --libs libdrm_nouveau`
#`pkg-config --cflags --libs libdrm_radeon`
#`pkg-config --cflags --libs libfs`
#`pkg-config --cflags --libs libgdiplus`
#`pkg-config --cflags --libs libglfw`
#`pkg-config --cflags --libs libpcrecpp`
#`pkg-config --cflags --libs libpcre`
#`pkg-config --cflags --libs libpcreposix`
#`pkg-config --cflags --libs libpng12`
#`pkg-config --cflags --libs libpng`
#`pkg-config --cflags --libs libudev`
#`pkg-config --cflags --libs m17n-db`
#`pkg-config --cflags --libs menu`
#`pkg-config --cflags --libs mirclient`
#`pkg-config --cflags --libs mircommon`
#`pkg-config --cflags --libs mobile-broadband-provider-info`
#`pkg-config --cflags --libs ncurses++`
#`pkg-config --cflags --libs ncurses`
#`pkg-config --cflags --libs nemo-python`
#`pkg-config --cflags --libs notify-python`
#`pkg-config --cflags --libs panel`
#`pkg-config --cflags --libs pangocairo`
#`pkg-config --cflags --libs pangoft2`
#`pkg-config --cflags --libs pangomm-1.4`
#`pkg-config --cflags --libs pango`
#`pkg-config --cflags --libs pangoxft`
#`pkg-config --cflags --libs pangox`
#`pkg-config --cflags --libs pciaccess`
#`pkg-config --cflags --libs pd`
#`pkg-config --cflags --libs pixman-1`
#`pkg-config --cflags --libs pm-utils`
#`pkg-config --cflags --libs presentproto`
#`pkg-config --cflags --libs protobuf-lite`
#`pkg-config --cflags --libs protobuf`
#`pkg-config --cflags --libs pthread-stubs`
#`pkg-config --cflags --libs pygtksourceview-2.0`
#`pkg-config --cflags --libs Qt5Bootstrap`
#`pkg-config --cflags --libs Qt5Concurrent`
#`pkg-config --cflags --libs Qt5Core`
#`pkg-config --cflags --libs Qt5DBus`
#`pkg-config --cflags --libs Qt5Gui`
#`pkg-config --cflags --libs Qt5Network`
#`pkg-config --cflags --libs Qt5OpenGLExtensions`
#`pkg-config --cflags --libs Qt5PlatformSupport`
#`pkg-config --cflags --libs Qt5PrintSupport`
#`pkg-config --cflags --libs Qt5Sql`
#`pkg-config --cflags --libs Qt5Test`
#`pkg-config --cflags --libs Qt5Widgets`
#`pkg-config --cflags --libs Qt5Xml`
#`pkg-config --cflags --libs randrproto`
#`pkg-config --cflags --libs recordproto`
#`pkg-config --cflags --libs renderproto`
#`pkg-config --cflags --libs resourceproto`
#`pkg-config --cflags --libs scrnsaverproto`
#`pkg-config --cflags --libs shared-mime-info`
#`pkg-config --cflags --libs sigc++-2.0`
#`pkg-config --cflags --libs sm`
#`pkg-config --cflags --libs tic`
#`pkg-config --cflags --libs tinfo`
#`pkg-config --cflags --libs tomboy-addins`
#`pkg-config --cflags --libs udev`
#`pkg-config --cflags --libs udisks`
#`pkg-config --cflags --libs usbutils`
#`pkg-config --cflags --libs videoproto`
#`pkg-config --cflags --libs wayland-client`
#`pkg-config --cflags --libs wayland-cursor`
#`pkg-config --cflags --libs wayland-dfb`
#`pkg-config --cflags --libs wayland-egl`
#`pkg-config --cflags --libs wayland-scanner`
#`pkg-config --cflags --libs wayland-server`
#`pkg-config --cflags --libs weston`
#`pkg-config --cflags --libs x11`
#`pkg-config --cflags --libs x11-xcb`
#`pkg-config --cflags --libs xau`
#`pkg-config --cflags --libs xaw7`
#`pkg-config --cflags --libs xbitmaps`
#`pkg-config --cflags --libs xcb-dri2`
#`pkg-config --cflags --libs xcb-dri3`
#`pkg-config --cflags --libs xcb-glx`
#`pkg-config --cflags --libs xcb-present`
#`pkg-config --cflags --libs xcb-randr`
#`pkg-config --cflags --libs xcb-render`
#`pkg-config --cflags --libs xcb-shape`
#`pkg-config --cflags --libs xcb-shm`
#`pkg-config --cflags --libs xcb-sync`
#`pkg-config --cflags --libs xcb`
#`pkg-config --cflags --libs xcb-xfixes`
#`pkg-config --cflags --libs xcmiscproto`
#`pkg-config --cflags --libs xcomposite`
#`pkg-config --cflags --libs xcursor`
#`pkg-config --cflags --libs xdamage`
#`pkg-config --cflags --libs xdmcp`
#`pkg-config --cflags --libs xextproto`
#`pkg-config --cflags --libs xext`
#`pkg-config --cflags --libs xf86bigfontproto`
#`pkg-config --cflags --libs xf86dgaproto`
#`pkg-config --cflags --libs xf86driproto`
#`pkg-config --cflags --libs xf86vidmodeproto`
#`pkg-config --cflags --libs xfixes`
#`pkg-config --cflags --libs xfont`
#`pkg-config --cflags --libs xft`
#`pkg-config --cflags --libs xineramaproto`
#`pkg-config --cflags --libs xinerama`
#`pkg-config --cflags --libs xi`
#`pkg-config --cflags --libs xkbcommon`
#`pkg-config --cflags --libs xkbcomp`
#`pkg-config --cflags --libs xkbfile`
#`pkg-config --cflags --libs xkeyboard-config`
#`pkg-config --cflags --libs xmuu`
#`pkg-config --cflags --libs xmu`
#`pkg-config --cflags --libs xorg-sgml-doctools`
#`pkg-config --cflags --libs xpm`
#`pkg-config --cflags --libs xproto`
#`pkg-config --cflags --libs xrandr`
#`pkg-config --cflags --libs xrender`
#`pkg-config --cflags --libs xres`
#`pkg-config --cflags --libs xscrnsaver`
#`pkg-config --cflags --libs xshmfence`
#`pkg-config --cflags --libs xtrans`
#`pkg-config --cflags --libs xtst`
#`pkg-config --cflags --libs xt`
#`pkg-config --cflags --libs xvmc`
#`pkg-config --cflags --libs xv`
#`pkg-config --cflags --libs xxf86dga`
#`pkg-config --cflags --libs xxf86vm`
#`pkg-config --cflags --libs yelp-xsl`
#`pkg-config --cflags --libs zlib`
