:insert
#include <iostream>
#include <vector>
#include <string>
#include <pthread.h>
#include <X11/xpm.h>
#include <X11/extensions/Xrender.h>
#include "mkwidget.h"
#include "mkcheckbox.h"
#include "mkslider.h"
#include "mkdial.h"
#include "mklabel.h"
#define _FONTMED "-*-*-*-r-*--32-*-0-0-p-0-iso8859-1"
#define _FONTBOLD "-*-*-*-r-*--120-*-0-0-p-0-iso8859-1"

Pixmap background;
Picture drawarea;
XRenderPictFormat *pictureformat;
XRenderColor red={0xffff,0x0,0x0,0xffff};
XRenderColor grey={0xdddd,0xdddd,0xdddd,0xffff};

class WWW:public mkWidget
{
	public:
	WWW(mkWidget *parent)
		:mkWidget(parent,100,100,1600,700)
	{
	}
	void CreateControls()
	{
		XRenderPictureAttributes attr;
		attr.poly_edge=PolyEdgeSmooth;
		attr.poly_mode=PolyModePrecise;
		background=XCreatePixmap(display,window,width,height,DefaultDepth(display,DefaultScreen(display)));
		XSetWindowBackgroundPixmap(display,window,background);
		pictureformat=XRenderFindVisualFormat(display,visual);
		drawarea=XRenderCreatePicture(display,background,pictureformat,CPPolyEdge|CPPolyMode,&attr);
	}
	void Update()
	{
		XClearArea(display,window,0,0,width,height,0);
		XRenderFillRectangle(display,PictOpOver,drawarea,&grey,0,0,width,height);
	}
	void KeyPressedEvent(XKeyPressedEvent *e)
	{
		Update();
	}
	void ExposeEvent(XExposeEvent *e)
	{
		Update();
	}
};

int main(int,char **)
{
	WWW *ww =new WWW(0);
	ww->SetName("ww");
	ww->CreateControls();
	ww->dispatcher->Start();
}
