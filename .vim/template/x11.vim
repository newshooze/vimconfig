#include <stdio.h>
#include <X11/Xlib.h>

int main(int argc,char **argv)
{
	XEvent event;
	Display *display = XOpenDisplay(NULL);
	int screen = DefaultScreen(display);
	Window rootwindow = DefaultRootWindow(display);
	unsigned long blackpixel = BlackPixel(display,screen);
	unsigned long whitepixel = WhitePixel(display,screen);
	Window window = XCreateSimpleWindow(display,rootwindow,400,400,400,200,1,blackpixel,whitepixel);
	XSelectInput(display,window,KeyPressMask|ButtonPressMask);
	XMapWindow(display,window);
	XStoreName(display,window,"X11 Simple Window");
	while(1)
	{
		XNextEvent(display,&event);
		if(event.type == KeyPress)
		{
			if(event.xkey.keycode == 0x9)
				break;
			printf("KeyPress Event %d\n",event.xkey.keycode);	
		}
		else if(event.type == ButtonPress)
			printf("ButtonPress Event %d\n",event.xbutton.button);	
	}
}
