set autowriteall


imap <buffer> <F5> <ESC>:!gcc -c -lm -lX11 -lXpm -lXrender -I/usr/include -o %:r %<CR>
nmap <buffer> <F5> <ESC>:!gcc -c -lm -lX11 -lXpm -lXrender -I/usr/include -o %:r %<CR>

imap <buffer> <F6> <ESC>:!g++ -c -lm -lX11 -lXpm -lXrender -I/usr/include -o %:r.o %<CR>
map <buffer> <F6> <ESC>:!g++ -c -lm -lX11 -lXpm -lXrender -I/usr/include -o %:r.o %<CR>

map <buffer> <F8> <ESC>:make<CR>
imap <buffer> <F8> <ESC>:make<CR>
map <buffer> <S-F8> <ESC>:make test<CR>
imap <buffer> <S-F8> <ESC>:make test<CR>

map <buffer> <F10> <ESC>:make run<CR>
imap <buffer> <F10> <ESC>:make run<CR>

command! Template execute "source ~/.vim/template/c.vim"
map <buffer> <F12> :Template<CR>

imap <buffer> <C-F> <C-X><C-F>
imap <buffer> <C-L> <C-X><C-L>
" c defs

"
iabbrev <buffer> pthread_create pthread_create(pthread_t*,pthread_attr_t*,void*start_routine,void *arg); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> pthread_exit pthread_exit(void *retval); // void<ESC>:normal 0f(<CR>
" std c++ defs
iabbrev <buffer> cout cout << "" << "" << std::endl;<ESC>:normal 0f"<CR>
iabbrev <buffer> ifstream ifstream filestream("".c_str());<CR>if(filestream.is_open())<CR>{<CR>std::string textline;<CR>while(filestream.good())<CR>{<CR>std::getline(filestream,textline,'\n');<CR>}<CR>}<CR>}<ESC>:normal 9k4w<CR>
iabbrev <buffer> find( find(haystack.begin(),haystack.end(),needle)==haystack.end());<ESC>:normal 12b<CR>
" XRender defs


iabbrev <buffer> XRenderAddGlyphs XRenderAddGlyphs(display,GlyphSet	glyphset,_Xconst Glyph *gids,_Xconst XGlyphInfo	*glyphs,int nglyphs,_Xconst char*images,int nbyte_images); // void<ESC>:normal 0f(<CR> 
iabbrev <buffer> XRenderAddTraps XRenderAddTraps(display,picture,xOff,yOff,XTrap*,ntrap); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderChangePicture XRenderChangePicture(display,picture,CP,XRenderPictureAttributes*); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeDoublePoly XRenderCompositeDoublePoly(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,xDst,yDst,XPointDouble*,npoint,int winding); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeString16 XRenderCompositeString16(display,PictOp,src,dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst unsigned short *string,int nchar); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeString32 XRenderCompositeString32(display,int op,Picture src,Picture dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst unsigned int *string,int nchar); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeString8 XRenderCompositeString8(display,int op,Picture src,Picture dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst char *string,int nchar); // void<ESC>:normal 175<CR> 
iabbrev <buffer> XRenderCompositeText16 XRenderCompositeText16(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt16 *elts,int nelt); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeText32 XRenderCompositeText32(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt32 *elts,int nelt); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeText8 XRenderCompositeText8(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt8 *elts,int nelt); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeTrapezoids XRenderCompositeTrapezoids(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,XTrapezoid*,ntrap); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeTriangles XRenderCompositeTriangles(display,PictOp,src,dest,XRenderPictFormat*,xsrc,ysrc,XTriangle*,ntriangle); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCompositeTriFan XRenderCompositeTriFan(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,XPointFixed*,npoint); // void<ESC>:normal 0f(<CR> 
iabbrev <buffer> XRenderCompositeTriStrip XRenderCompositeTriStrip(display,PictOp,src,dest,XRenderPictFormat*,xSrc,ySrc,XPointFixed*,npoint); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderComposite XRenderComposite(display,PictOp,src,mask,dst,src_x,src_y,mask_x,mask_y,dst_x,dst_y,width,height); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateAnimCursor XRenderCreateAnimCursor(display,int ncursor,XAnimCursor*cursors); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateConicalGradient XRenderCreateConicalGradient(display,XConicalGradient*,XFixed *stops,XRenderColor *colors,int nstops); // Picture<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateCursor XRenderCreateCursor(display,Picture source,unsigned int x,unsigned int y); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateGlyphSet XRenderCreateGlyphSet(display,*format); // GlyphSet<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateLinearGradient XRenderCreateLinearGradient(display,XLinearGradient*,XFixed *stops,XRenderColor* colors,int nstops); // Picture<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreatePicture XRenderCreatePicture(display,Drawable,XRenderPictFormat,valuemask,XRenderPictureAttributes*); // Picture<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateRadialGradient XRenderCreateRadialGradient(display,XRadialGradient*,XFixed *stops,XRenderColor *colors,int nstops); // Picture<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderCreateSolidFill XRenderCreateSolidFill(display,XRenderColor*); // Picture<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFillRectangles XRenderFillRectangles(display,PictOp,dst,XRenderColor*,XRectangle*,n_rects); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFillRectangle XRenderFillRectangle(display,PictOp,dst,XRenderColor*,x,y,width,height); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFindFormat XRenderFindFormat(display,unsigned long mask,*templ,int count); // XRenderPictFormat*<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFindStandardFormat XRenderFindStandardFormat(display,PictStandardFormat); // XRenderPictFormat*<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFindVisualFormat XRenderFindVisualFormat(display,Visual*); // XRenderPictFormat*<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFreeGlyphSet XRenderFreeGlyphSet(display,GlyphSet glyphset); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderFreeGlyphs XRenderFreeGlyphs(display,GlyphSet glyphset,_Xconst Glyph *gids,int nglyphs); // void<ESC>:normal 0f(<CR> 
iabbrev <buffer> XRenderFreePicture XRenderFreePicture(display,picture); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderParseColor XRenderParseColor(display,char *,XRenderColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderQueryExtension XRenderQueryExtension(display,int *event_basep,int *error_basep); // Bool<ESC>:normal 0f(<CR> 
iabbrev <buffer> XRenderQueryFilters XRenderQueryFilters(display,drawable); // XFilters*<ESC>:normal 0f(<CR> 
iabbrev <buffer> XRenderQueryFormats XRenderQueryFormats(display); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderQueryPictIndexValues XRenderQueryPictIndexValues(display,	*format,int *num); // XIndexValue*<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderQuerySubpixelOrder XRenderQuerySubpixelOrder(display,int screen); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderQueryVersion XRenderQueryVersion(display,int *major_versionp, int *minor_versionp); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderReferenceGlyphSet XRenderReferenceGlyphSet(display,GlyphSet existing); // GlyphSet<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderSetPictureClipRectangles XRenderSetPictureClipRectangles(display,Picture picture,int xOrigin,int yOrigin,_Xconst XRectangle *rects,int n); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderSetPictureClipRegion XRenderSetPictureClipRegion(display,Picture picture,Region r); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderSetPictureFilter XRenderSetPictureFilter(display,picture,char* filter,XFixed *params,int nparams); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderSetPictureTransform XRenderSetPictureTransform(display,picture,XTransform*); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRenderSetSubpixelOrder XRenderSetSubpixelOrder(display,screen,int subpixel); // Bool<ESC>:normal 0f(<CR>

" Xft.h
iabbrev <buffer> XftCharExists XftCharExists(display,XftFont*pub,FcChar32ucs4); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftCharFontSpecRender XftCharFontSpecRender(display,intop,Picturesrc,Picturedst,intsrcx,intsrcy,_XconstXftCharFontSpec*chars,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftCharSpecRender XftCharSpecRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,_XconstXftCharSpec*chars,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftColorAllocName XftColorAllocName(display,_XconstVisual*visual,Colormapcmap,_Xconstchar*name,XftColor*result); // Bool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftColorAllocValue XftColorAllocValue(display,Visual*visual,Colormapcmap,_XconstXRenderColor*color,XftColor*result); // Bool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftColorFree XftColorFree(display,Visual*visual,Colormapcmap,XftColor*color); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDefaultHasRender XftDefaultHasRender(display); // Bool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDefaultSet XftDefaultSet(display,FcPattern*defaults); // Bool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDefaultSubstitute XftDefaultSubstitute(display,intscreen,FcPattern*pattern); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDirSave XftDirSave(FcFontSet*set,_Xconstchar*dir); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDirScan XftDirScan(FcFontSet*set,_Xconstchar*dir,FcBoolforce); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawChange XftDrawChange(XftDraw*draw,Drawabledrawable); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawCharFontSpec XftDrawCharFontSpec(XftDraw*draw,_XconstXftColor*color,_XconstXftCharFontSpec*chars,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawCharSpec XftDrawCharSpec(XftDraw*draw,_XconstXftColor*color,XftFont*pub,_XconstXftCharSpec*chars,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawColormap XftDrawColormap(XftDraw*draw); // Colormap <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawCreateAlpha XftDrawCreateAlpha(display,Pixmappixmap,intdepth); // XftDraw * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawCreateBitmap XftDrawCreateBitmap(display,Pixmapbitmap); // XftDraw * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawCreate XftDrawCreate(display,Drawabledrawable,Visual*visual,Colormapcolormap); // XftDraw * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawDestroy XftDrawDestroy(XftDraw*draw); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawDisplay XftDrawDisplay(XftDraw*draw); // Display * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawDrawable XftDrawDrawable(XftDraw*draw); // Drawable <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawGlyphFontSpec XftDrawGlyphFontSpec(XftDraw*draw,_XconstXftColor*color,_XconstXftGlyphFontSpec*glyphs,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawGlyphSpec XftDrawGlyphSpec(XftDraw*draw,_XconstXftColor*color,XftFont*pub,_XconstXftGlyphSpec*glyphs,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawGlyphs XftDrawGlyphs(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFT_UInt*glyphs,intnglyphs); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawPicture XftDrawPicture(XftDraw*draw); // Picture <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawRect XftDrawRect(XftDraw*draw,_XconstXftColor*color,intx,inty,unsignedintwidth,unsignedintheight); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawSetClipRectangles XftDrawSetClipRectangles(XftDraw*draw,intxOrigin,intyOrigin,_XconstXRectangle*rects,intn); // Bool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawSetClip XftDrawSetClip(XftDraw*draw,Regionr); // Bool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawSetSubwindowMode XftDrawSetSubwindowMode(XftDraw*draw,intmode); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawSrcPicture XftDrawSrcPicture(XftDraw*draw,_XconstXftColor*color); // Picture <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawString16 XftDrawString16(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar16*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawString32 XftDrawString32(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar32*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawString8 XftDrawString8(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawStringUtf16 XftDrawStringUtf16(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,FcEndianendian,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawStringUtf8 XftDrawStringUtf8(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftDrawVisual XftDrawVisual(XftDraw*draw); // Visual * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontCheckGlyph XftFontCheckGlyph(display,XftFont*pub,FcBoolneed_bitmaps,FT_UIntglyph,FT_UInt*missing,int*nmissing); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontClose XftFontClose(display,XftFont*pub); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontCopy XftFontCopy(display,XftFont*pub); // XftFont * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontInfoCreate XftFontInfoCreate(display,_XconstFcPattern*pattern); // XftFontInfo * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontInfoDestroy XftFontInfoDestroy(display,XftFontInfo*fi); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontInfoEqual XftFontInfoEqual(_XconstXftFontInfo*a,_XconstXftFontInfo*b); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontInfoHash XftFontInfoHash(_XconstXftFontInfo*fi); // FcChar32 <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontLoadGlyphs XftFontLoadGlyphs(display,XftFont*pub,FcBoolneed_bitmaps,_XconstFT_UInt*glyphs,intnglyph); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontMatch XftFontMatch(display,intscreen,_XconstFcPattern*pattern,FcResult*result); // FcPattern * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontOpenInfo XftFontOpenInfo(display,FcPattern*pattern,XftFontInfo*fi); // XftFont * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontOpenName XftFontOpenName(display,intscreen,_Xconstchar*name); // XftFont * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontOpenPattern XftFontOpenPattern(display,FcPattern*pattern); // XftFont * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontOpen XftFontOpen(display,intscreen,...)_X_SENTINEL(0); // XftFont * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontOpenXlfd XftFontOpenXlfd(display,intscreen,_Xconstchar*xlfd); // XftFont * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftFontUnloadGlyphs XftFontUnloadGlyphs(display,XftFont*pub,_XconstFT_UInt*glyphs,intnglyph); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftGlyphExtents XftGlyphExtents(display,XftFont*pub,_XconstFT_UInt*glyphs,intnglyphs,XGlyphInfo*extents); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftGlyphFontSpecRender XftGlyphFontSpecRender(display,intop,Picturesrc,Picturedst,intsrcx,intsrcy,_XconstXftGlyphFontSpec*glyphs,intnglyphs); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftGlyphRender XftGlyphRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFT_UInt*glyphs,intnglyphs); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftGlyphSpecRender XftGlyphSpecRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,_XconstXftGlyphSpec*glyphs,intnglyphs); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftInitFtLibrary XftInitFtLibrary(void); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftInit XftInit(_Xconstchar*config); // FcBool <ESC>:normal 0f(<CR>
iabbrev <buffer> XftListFonts XftListFonts(display,intscreen,...)_X_SENTINEL(0); // FcFontSet * <ESC>:normal 0f(<CR>
iabbrev <buffer> XftLockFace XftLockFace(XftFont*pub); // FT_Face <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextExtents16 XftTextExtents16(display,XftFont*pub,_XconstFcChar16*string,intlen,XGlyphInfo*extents); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextExtents32 XftTextExtents32(display,XftFont*pub,_XconstFcChar32*string,intlen,XGlyphInfo*extents); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextExtents8 XftTextExtents8(display,XftFont*pub,_XconstFcChar8*string,intlen,XGlyphInfo*extents); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextExtentsUtf16 XftTextExtentsUtf16(display,XftFont*pub,_XconstFcChar8*string,FcEndianendian,intlen,XGlyphInfo*extents); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextExtentsUtf8 XftTextExtentsUtf8(display,XftFont*pub,_XconstFcChar8*string,intlen,XGlyphInfo*extents); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender16BE XftTextRender16BE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender16LE XftTextRender16LE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender16 XftTextRender16(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar16*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender32BE XftTextRender32BE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender32LE XftTextRender32LE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender32 XftTextRender32(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar32*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRender8 XftTextRender8(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRenderUtf16 XftTextRenderUtf16(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,FcEndianendian,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftTextRenderUtf8 XftTextRenderUtf8(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftUnlockFace XftUnlockFace(XftFont*pub); // void <ESC>:normal 0f(<CR>
iabbrev <buffer> XftXlfdParse XftXlfdParse(_Xconstchar*xlfd_orig,Boolignore_scalable,Boolcomplete); // FcPattern * <ESC>:normal 0f(<CR>

" Xlib defs

iabbrev <buffer> XActivateScreenSaver  XActivateScreenSaver(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddConnectionWatch  XAddConnectionWatch(display,XConnectionWatchProc,XPointer); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddExtension XAddExtension(display); // XExtCodes *<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddHosts  XAddHosts(display,XHostAddress*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddHost  XAddHost(display,XHostAddress*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddToExtensionList  XAddToExtensionList(struct _XExtData**,XExtData*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddToSaveSet  XAddToSaveSet(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocColorCells  XAllocColorCells(display,Colormap,Bool,unsigned long*,unsigned int,unsigned long*,unsigned int ); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocColorPlanes  XAllocColorPlanes(display,Colormap,Bool,unsigned long*,int,int,int,int,unsigned long*,unsigned long*,unsigned long*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocColor  XAllocColor(display,Colormap,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocNamedColor  XAllocNamedColor(display,Colormap,_Xconst char*,XColor*,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllowEvents  XAllowEvents(display,int,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllPlanes  XAllPlanes(void); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XAutoRepeatOff  XAutoRepeatOff(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAutoRepeatOn  XAutoRepeatOn(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBaseFontNameListOfFontSet XBaseFontNameListOfFontSet(XFontSet); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XBell  XBell(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBitmapBitOrder  XBitmapBitOrder(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBitmapPad  XBitmapPad(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBitmapUnit  XBitmapUnit(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBlackPixelOfScreen  XBlackPixelOfScreen(Screen*); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XBlackPixel  XBlackPixel(display,int); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XCellsOfScreen  XCellsOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeActivePointerGrab  XChangeActivePointerGrab(display,unsigned int,Cursor,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeGC  XChangeGC(display,GC,unsigned long,XGCValues*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeKeyboardControl  XChangeKeyboardControl(display,unsigned long,XKeyboardControl*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeKeyboardMapping  XChangeKeyboardMapping(display,int,int,KeySym*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangePointerControl  XChangePointerControl(display,Bool,Bool,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeProperty  XChangeProperty(display,Window,Atom,Atom,int,int,_Xconst unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeSaveSet  XChangeSaveSet(display,Window,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeWindowAttributes  XChangeWindowAttributes(display,Window,unsigned long,XSetWindowAttributes* ); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckMaskEvent  XCheckMaskEvent(display,long,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckTypedEvent  XCheckTypedEvent(display,int,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckTypedWindowEvent  XCheckTypedWindowEvent(display,Window,int,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckWindowEvent  XCheckWindowEvent(display,Window,long,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCirculateSubwindowsDown  XCirculateSubwindowsDown(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCirculateSubwindowsUp  XCirculateSubwindowsUp(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCirculateSubwindows  XCirculateSubwindows(display,Window,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XClearArea  XClearArea(display,Window,int,int,unsigned int,unsigned int,Bool); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XClearWindow  XClearWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCloseDisplay  XCloseDisplay(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCloseIM  XCloseIM(XIM ); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XCloseOM  XCloseOM(XOM); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XConfigureWindow  XConfigureWindow(display,Window,unsigned int,XWindowChanges*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XConnectionNumber  XConnectionNumber(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XContextDependentDrawing  XContextDependentDrawing(XFontSet); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XContextualDrawing  XContextualDrawing(XFontSet); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XConvertSelection  XConvertSelection(display,Atom,Atom ,Atom,Window,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyArea  XCopyArea(display,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyColormapAndFree  XCopyColormapAndFree(display,Colormap); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyGC  XCopyGC(display,GC,unsigned long,GC); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyPlane  XCopyPlane(display,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateBitmapFromData  XCreateBitmapFromData(display,Drawable,_Xconst char*,unsigned int,unsigned int); // Pixmap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateColormap  XCreateColormap(display,Window,Visual*,int); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateFontCursor  XCreateFontCursor(display,unsigned int); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateFontSet  XCreateFontSet(display,_Xconst char*,char***,int*,char**); // XFontSet<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateGC  XCreateGC(display,Drawable,unsigned long,XGCValues*); // GC<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateGlyphCursor  XCreateGlyphCursor(display,Font,Font,unsigned int,unsigned int,XColor _Xconst *,XColor _Xconst *); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateImage XCreateImage(display,Visual*,unsigned int,int,int,char*,unsigned int,unsigned int,int,int); // XImage *<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreatePixmapCursor  XCreatePixmapCursor(display,Pixmap,Pixmap,XColor*,XColor*,unsigned int,unsigned int); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreatePixmapFromBitmapData  XCreatePixmapFromBitmapData(display,Drawable,char*,unsigned int,unsigned int,unsigned long,unsigned long,unsigned int); // Pixmap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreatePixmap  XCreatePixmap(display,Drawable,unsigned int,unsigned int,unsigned int); // Pixmap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateSimpleWindow  XCreateSimpleWindow(display,Window,int,int,unsigned int,unsigned int,unsigned int,unsigned long,unsigned long); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateWindow  XCreateWindow(display,Window,int,int,unsigned int,unsigned int,unsigned int,int,unsigned int,Visual*,unsigned long,XSetWindowAttributes*); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultColormapOfScreen  XDefaultColormapOfScreen(Screen*); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultColormap  XDefaultColormap(display,int); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultDepthOfScreen  XDefaultDepthOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultDepth  XDefaultDepth(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultGCOfScreen  XDefaultGCOfScreen(Screen*); // GC<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultGC  XDefaultGC(display,int); // GC<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultRootWindow  XDefaultRootWindow(display); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultScreenOfDisplay XDefaultScreenOfDisplay(display); // Screen *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultScreen  XDefaultScreen(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultVisualOfScreen XDefaultVisualOfScreen(Screen*); // Visual *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultVisual XDefaultVisual(display,int); // Visual *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefineCursor  XDefineCursor(display,Window,Cursor); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDeleteModifiermapEntry XDeleteModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint); // XModifierKeymap *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDeleteProperty  XDeleteProperty(display,Window,Atom); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroyIC  XDestroyIC(XIC ); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroyOC  XDestroyOC(XOC); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroySubwindows  XDestroySubwindows(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroyWindow  XDestroyWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDirectionalDependentDrawing  XDirectionalDependentDrawing(XFontSet); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisableAccessControl  XDisableAccessControl(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayCells  XDisplayCells(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayHeightMM  XDisplayHeightMM(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayHeight  XDisplayHeight(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayKeycodes  XDisplayKeycodes(display,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayMotionBufferSize  XDisplayMotionBufferSize(display); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayName XDisplayName(_Xconst char*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayOfIM XDisplayOfIM(XIM ); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayOfOM XDisplayOfOM(XOM); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayOfScreen XDisplayOfScreen(Screen*); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayPlanes  XDisplayPlanes(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayString XDisplayString(display); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayWidthMM  XDisplayWidthMM(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayWidth  XDisplayWidth(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDoesBackingStore  XDoesBackingStore(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDoesSaveUnders  XDoesSaveUnders(Screen*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawArcs  XDrawArcs(display,Drawable,GC,XArc*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawArc  XDrawArc(display,Drawable,GC,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawImageString16  XDrawImageString16(display,Drawable,GC,int,int,_Xconst XChar2b*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawImageString  XDrawImageString(display,Drawable,GC,int,int,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawLines  XDrawLines(display,Drawable,GC,XPoint*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawLine  XDrawLine(display,Drawable,GC,int,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawPoints  XDrawPoints(display,Drawable,GC,XPoint*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawPoint  XDrawPoint(display,Drawable,GC,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawRectangles  XDrawRectangles(display,Drawable,GC,XRectangle*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawRectangle  XDrawRectangle(display,Drawable,GC,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawSegments  XDrawSegments(display,Drawable,GC,XSegment*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawString16  XDrawString16(display,Drawable,GC,int,int,_Xconst XChar2b*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawString  XDrawString(display,Drawable,GC,int,int,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawText16  XDrawText16(display,Drawable,GC,int,int,XTextItem16*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawText  XDrawText(display,Drawable,GC,int,int,XTextItem*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XEHeadOfExtensionList XEHeadOfExtensionList(XEDataObject); // XExtData **<ESC>:normal 0f(<CR>
iabbrev <buffer> XEnableAccessControl  XEnableAccessControl(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XEventMaskOfScreen  XEventMaskOfScreen(Screen*); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> XEventsQueued  XEventsQueued(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XExtendedMaxRequestSize  XExtendedMaxRequestSize(display); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> XExtentsOfFontSet XExtentsOfFontSet(XFontSet); // XFontSetExtents *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFetchBuffer XFetchBuffer(display,int*,int); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFetchBytes XFetchBytes(display,int*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFetchName  XFetchName(display,Window,char**); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillArcs  XFillArcs(display,Drawable,GC,XArc*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillArc  XFillArc(display,Drawable,GC,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillPolygon  XFillPolygon(display,Drawable,GC,XPoint*,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillRectangles  XFillRectangles(display,Drawable,GC,XRectangle*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillRectangle  XFillRectangle(display,Drawable,GC,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFilterEvent  XFilterEvent(XEvent*,Window); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XFindOnExtensionList XFindOnExtensionList(XExtData**,int); // XExtData *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFlushGC  XFlushGC(display,GC); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XFlush  XFlush(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFontsOfFontSet  XFontsOfFontSet(XFontSet,XFontStruct***,char***); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XForceScreenSaver  XForceScreenSaver(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeColormap  XFreeColormap(display,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeColors  XFreeColors(display,Colormap,unsigned long*,int,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeCursor  XFreeCursor(display,Cursor); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeExtensionList  XFreeExtensionList(char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontInfo  XFreeFontInfo(char**,XFontStruct*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontNames  XFreeFontNames(char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontPath  XFreeFontPath(char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontSet  XFreeFontSet(display,XFontSet); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFont  XFreeFont(display,XFontStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeGC  XFreeGC(display,GC); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeModifiermap  XFreeModifiermap(XModifierKeymap*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreePixmap  XFreePixmap(display,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeStringList  XFreeStringList(char**); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XFree  XFree(void*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGContextFromGC  XGContextFromGC(GC); // GContext<ESC>:normal 0f(<CR>
iabbrev <buffer> XGeometry  XGeometry(display,int,_Xconst char*,_Xconst char*,unsigned int,unsigned int,unsigned int,int,int,int*,int*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetAtomNames  XGetAtomNames(display,Atom*,int,char**); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetAtomName XGetAtomName(display,Atom); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetCommand  XGetCommand(display,Window,char***,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetDefault XGetDefault(display,_Xconst char*,_Xconst char*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetErrorDatabaseText  XGetErrorDatabaseText(display,_Xconst char*,_Xconst char*,_Xconst char*,char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetErrorText  XGetErrorText(display,int,char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetFontPath XGetFontPath(display,int*); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetFontProperty  XGetFontProperty(XFontStruct*,Atom,unsigned long*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetGCValues  XGetGCValues(display,GC,unsigned long,XGCValues*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetGeometry  XGetGeometry(display,Drawable,Window*,int*,int*,unsigned int*,unsigned int*,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetIconName  XGetIconName(display,Window,char**); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetICValues XGetICValues(XIC , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetImage XGetImage(display,Drawable,int,int,unsigned int,unsigned int,unsigned long,int); // XImage *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetIMValues XGetIMValues(XIM , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetInputFocus  XGetInputFocus(display,Window*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetKeyboardControl  XGetKeyboardControl(display,XKeyboardState*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetKeyboardMapping XGetKeyboardMapping(display,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint,int*); // KeySym *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetModifierMapping XGetModifierMapping(display); // XModifierKeymap*<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetMotionEvents XGetMotionEvents(display,Window,Time,Time,int*); // XTimeCoord *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetOCValues XGetOCValues(XOC,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetOMValues XGetOMValues(XOM,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetPointerControl  XGetPointerControl(display,int*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetPointerMapping  XGetPointerMapping(display,unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetScreenSaver  XGetScreenSaver(display,int*,int*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetSelectionOwner  XGetSelectionOwner(display,Atom); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetSubImage XGetSubImage(display,Drawable,int,int,unsigned int,unsigned int,unsigned long,int,XImage*,int,int); // XImage *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetTransientForHint  XGetTransientForHint(display,Window,Window*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWindowAttributes  XGetWindowAttributes(display,Window,XWindowAttributes*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWindowProperty  XGetWindowProperty(display,Window,Atom,long,long,Bool,Atom,Atom*,int*,unsigned long*,unsigned long*,unsigned char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWMColormapWindows  XGetWMColormapWindows(display,Window,Window**,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWMProtocols  XGetWMProtocols(display,Window,Atom**,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabButton  XGrabButton(display,unsigned int,unsigned int,Window,Bool,unsigned int,int,int,Window,Cursor); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabKeyboard  XGrabKeyboard(display,Window,Bool,int,int,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabKey  XGrabKey(display,int,unsigned int,Window,Bool,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabPointer  XGrabPointer(display,Window,Bool,unsigned int,int,int,Window,Cursor,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabServer  XGrabServer(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XHeightMMOfScreen  XHeightMMOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XHeightOfScreen  XHeightOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XIconifyWindow  XIconifyWindow(display,Window,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XImageByteOrder  XImageByteOrder(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XIMOfIC  XIMOfIC(XIC ); // XIM<ESC>:normal 0f(<CR>
iabbrev <buffer> XInitExtension XInitExtension(display,_Xconst char*); // XExtCodes *<ESC>:normal 0f(<CR>
iabbrev <buffer> XInitImage  XInitImage(XImage*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInitThreads  XInitThreads(void); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInsertModifiermapEntry XInsertModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint); // XModifierKeymap*<ESC>:normal 0f(<CR>
iabbrev <buffer> XInstallColormap  XInstallColormap(display,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XInternalConnectionNumbers  XInternalConnectionNumbers(display,int**,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInternAtoms  XInternAtoms(display,char**,int,Bool,Atom*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInternAtom  XInternAtom(display,_Xconst char*,Bool); // Atom<ESC>:normal 0f(<CR>
iabbrev <buffer> XKeycodeToKeysym  XKeycodeToKeysym(display,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint); // KeySym<ESC>:normal 0f(<CR>
iabbrev <buffer> XKeysymToKeycode  XKeysymToKeycode(display,KeySym); // KeyCode<ESC>:normal 0f(<CR>
iabbrev <buffer> XKeysymToString XKeysymToString(KeySym); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XKillClient  XKillClient(display,XID); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XLastKnownRequestProcessed  XLastKnownRequestProcessed(display); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XListDepths XListDepths(display,int,int*); // int *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListExtensions XListExtensions(display,int*); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XListFontsWithInfo XListFontsWithInfo(display,_Xconst char*,int,int*,XFontStruct**); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XListFonts XListFonts(display,_Xconst char*,int,int*); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XListHosts XListHosts(display,int*,Bool*); // XHostAddress *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListInstalledColormaps XListInstalledColormaps(display,Window,int*); // Colormap *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListPixmapFormats XListPixmapFormats(display,int*); // XPixmapFormatValues *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListProperties XListProperties(display,Window,int*); // Atom *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLoadFont  XLoadFont(display,_Xconst char*); // Font<ESC>:normal 0f(<CR>
iabbrev <buffer> XLoadQueryFont XLoadQueryFont(display,_Xconst char*); // int _Xdebug;extern XFontStruct *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLocaleOfFontSet XLocaleOfFontSet(XFontSet); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLocaleOfIM XLocaleOfIM(XIM ); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLocaleOfOM XLocaleOfOM(XOM); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLockDisplay  XLockDisplay(display); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XLookupColor  XLookupColor(display,Colormap,_Xconst char*,XColor*,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XLookupKeysym  XLookupKeysym(XKeyEvent*,int); // KeySym<ESC>:normal 0f(<CR>
iabbrev <buffer> XLowerWindow  XLowerWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMapRaised  XMapRaised(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMapSubwindows  XMapSubwindows(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMapWindow  XMapWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMaskEvent  XMaskEvent(display,long,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMaxCmapsOfScreen  XMaxCmapsOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMaxRequestSize  XMaxRequestSize(display); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbDrawImageString  XmbDrawImageString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbDrawString  XmbDrawString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbDrawText  XmbDrawText(display,Drawable,GC,int,int,XmbTextItem*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbLookupString  XmbLookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbResetIC XmbResetIC(XIC ); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbTextEscapement  XmbTextEscapement(XFontSet,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbTextExtents  XmbTextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbTextPerCharExtents  XmbTextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> _Xmbtowc  _Xmbtowc(wchar_t *,#ifdef ISCchar const *,size_t#elsechar *,int#endif); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMinCmapsOfScreen  XMinCmapsOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMoveResizeWindow  XMoveResizeWindow(display,Window,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMoveWindow  XMoveWindow(display,Window,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XNewModifiermap XNewModifiermap(int); // XModifierKeymap *<ESC>:normal 0f(<CR>
iabbrev <buffer> XNextEvent  XNextEvent(display,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XNextRequest  XNextRequest(display); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XNoOp  XNoOp(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XOMOfOC  XOMOfOC(XOC); // XOM<ESC>:normal 0f(<CR>
iabbrev <buffer> XOpenDisplay XOpenDisplay(_Xconst char*); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XOpenIM  XOpenIM(display,struct _XrmHashBucketRec*,char*,char*); // XIM<ESC>:normal 0f(<CR>
iabbrev <buffer> XOpenOM  XOpenOM(display,struct _XrmHashBucketRec*,_Xconst char*,_Xconst char*); // XOM<ESC>:normal 0f(<CR>
iabbrev <buffer> XParseColor  XParseColor(display,Colormap,_Xconst char*,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XParseGeometry  XParseGeometry(_Xconst char*,int*,int*,unsigned int*,unsigned int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPeekEvent  XPeekEvent(display,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPending  XPending(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPlanesOfScreen  XPlanesOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XProcessInternalConnection  XProcessInternalConnection(display,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XProtocolRevision  XProtocolRevision(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XProtocolVersion  XProtocolVersion(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPutBackEvent  XPutBackEvent(display,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPutImage  XPutImage(display,Drawable,GC,XImage*,int,int,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQLength  XQLength(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestCursor  XQueryBestCursor(display,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestSize  XQueryBestSize(display,int,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestStipple  XQueryBestStipple(display,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestTile  XQueryBestTile(display,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryColors  XQueryColors(display,Colormap,XColor*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryColor  XQueryColor(display,Colormap,XColor*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryExtension  XQueryExtension(display,_Xconst char*,int*,int*,int*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryFont XQueryFont(display,XID); // XFontStruct *<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryKeymap  XQueryKeymap(display,char [32]); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryPointer  XQueryPointer(display,Window,Window*,Window*,int*,int*,int*,int*,unsigned int* ); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryTextExtents16  XQueryTextExtents16(display,XID,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryTextExtents  XQueryTextExtents(display,XID,_Xconst char*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryTree  XQueryTree(display,Window,Window*,Window*,Window**,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRaiseWindow  XRaiseWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReadBitmapFileData  XReadBitmapFileData(_Xconst char*,unsigned int*,unsigned int*,unsigned char**,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReadBitmapFile  XReadBitmapFile(display,Drawable ,_Xconst char*,unsigned int*,unsigned int*,Pixmap*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRebindKeysym  XRebindKeysym(display,KeySym,KeySym*,int,_Xconst unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRecolorCursor  XRecolorCursor(display,Cursor,XColor*,XColor*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReconfigureWMWindow  XReconfigureWMWindow(display,Window,int,unsigned int,XWindowChanges*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRefreshKeyboardMapping  XRefreshKeyboardMapping(XMappingEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRegisterIMInstantiateCallback  XRegisterIMInstantiateCallback(display,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveConnectionWatch  XRemoveConnectionWatch(display,XConnectionWatchProc,XPointer); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveFromSaveSet  XRemoveFromSaveSet(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveHosts  XRemoveHosts(display,XHostAddress*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveHost  XRemoveHost(display,XHostAddress*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReparentWindow  XReparentWindow(display,Window,Window,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XResetScreenSaver  XResetScreenSaver(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XResizeWindow  XResizeWindow(display,Window,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XResourceManagerString XResourceManagerString(display); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XRestackWindows  XRestackWindows(display,Window*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XrmInitialize  XrmInitialize(void); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRootWindowOfScreen  XRootWindowOfScreen(Screen*); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XRootWindow  XRootWindow(display,int); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XRotateBuffers  XRotateBuffers(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRotateWindowProperties  XRotateWindowProperties(display,Window,Atom*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenCount  XScreenCount(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenNumberOfScreen  XScreenNumberOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenOfDisplay XScreenOfDisplay(display,int); // Screen *<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenResourceString XScreenResourceString(Screen*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSelectInput  XSelectInput(display,Window,long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSendEvent  XSendEvent(display,Window,Bool,long,XEvent*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XServerVendor XServerVendor(display); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetAccessControl  XSetAccessControl(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetArcMode  XSetArcMode(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetAuthorization  XSetAuthorization(char *,int,char *,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetBackground  XSetBackground(display,GC,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetClipMask  XSetClipMask(display,GC,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetClipOrigin  XSetClipOrigin(display,GC,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetClipRectangles  XSetClipRectangles(display,GC,int,int,XRectangle*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetCloseDownMode  XSetCloseDownMode(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetCommand  XSetCommand(display,Window,char**,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetDashes  XSetDashes(display,GC,int,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFillRule  XSetFillRule(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFillStyle  XSetFillStyle(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFontPath  XSetFontPath(display,char**,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFont  XSetFont(display,GC,Font); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetForeground  XSetForeground(display,GC,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFunction  XSetFunction(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetGraphicsExposures  XSetGraphicsExposures(display,GC,Bool); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetICFocus  XSetICFocus(XIC ); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetIconName  XSetIconName(display,Window,_Xconst char*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetICValues XSetICValues(XIC , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetIMValues XSetIMValues(XIM , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetInputFocus  XSetInputFocus(display,Window,int,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetLineAttributes  XSetLineAttributes(display,GC,unsigned int,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetLocaleModifiers XSetLocaleModifiers(const char*); // Bool XSupportsLocale (void);extern char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetModifierMapping  XSetModifierMapping(display,XModifierKeymap*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetOCValues XSetOCValues(XOC,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetOMValues XSetOMValues(XOM,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetPlaneMask  XSetPlaneMask(display,GC,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetPointerMapping  XSetPointerMapping(display,_Xconst unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetScreenSaver  XSetScreenSaver(display,int,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetSelectionOwner  XSetSelectionOwner(display,Atom,Window,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetState  XSetState(display,GC,unsigned long ,unsigned long,int,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetStipple  XSetStipple(display,GC,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetSubwindowMode  XSetSubwindowMode(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetTile  XSetTile(display,GC,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetTransientForHint  XSetTransientForHint(display,Window,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetTSOrigin  XSetTSOrigin(display,GC,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBackgroundPixmap  XSetWindowBackgroundPixmap(display,Window,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBackground  XSetWindowBackground(display,Window,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBorderPixmap  XSetWindowBorderPixmap(display,Window,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBorderWidth  XSetWindowBorderWidth(display,Window,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBorder  XSetWindowBorder(display,Window,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowColormap  XSetWindowColormap(display,Window,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWMColormapWindows  XSetWMColormapWindows(display,Window,Window*,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWMProtocols  XSetWMProtocols(display,Window,Atom*,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreBuffer  XStoreBuffer(display,_Xconst char*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreBytes  XStoreBytes(display,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreColors  XStoreColors(display,Colormap,XColor*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreColor  XStoreColor(display,Colormap,XColor*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreNamedColor  XStoreNamedColor(display,Colormap,_Xconst char*,unsigned long,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreName  XStoreName(display,Window,_Xconst char*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStringToKeysym  XStringToKeysym(_Xconst char*); // KeySym<ESC>:normal 0f(<CR>
iabbrev <buffer> XSync  XSync(display,Bool); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextExtents16  XTextExtents16(XFontStruct*,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextExtents  XTextExtents(XFontStruct*,_Xconst char*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextWidth16  XTextWidth16(XFontStruct*,_Xconst XChar2b*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextWidth  XTextWidth(XFontStruct*,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTranslateCoordinates  XTranslateCoordinates(display,Window,Window,int,int,int*,int*,Window*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XUndefineCursor  XUndefineCursor(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabButton  XUngrabButton(display,unsigned int,unsigned int,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabKeyboard  XUngrabKeyboard(display,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabKey  XUngrabKey(display,int,unsigned int,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabPointer  XUngrabPointer(display,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabServer  XUngrabServer(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUninstallColormap  XUninstallColormap(display,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnloadFont  XUnloadFont(display,Font); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnlockDisplay  XUnlockDisplay(display); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnmapSubwindows  XUnmapSubwindows(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnmapWindow  XUnmapWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnregisterIMInstantiateCallback  XUnregisterIMInstantiateCallback(display,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnsetICFocus  XUnsetICFocus(XIC ); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8DrawImageString  Xutf8DrawImageString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8DrawString  Xutf8DrawString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8DrawText  Xutf8DrawText(display,Drawable,GC,int,int,XmbTextItem*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8LookupString  Xutf8LookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8ResetIC Xutf8ResetIC(XIC ); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8TextEscapement  Xutf8TextEscapement(XFontSet,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8TextExtents  Xutf8TextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8TextPerCharExtents  Xutf8TextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XVendorRelease  XVendorRelease(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XVisualIDFromVisual  XVisualIDFromVisual(Visual*); // VisualID<ESC>:normal 0f(<CR>
iabbrev <buffer> XWarpPointer  XWarpPointer(display,Window,Window,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcDrawImageString  XwcDrawImageString(display,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcDrawString  XwcDrawString(display,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcDrawText  XwcDrawText(display,Drawable,GC,int,int,XwcTextItem*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcLookupString  XwcLookupString(XIC,XKeyPressedEvent*,wchar_t*,int,KeySym*,Status*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcResetIC XwcResetIC(XIC ); // wchar_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcTextEscapement  XwcTextEscapement(XFontSet,_Xconst wchar_t*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcTextExtents  XwcTextExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcTextPerCharExtents  XwcTextPerCharExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> _Xwctomb  _Xwctomb(char *,wchar_t); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWhitePixelOfScreen  XWhitePixelOfScreen(Screen*); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XWhitePixel  XWhitePixel(display,int); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XWidthMMOfScreen  XWidthMMOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWidthOfScreen  XWidthOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWindowEvent  XWindowEvent(display,Window,long,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWithdrawWindow  XWithdrawWindow(display,Window,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XWriteBitmapFile  XWriteBitmapFile(display,_Xconst char*,Pixmap,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
