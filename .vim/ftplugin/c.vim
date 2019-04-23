set autowriteall

" Compile current filename.c and link to executable
nnoremap <buffer> <F5> <ESC>:!gcc %:t -o %:r -lm<CR>
inoremap <buffer> <F5> <ESC>:!gcc %:t -o %:r -lm<CR>
" Run 
inoremap <buffer> <F6> <ESC>:make run<CR>
nnoremap <buffer> <F6> <ESC>:make run<CR>
" Make
inoremap <buffer> <F8> <ESC>:make<CR>
nnoremap <buffer> <F8> <ESC>:make<CR>
" Make Clean
inoremap <buffer> <S-F8> <ESC>:make clean<CR>
nnoremap <buffer> <S-F8> <ESC>:make clean<CR>

nnoremap <buffer> <F12> :source ~/.vim/template/c.vim<CR>gg^


" stdio.h
iabbrev <buffer> fopen fopen("filename","r"); // FILE*<ESC>:normal 0f(<CR>
iabbrev <buffer> fclose fclose(FILE); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> fseek fseek(FILE,offset,wence); // int - wence is SEEK_SET,SEEK_CUR,SEEK_END<ESC>:normal 0f(<CR>
iabbrev <buffer> ftell ftell(FILE); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> rewind rewind(FILE); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> fprintf fprintf(FILE,format); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> sprintf sprintf(buffer,format); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> snprintf snprintf(buffer,size_t,format); // int<ESC>:normal 0f(<CR>

" stdlib.h

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

iabbrev <buffer> XActivateScreenSaver XActivateScreenSaver(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddConnectionWatch XAddConnectionWatch(display,XConnectionWatchProc,XPointer); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddExtension XAddExtension(display); // XExtCodes *<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddHosts XAddHosts(display,XHostAddress*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddHost XAddHost(display,XHostAddress*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddToExtensionList XAddToExtensionList(struct _XExtData**,XExtData*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAddToSaveSet XAddToSaveSet(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocColorCells XAllocColorCells(display,Colormap,Bool,unsigned long*,unsigned int,unsigned long*,unsigned int ); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocColorPlanes XAllocColorPlanes(display,Colormap,Bool,unsigned long*,int,int,int,int,unsigned long*,unsigned long*,unsigned long*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocColor XAllocColor(display,Colormap,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllocNamedColor XAllocNamedColor(display,Colormap,_Xconst char*,XColor*,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllowEvents XAllowEvents(display,int,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAllPlanes XAllPlanes(void); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XAutoRepeatOff XAutoRepeatOff(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XAutoRepeatOn XAutoRepeatOn(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBaseFontNameListOfFontSet XBaseFontNameListOfFontSet(XFontSet); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XBell XBell(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBitmapBitOrder XBitmapBitOrder(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBitmapPad XBitmapPad(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBitmapUnit XBitmapUnit(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XBlackPixelOfScreen XBlackPixelOfScreen(Screen*); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XBlackPixel XBlackPixel(display,int); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XCellsOfScreen XCellsOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeActivePointerGrab XChangeActivePointerGrab(display,unsigned int,Cursor,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeGC XChangeGC(display,GC,unsigned long,XGCValues*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeKeyboardControl XChangeKeyboardControl(display,unsigned long,XKeyboardControl*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeKeyboardMapping XChangeKeyboardMapping(display,int,int,KeySym*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangePointerControl XChangePointerControl(display,Bool,Bool,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeProperty XChangeProperty(display,Window,Atom,Atom,int,int,_Xconst unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeSaveSet XChangeSaveSet(display,Window,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XChangeWindowAttributes XChangeWindowAttributes(display,Window,unsigned long,XSetWindowAttributes* ); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckMaskEvent XCheckMaskEvent(display,long,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckTypedEvent XCheckTypedEvent(display,int,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckTypedWindowEvent XCheckTypedWindowEvent(display,Window,int,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCheckWindowEvent XCheckWindowEvent(display,Window,long,XEvent*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XCirculateSubwindowsDown XCirculateSubwindowsDown(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCirculateSubwindowsUp XCirculateSubwindowsUp(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCirculateSubwindows XCirculateSubwindows(display,Window,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XClearArea XClearArea(display,Window,int,int,unsigned int,unsigned int,Bool); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XClearWindow XClearWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCloseDisplay XCloseDisplay(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCloseIM XCloseIM(XIM ); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XCloseOM XCloseOM(XOM); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XConfigureWindow XConfigureWindow(display,Window,unsigned int,XWindowChanges*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XConnectionNumber XConnectionNumber(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XContextDependentDrawing XContextDependentDrawing(XFontSet); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XContextualDrawing XContextualDrawing(XFontSet); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XConvertSelection XConvertSelection(display,Atom,Atom ,Atom,Window,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyArea XCopyArea(display,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyColormapAndFree XCopyColormapAndFree(display,Colormap); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyGC XCopyGC(display,GC,unsigned long,GC); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCopyPlane XCopyPlane(display,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateBitmapFromData XCreateBitmapFromData(display,Drawable,_Xconst char*,unsigned int,unsigned int); // Pixmap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateColormap XCreateColormap(display,Window,Visual*,int); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateFontCursor XCreateFontCursor(display,unsigned int); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateFontSet XCreateFontSet(display,_Xconst char*,char***,int*,char**); // XFontSet<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateGC XCreateGC(display,Drawable,unsigned long,XGCValues*); // GC<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateGlyphCursor XCreateGlyphCursor(display,Font,Font,unsigned int,unsigned int,XColor _Xconst *,XColor _Xconst *); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateImage XCreateImage(display,Visual*,unsigned int,int,int,char*,unsigned int,unsigned int,int,int); // XImage *<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreatePixmapCursor XCreatePixmapCursor(display,Pixmap,Pixmap,XColor*,XColor*,unsigned int,unsigned int); // Cursor<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreatePixmapFromBitmapData XCreatePixmapFromBitmapData(display,Drawable,char*,unsigned int,unsigned int,unsigned long,unsigned long,unsigned int); // Pixmap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreatePixmap XCreatePixmap(display,Drawable,unsigned int,unsigned int,unsigned int); // Pixmap<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateSimpleWindow XCreateSimpleWindow(display,Window,int,int,unsigned int,unsigned int,unsigned int,unsigned long,unsigned long); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XCreateWindow XCreateWindow(display,Window,int,int,unsigned int,unsigned int,unsigned int,int,unsigned int,Visual*,unsigned long,XSetWindowAttributes*); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultColormapOfScreen XDefaultColormapOfScreen(Screen*); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultColormap XDefaultColormap(display,int); // Colormap<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultDepthOfScreen XDefaultDepthOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultDepth XDefaultDepth(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultGCOfScreen XDefaultGCOfScreen(Screen*); // GC<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultGC XDefaultGC(display,int); // GC<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultRootWindow XDefaultRootWindow(display); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultScreenOfDisplay XDefaultScreenOfDisplay(display); // Screen *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultScreen XDefaultScreen(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultVisualOfScreen XDefaultVisualOfScreen(Screen*); // Visual *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefaultVisual XDefaultVisual(display,int); // Visual *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDefineCursor XDefineCursor(display,Window,Cursor); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDeleteModifiermapEntry XDeleteModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint); // XModifierKeymap *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDeleteProperty XDeleteProperty(display,Window,Atom); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroyIC XDestroyIC(XIC ); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroyOC XDestroyOC(XOC); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroySubwindows XDestroySubwindows(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDestroyWindow XDestroyWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDirectionalDependentDrawing XDirectionalDependentDrawing(XFontSet); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisableAccessControl XDisableAccessControl(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayCells XDisplayCells(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayHeightMM XDisplayHeightMM(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayHeight XDisplayHeight(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayKeycodes XDisplayKeycodes(display,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayMotionBufferSize XDisplayMotionBufferSize(display); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayName XDisplayName(_Xconst char*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayOfIM XDisplayOfIM(XIM ); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayOfOM XDisplayOfOM(XOM); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayOfScreen XDisplayOfScreen(Screen*); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayPlanes XDisplayPlanes(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayString XDisplayString(display); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayWidthMM XDisplayWidthMM(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDisplayWidth XDisplayWidth(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDoesBackingStore XDoesBackingStore(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDoesSaveUnders XDoesSaveUnders(Screen*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawArcs XDrawArcs(display,Drawable,GC,XArc*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawArc XDrawArc(display,Drawable,GC,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawImageString16 XDrawImageString16(display,Drawable,GC,int,int,_Xconst XChar2b*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawImageString XDrawImageString(display,Drawable,GC,int,int,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawLines XDrawLines(display,Drawable,GC,XPoint*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawLine XDrawLine(display,Drawable,GC,int,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawPoints XDrawPoints(display,Drawable,GC,XPoint*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawPoint XDrawPoint(display,Drawable,GC,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawRectangles XDrawRectangles(display,Drawable,GC,XRectangle*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawRectangle XDrawRectangle(display,Drawable,GC,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawSegments XDrawSegments(display,Drawable,GC,XSegment*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawString16 XDrawString16(display,Drawable,GC,int,int,_Xconst XChar2b*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawString XDrawString(display,Drawable,GC,int,int,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawText16 XDrawText16(display,Drawable,GC,int,int,XTextItem16*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XDrawText XDrawText(display,Drawable,GC,int,int,XTextItem*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XEHeadOfExtensionList XEHeadOfExtensionList(XEDataObject); // XExtData **<ESC>:normal 0f(<CR>
iabbrev <buffer> XEnableAccessControl XEnableAccessControl(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XEventMaskOfScreen XEventMaskOfScreen(Screen*); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> XEventsQueued XEventsQueued(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XExtendedMaxRequestSize XExtendedMaxRequestSize(display); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> XExtentsOfFontSet XExtentsOfFontSet(XFontSet); // XFontSetExtents *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFetchBuffer XFetchBuffer(display,int*,int); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFetchBytes XFetchBytes(display,int*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFetchName XFetchName(display,Window,char**); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillArcs XFillArcs(display,Drawable,GC,XArc*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillArc XFillArc(display,Drawable,GC,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillPolygon XFillPolygon(display,Drawable,GC,XPoint*,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillRectangles XFillRectangles(display,Drawable,GC,XRectangle*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFillRectangle XFillRectangle(display,Drawable,GC,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFilterEvent XFilterEvent(XEvent*,Window); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XFindOnExtensionList XFindOnExtensionList(XExtData**,int); // XExtData *<ESC>:normal 0f(<CR>
iabbrev <buffer> XFlushGC XFlushGC(display,GC); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XFlush XFlush(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFontsOfFontSet XFontsOfFontSet(XFontSet,XFontStruct***,char***); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XForceScreenSaver XForceScreenSaver(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeColormap XFreeColormap(display,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeColors XFreeColors(display,Colormap,unsigned long*,int,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeCursor XFreeCursor(display,Cursor); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeExtensionList XFreeExtensionList(char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontInfo XFreeFontInfo(char**,XFontStruct*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontNames XFreeFontNames(char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontPath XFreeFontPath(char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFontSet XFreeFontSet(display,XFontSet); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeFont XFreeFont(display,XFontStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeGC XFreeGC(display,GC); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeModifiermap XFreeModifiermap(XModifierKeymap*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreePixmap XFreePixmap(display,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XFreeStringList XFreeStringList(char**); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XFree XFree(void*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGContextFromGC XGContextFromGC(GC); // GContext<ESC>:normal 0f(<CR>
iabbrev <buffer> XGeometry XGeometry(display,int,_Xconst char*,_Xconst char*,unsigned int,unsigned int,unsigned int,int,int,int*,int*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetAtomNames XGetAtomNames(display,Atom*,int,char**); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetAtomName XGetAtomName(display,Atom); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetCommand XGetCommand(display,Window,char***,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetDefault XGetDefault(display,_Xconst char*,_Xconst char*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetErrorDatabaseText XGetErrorDatabaseText(display,_Xconst char*,_Xconst char*,_Xconst char*,char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetErrorText XGetErrorText(display,int,char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetFontPath XGetFontPath(display,int*); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetFontProperty XGetFontProperty(XFontStruct*,Atom,unsigned long*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetGCValues XGetGCValues(display,GC,unsigned long,XGCValues*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetGeometry XGetGeometry(display,Drawable,Window*,int*,int*,unsigned int*,unsigned int*,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetIconName XGetIconName(display,Window,char**); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetICValues XGetICValues(XIC , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetImage XGetImage(display,Drawable,int,int,unsigned int,unsigned int,unsigned long,int); // XImage *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetIMValues XGetIMValues(XIM , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetInputFocus XGetInputFocus(display,Window*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetKeyboardControl XGetKeyboardControl(display,XKeyboardState*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetKeyboardMapping XGetKeyboardMapping(display,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint,int*); // KeySym *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetModifierMapping XGetModifierMapping(display); // XModifierKeymap*<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetMotionEvents XGetMotionEvents(display,Window,Time,Time,int*); // XTimeCoord *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetOCValues XGetOCValues(XOC,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetOMValues XGetOMValues(XOM,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetPointerControl XGetPointerControl(display,int*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetPointerMapping XGetPointerMapping(display,unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetScreenSaver XGetScreenSaver(display,int*,int*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetSelectionOwner XGetSelectionOwner(display,Atom); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetSubImage XGetSubImage(display,Drawable,int,int,unsigned int,unsigned int,unsigned long,int,XImage*,int,int); // XImage *<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetTransientForHint XGetTransientForHint(display,Window,Window*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWindowAttributes XGetWindowAttributes(display,Window,XWindowAttributes*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWindowProperty XGetWindowProperty(display,Window,Atom,long,long,Bool,Atom,Atom*,int*,unsigned long*,unsigned long*,unsigned char**); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWMColormapWindows XGetWMColormapWindows(display,Window,Window**,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGetWMProtocols XGetWMProtocols(display,Window,Atom**,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabButton XGrabButton(display,unsigned int,unsigned int,Window,Bool,unsigned int,int,int,Window,Cursor); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabKeyboard XGrabKeyboard(display,Window,Bool,int,int,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabKey XGrabKey(display,int,unsigned int,Window,Bool,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabPointer XGrabPointer(display,Window,Bool,unsigned int,int,int,Window,Cursor,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XGrabServer XGrabServer(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XHeightMMOfScreen XHeightMMOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XHeightOfScreen XHeightOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XIconifyWindow XIconifyWindow(display,Window,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XImageByteOrder XImageByteOrder(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XIMOfIC XIMOfIC(XIC ); // XIM<ESC>:normal 0f(<CR>
iabbrev <buffer> XInitExtension XInitExtension(display,_Xconst char*); // XExtCodes *<ESC>:normal 0f(<CR>
iabbrev <buffer> XInitImage XInitImage(XImage*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInitThreads XInitThreads(void); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInsertModifiermapEntry XInsertModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint); // XModifierKeymap*<ESC>:normal 0f(<CR>
iabbrev <buffer> XInstallColormap XInstallColormap(display,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XInternalConnectionNumbers XInternalConnectionNumbers(display,int**,int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInternAtoms XInternAtoms(display,char**,int,Bool,Atom*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XInternAtom XInternAtom(display,_Xconst char*,Bool); // Atom<ESC>:normal 0f(<CR>
iabbrev <buffer> XKeycodeToKeysym XKeycodeToKeysym(display,#if NeedWidePrototypesunsigned int,#elseKeyCode,#endifint); // KeySym<ESC>:normal 0f(<CR>
iabbrev <buffer> XKeysymToKeycode XKeysymToKeycode(display,KeySym); // KeyCode<ESC>:normal 0f(<CR>
iabbrev <buffer> XKeysymToString XKeysymToString(KeySym); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XKillClient XKillClient(display,XID); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XLastKnownRequestProcessed XLastKnownRequestProcessed(display); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XListDepths XListDepths(display,int,int*); // int *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListExtensions XListExtensions(display,int*); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XListFontsWithInfo XListFontsWithInfo(display,_Xconst char*,int,int*,XFontStruct**); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XListFonts XListFonts(display,_Xconst char*,int,int*); // char **<ESC>:normal 0f(<CR>
iabbrev <buffer> XListHosts XListHosts(display,int*,Bool*); // XHostAddress *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListInstalledColormaps XListInstalledColormaps(display,Window,int*); // Colormap *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListPixmapFormats XListPixmapFormats(display,int*); // XPixmapFormatValues *<ESC>:normal 0f(<CR>
iabbrev <buffer> XListProperties XListProperties(display,Window,int*); // Atom *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLoadFont XLoadFont(display,_Xconst char*); // Font<ESC>:normal 0f(<CR>
iabbrev <buffer> XLoadQueryFont XLoadQueryFont(display,_Xconst char*); // int _Xdebug;extern XFontStruct *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLocaleOfFontSet XLocaleOfFontSet(XFontSet); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLocaleOfIM XLocaleOfIM(XIM ); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLocaleOfOM XLocaleOfOM(XOM); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XLockDisplay XLockDisplay(display); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XLookupColor XLookupColor(display,Colormap,_Xconst char*,XColor*,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XLookupKeysym XLookupKeysym(XKeyEvent*,int); // KeySym<ESC>:normal 0f(<CR>
iabbrev <buffer> XLowerWindow XLowerWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMapRaised XMapRaised(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMapSubwindows XMapSubwindows(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMapWindow XMapWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMaskEvent XMaskEvent(display,long,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMaxCmapsOfScreen XMaxCmapsOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMaxRequestSize XMaxRequestSize(display); // long<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbDrawImageString XmbDrawImageString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbDrawString XmbDrawString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbDrawText XmbDrawText(display,Drawable,GC,int,int,XmbTextItem*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbLookupString XmbLookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbResetIC XmbResetIC(XIC ); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbTextEscapement XmbTextEscapement(XFontSet,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbTextExtents XmbTextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XmbTextPerCharExtents XmbTextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> _Xmbtowc _Xmbtowc(wchar_t *,#ifdef ISCchar const *,size_t#elsechar *,int#endif); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMinCmapsOfScreen XMinCmapsOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMoveResizeWindow XMoveResizeWindow(display,Window,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XMoveWindow XMoveWindow(display,Window,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XNewModifiermap XNewModifiermap(int); // XModifierKeymap *<ESC>:normal 0f(<CR>
iabbrev <buffer> XNextEvent XNextEvent(display,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XNextRequest XNextRequest(display); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XNoOp XNoOp(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XOMOfOC XOMOfOC(XOC); // XOM<ESC>:normal 0f(<CR>
iabbrev <buffer> XOpenDisplay XOpenDisplay(_Xconst char*); // Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> XOpenIM XOpenIM(display,struct _XrmHashBucketRec*,char*,char*); // XIM<ESC>:normal 0f(<CR>
iabbrev <buffer> XOpenOM XOpenOM(display,struct _XrmHashBucketRec*,_Xconst char*,_Xconst char*); // XOM<ESC>:normal 0f(<CR>
iabbrev <buffer> XParseColor XParseColor(display,Colormap,_Xconst char*,XColor*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XParseGeometry XParseGeometry(_Xconst char*,int*,int*,unsigned int*,unsigned int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPeekEvent XPeekEvent(display,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPending XPending(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPlanesOfScreen XPlanesOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XProcessInternalConnection XProcessInternalConnection(display,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XProtocolRevision XProtocolRevision(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XProtocolVersion XProtocolVersion(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPutBackEvent XPutBackEvent(display,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XPutImage XPutImage(display,Drawable,GC,XImage*,int,int,int,int,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQLength XQLength(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestCursor XQueryBestCursor(display,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestSize XQueryBestSize(display,int,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestStipple XQueryBestStipple(display,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryBestTile XQueryBestTile(display,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryColors XQueryColors(display,Colormap,XColor*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryColor XQueryColor(display,Colormap,XColor*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryExtension XQueryExtension(display,_Xconst char*,int*,int*,int*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryFont XQueryFont(display,XID); // XFontStruct *<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryKeymap XQueryKeymap(display,char [32]); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryPointer XQueryPointer(display,Window,Window*,Window*,int*,int*,int*,int*,unsigned int* ); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryTextExtents16 XQueryTextExtents16(display,XID,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryTextExtents XQueryTextExtents(display,XID,_Xconst char*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XQueryTree XQueryTree(display,Window,Window*,Window*,Window**,unsigned int*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRaiseWindow XRaiseWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReadBitmapFileData XReadBitmapFileData(_Xconst char*,unsigned int*,unsigned int*,unsigned char**,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReadBitmapFile XReadBitmapFile(display,Drawable ,_Xconst char*,unsigned int*,unsigned int*,Pixmap*,int*,int*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRebindKeysym XRebindKeysym(display,KeySym,KeySym*,int,_Xconst unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRecolorCursor XRecolorCursor(display,Cursor,XColor*,XColor*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReconfigureWMWindow XReconfigureWMWindow(display,Window,int,unsigned int,XWindowChanges*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XRefreshKeyboardMapping XRefreshKeyboardMapping(XMappingEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRegisterIMInstantiateCallback XRegisterIMInstantiateCallback(display,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveConnectionWatch XRemoveConnectionWatch(display,XConnectionWatchProc,XPointer); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveFromSaveSet XRemoveFromSaveSet(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveHosts XRemoveHosts(display,XHostAddress*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRemoveHost XRemoveHost(display,XHostAddress*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XReparentWindow XReparentWindow(display,Window,Window,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XResetScreenSaver XResetScreenSaver(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XResizeWindow XResizeWindow(display,Window,unsigned int,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XResourceManagerString XResourceManagerString(display); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XRestackWindows XRestackWindows(display,Window*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XrmInitialize XrmInitialize(void); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XRootWindowOfScreen XRootWindowOfScreen(Screen*); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XRootWindow XRootWindow(display,int); // Window<ESC>:normal 0f(<CR>
iabbrev <buffer> XRotateBuffers XRotateBuffers(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XRotateWindowProperties XRotateWindowProperties(display,Window,Atom*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenCount XScreenCount(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenNumberOfScreen XScreenNumberOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenOfDisplay XScreenOfDisplay(display,int); // Screen *<ESC>:normal 0f(<CR>
iabbrev <buffer> XScreenResourceString XScreenResourceString(Screen*); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSelectInput XSelectInput(display,Window,long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSendEvent XSendEvent(display,Window,Bool,long,XEvent*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XServerVendor XServerVendor(display); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetAccessControl XSetAccessControl(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetArcMode XSetArcMode(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetAuthorization XSetAuthorization(char *,int,char *,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetBackground XSetBackground(display,GC,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetClipMask XSetClipMask(display,GC,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetClipOrigin XSetClipOrigin(display,GC,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetClipRectangles XSetClipRectangles(display,GC,int,int,XRectangle*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetCloseDownMode XSetCloseDownMode(display,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetCommand XSetCommand(display,Window,char**,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetDashes XSetDashes(display,GC,int,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFillRule XSetFillRule(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFillStyle XSetFillStyle(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFontPath XSetFontPath(display,char**,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFont XSetFont(display,GC,Font); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetForeground XSetForeground(display,GC,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetFunction XSetFunction(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetGraphicsExposures XSetGraphicsExposures(display,GC,Bool); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetICFocus XSetICFocus(XIC ); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetIconName XSetIconName(display,Window,_Xconst char*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetICValues XSetICValues(XIC , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetIMValues XSetIMValues(XIM , ...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetInputFocus XSetInputFocus(display,Window,int,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetLineAttributes XSetLineAttributes(display,GC,unsigned int,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetLocaleModifiers XSetLocaleModifiers(const char*); // Bool XSupportsLocale (void);extern char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetModifierMapping XSetModifierMapping(display,XModifierKeymap*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetOCValues XSetOCValues(XOC,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetOMValues XSetOMValues(XOM,...) _X_SENTINEL(0); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetPlaneMask XSetPlaneMask(display,GC,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetPointerMapping XSetPointerMapping(display,_Xconst unsigned char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetScreenSaver XSetScreenSaver(display,int,int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetSelectionOwner XSetSelectionOwner(display,Atom,Window,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetState XSetState(display,GC,unsigned long ,unsigned long,int,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetStipple XSetStipple(display,GC,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetSubwindowMode XSetSubwindowMode(display,GC,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetTile XSetTile(display,GC,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetTransientForHint XSetTransientForHint(display,Window,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetTSOrigin XSetTSOrigin(display,GC,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBackgroundPixmap XSetWindowBackgroundPixmap(display,Window,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBackground XSetWindowBackground(display,Window,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBorderPixmap XSetWindowBorderPixmap(display,Window,Pixmap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBorderWidth XSetWindowBorderWidth(display,Window,unsigned int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowBorder XSetWindowBorder(display,Window,unsigned long); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWindowColormap XSetWindowColormap(display,Window,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWMColormapWindows XSetWMColormapWindows(display,Window,Window*,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XSetWMProtocols XSetWMProtocols(display,Window,Atom*,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreBuffer XStoreBuffer(display,_Xconst char*,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreBytes XStoreBytes(display,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreColors XStoreColors(display,Colormap,XColor*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreColor XStoreColor(display,Colormap,XColor*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreNamedColor XStoreNamedColor(display,Colormap,_Xconst char*,unsigned long,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStoreName XStoreName(display,Window,_Xconst char*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XStringToKeysym XStringToKeysym(_Xconst char*); // KeySym<ESC>:normal 0f(<CR>
iabbrev <buffer> XSync XSync(display,Bool); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextExtents16 XTextExtents16(XFontStruct*,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextExtents XTextExtents(XFontStruct*,_Xconst char*,int,int*,int*,int*,XCharStruct*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextWidth16 XTextWidth16(XFontStruct*,_Xconst XChar2b*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTextWidth XTextWidth(XFontStruct*,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XTranslateCoordinates XTranslateCoordinates(display,Window,Window,int,int,int*,int*,Window*); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XUndefineCursor XUndefineCursor(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabButton XUngrabButton(display,unsigned int,unsigned int,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabKeyboard XUngrabKeyboard(display,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabKey XUngrabKey(display,int,unsigned int,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabPointer XUngrabPointer(display,Time); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUngrabServer XUngrabServer(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUninstallColormap XUninstallColormap(display,Colormap); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnloadFont XUnloadFont(display,Font); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnlockDisplay XUnlockDisplay(display); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnmapSubwindows XUnmapSubwindows(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnmapWindow XUnmapWindow(display,Window); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnregisterIMInstantiateCallback XUnregisterIMInstantiateCallback(display,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); // Bool<ESC>:normal 0f(<CR>
iabbrev <buffer> XUnsetICFocus XUnsetICFocus(XIC ); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8DrawImageString Xutf8DrawImageString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8DrawString Xutf8DrawString(display,Drawable,XFontSet,GC,int,int,_Xconst char*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8DrawText Xutf8DrawText(display,Drawable,GC,int,int,XmbTextItem*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8LookupString Xutf8LookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8ResetIC Xutf8ResetIC(XIC ); // char *<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8TextEscapement Xutf8TextEscapement(XFontSet,_Xconst char*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8TextExtents Xutf8TextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> Xutf8TextPerCharExtents Xutf8TextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XVendorRelease XVendorRelease(display); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XVisualIDFromVisual XVisualIDFromVisual(Visual*); // VisualID<ESC>:normal 0f(<CR>
iabbrev <buffer> XWarpPointer XWarpPointer(display,Window,Window,int,int,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcDrawImageString XwcDrawImageString(display,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcDrawString XwcDrawString(display,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcDrawText XwcDrawText(display,Drawable,GC,int,int,XwcTextItem*,int); // void<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcLookupString XwcLookupString(XIC,XKeyPressedEvent*,wchar_t*,int,KeySym*,Status*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcResetIC XwcResetIC(XIC ); // wchar_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcTextEscapement XwcTextEscapement(XFontSet,_Xconst wchar_t*,int); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcTextExtents XwcTextExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XwcTextPerCharExtents XwcTextPerCharExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> _Xwctomb _Xwctomb(char *,wchar_t); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWhitePixelOfScreen XWhitePixelOfScreen(Screen*); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XWhitePixel XWhitePixel(display,int); // unsigned long<ESC>:normal 0f(<CR>
iabbrev <buffer> XWidthMMOfScreen XWidthMMOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWidthOfScreen XWidthOfScreen(Screen*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWindowEvent XWindowEvent(display,Window,long,XEvent*); // int<ESC>:normal 0f(<CR>
iabbrev <buffer> XWithdrawWindow XWithdrawWindow(display,Window,int); // Status<ESC>:normal 0f(<CR>
iabbrev <buffer> XWriteBitmapFile XWriteBitmapFile(display,_Xconst char*,Pixmap,unsigned int,unsigned int,int,int); // int<ESC>:normal 0f(<CR>

" cairo.h defs

iabbrev <buffer> cairo_clip cairo_clip(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_clip_preserve cairo_clip_preserve(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_close_path cairo_close_path(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_clip_rectangle_list cairo_copy_clip_rectangle_list(cairo_t *cr); //cairo_rectangle_list_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_page cairo_copy_page(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_path cairo_copy_path(cairo_t *cr); //cairo_path_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_path_flat cairo_copy_path_flat(cairo_t *cr); //cairo_path_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_create cairo_create(cairo_surface_t *target); //cairo_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_debug_reset_static_data cairo_debug_reset_static_data(void); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_destroy cairo_destroy(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_acquire cairo_device_acquire(cairo_device_t *device); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_destroy cairo_device_destroy(cairo_device_t *device); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_finish cairo_device_finish(cairo_device_t *device); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_flush cairo_device_flush(cairo_device_t *device); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_get_reference_count cairo_device_get_reference_count(cairo_device_t *device); //unsigned int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_get_type cairo_device_get_type(cairo_device_t *device); //cairo_device_type_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_elapsed cairo_device_observer_elapsed(cairo_device_t *device); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_fill_elapsed cairo_device_observer_fill_elapsed(cairo_device_t *device); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_glyphs_elapsed cairo_device_observer_glyphs_elapsed(cairo_device_t *device); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_mask_elapsed cairo_device_observer_mask_elapsed(cairo_device_t *device); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_paint_elapsed cairo_device_observer_paint_elapsed(cairo_device_t *device); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_stroke_elapsed cairo_device_observer_stroke_elapsed(cairo_device_t *device); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_reference cairo_device_reference(cairo_device_t *device); //cairo_device_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_release cairo_device_release(cairo_device_t *device); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_status cairo_device_status(cairo_device_t *device); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_to_user cairo_device_to_user(cairo_t *cr,double *x,double *y); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_to_user_distance cairo_device_to_user_distance(cairo_t *cr,double *dx,double *dy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_fill cairo_fill(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_fill_preserve cairo_fill_preserve(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_destroy cairo_font_face_destroy(cairo_font_face_t *font_face); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_get_reference_count cairo_font_face_get_reference_count(cairo_font_face_t *font_face); //unsigned int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_get_type cairo_font_face_get_type(cairo_font_face_t *font_face); //cairo_font_type_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_reference cairo_font_face_reference(cairo_font_face_t *font_face); //cairo_font_face_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_status cairo_font_face_status(cairo_font_face_t *font_face); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_copy cairo_font_options_copy(const cairo_font_options_t *original); //cairo_font_options_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_create cairo_font_options_create(void); //cairo_font_options_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_destroy cairo_font_options_destroy(cairo_font_options_t *options); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_antialias cairo_font_options_get_antialias(const cairo_font_options_t *options); //cairo_antialias_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_hint_metrics cairo_font_options_get_hint_metrics(const cairo_font_options_t *options); //cairo_hint_metrics_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_hint_style cairo_font_options_get_hint_style(const cairo_font_options_t *options); //cairo_hint_style_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_subpixel_order cairo_font_options_get_subpixel_order(const cairo_font_options_t *options); //cairo_subpixel_order_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_hash cairo_font_options_hash(const cairo_font_options_t *options); //unsigned long<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_status cairo_font_options_status(cairo_font_options_t *options); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_antialias cairo_get_antialias(cairo_t *cr); //cairo_antialias_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_current_point cairo_get_current_point(cairo_t *cr,double *x,double *y); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_dash cairo_get_dash(cairo_t *cr,double *dashes,double *offset); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_dash_count cairo_get_dash_count(cairo_t *cr); //int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_fill_rule cairo_get_fill_rule(cairo_t *cr); //cairo_fill_rule_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_font_face cairo_get_font_face(cairo_t *cr); //cairo_font_face_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_group_target cairo_get_group_target(cairo_t *cr); //cairo_surface_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_line_cap cairo_get_line_cap(cairo_t *cr); //cairo_line_cap_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_line_join cairo_get_line_join(cairo_t *cr); //cairo_line_join_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_line_width cairo_get_line_width(cairo_t *cr); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_matrix cairo_get_matrix(cairo_t *cr,cairo_matrix_t *matrix); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_miter_limit cairo_get_miter_limit(cairo_t *cr); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_operator cairo_get_operator(cairo_t *cr); //cairo_operator_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_reference_count cairo_get_reference_count(cairo_t *cr); //unsigned int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_scaled_font cairo_get_scaled_font(cairo_t *cr); //cairo_scaled_font_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_source cairo_get_source(cairo_t *cr); //cairo_pattern_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_target cairo_get_target(cairo_t *cr); //cairo_surface_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_tolerance cairo_get_tolerance(cairo_t *cr); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_glyph_allocate cairo_glyph_allocate(int num_glyphs); //cairo_glyph_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_glyph_free cairo_glyph_free(cairo_glyph_t *glyphs); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_glyph_path cairo_glyph_path(cairo_t *cr,const cairo_glyph_t *glyphs,int num_glyphs); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_has_current_point cairo_has_current_point(cairo_t *cr); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_identity_matrix cairo_identity_matrix(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_create_from_png cairo_image_surface_create_from_png(const char *filename); //cairo_surface_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_data cairo_image_surface_get_data(cairo_surface_t *surface); //unsigned char *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_format cairo_image_surface_get_format(cairo_surface_t *surface); //cairo_format_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_height cairo_image_surface_get_height(cairo_surface_t *surface); //int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_stride cairo_image_surface_get_stride(cairo_surface_t *surface); //int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_width cairo_image_surface_get_width(cairo_surface_t *surface); //int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_in_clip cairo_in_clip(cairo_t *cr,double x,double y); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_in_fill cairo_in_fill(cairo_t *cr,double x,double y); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_in_stroke cairo_in_stroke(cairo_t *cr,double x,double y); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_line_to cairo_line_to(cairo_t *cr,double x,double y); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_init_identity cairo_matrix_init_identity(cairo_matrix_t *matrix); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_invert cairo_matrix_invert(cairo_matrix_t *matrix); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_rotate cairo_matrix_rotate(cairo_matrix_t *matrix,double radians); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_scale cairo_matrix_scale(cairo_matrix_t *matrix,double sx,double sy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_translate cairo_matrix_translate(cairo_matrix_t *matrix,double tx,double ty); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_mesh_pattern_begin_patch cairo_mesh_pattern_begin_patch(cairo_pattern_t *pattern); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_mesh_pattern_end_patch cairo_mesh_pattern_end_patch(cairo_pattern_t *pattern); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_move_to cairo_move_to(cairo_t *cr,double x,double y); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_new_path cairo_new_path(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_new_sub_path cairo_new_sub_path(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_paint cairo_paint(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_path_destroy cairo_path_destroy(cairo_path_t *path); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_create_for_surface cairo_pattern_create_for_surface(cairo_surface_t *surface); //cairo_pattern_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_create_mesh cairo_pattern_create_mesh(void); //cairo_pattern_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_create_rgb cairo_pattern_create_rgb(double red,double green,double blue); //cairo_pattern_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_destroy cairo_pattern_destroy(cairo_pattern_t *pattern); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_extend cairo_pattern_get_extend(cairo_pattern_t *pattern); //cairo_extend_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_filter cairo_pattern_get_filter(cairo_pattern_t *pattern); //cairo_filter_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_reference_count cairo_pattern_get_reference_count(cairo_pattern_t *pattern); //unsigned int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_type cairo_pattern_get_type(cairo_pattern_t *pattern); //cairo_pattern_type_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_reference cairo_pattern_reference(cairo_pattern_t *pattern); //cairo_pattern_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_set_extend cairo_pattern_set_extend(cairo_pattern_t *pattern,cairo_extend_t extend); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_set_filter cairo_pattern_set_filter(cairo_pattern_t *pattern,cairo_filter_t filter); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_status cairo_pattern_status(cairo_pattern_t *pattern); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pop_group cairo_pop_group(cairo_t *cr); //cairo_pattern_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pop_group_to_source cairo_pop_group_to_source(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_push_group cairo_push_group(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_push_group_with_content cairo_push_group_with_content(cairo_t *cr,cairo_content_t content); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_callback_data cairo_raster_source_pattern_get_callback_data(cairo_pattern_t *pattern); //void *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_copy cairo_raster_source_pattern_get_copy(cairo_pattern_t *pattern); //cairo_raster_source_copy_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_finish cairo_raster_source_pattern_get_finish(cairo_pattern_t *pattern); //cairo_raster_source_finish_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_snapshot cairo_raster_source_pattern_get_snapshot(cairo_pattern_t *pattern); //cairo_raster_source_snapshot_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rectangle_list_destroy cairo_rectangle_list_destroy(cairo_rectangle_list_t *rectangle_list); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_reference cairo_reference(cairo_t *cr); //cairo_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_contains_point cairo_region_contains_point(const cairo_region_t *region,int x,int y); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_copy cairo_region_copy(const cairo_region_t *original); //cairo_region_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_create cairo_region_create(void); //cairo_region_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_create_rectangle cairo_region_create_rectangle(const cairo_rectangle_int_t *rectangle); //cairo_region_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_destroy cairo_region_destroy(cairo_region_t *region); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_equal cairo_region_equal(const cairo_region_t *a,const cairo_region_t *b); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_intersect cairo_region_intersect(cairo_region_t *dst,const cairo_region_t *other); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_is_empty cairo_region_is_empty(const cairo_region_t *region); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_num_rectangles cairo_region_num_rectangles(const cairo_region_t *region); //int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_reference cairo_region_reference(cairo_region_t *region); //cairo_region_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_status cairo_region_status(const cairo_region_t *region); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_subtract cairo_region_subtract(cairo_region_t *dst,const cairo_region_t *other); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_translate cairo_region_translate(cairo_region_t *region,int dx,int dy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_union cairo_region_union(cairo_region_t *dst,const cairo_region_t *other); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_xor cairo_region_xor(cairo_region_t *dst,const cairo_region_t *other); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rel_line_to cairo_rel_line_to(cairo_t *cr,double dx,double dy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rel_move_to cairo_rel_move_to(cairo_t *cr,double dx,double dy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_reset_clip cairo_reset_clip(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_restore cairo_restore(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rotate cairo_rotate(cairo_t *cr,double angle); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_save cairo_save(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scale cairo_scale(cairo_t *cr,double sx,double sy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_destroy cairo_scaled_font_destroy(cairo_scaled_font_t *scaled_font); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_get_font_face cairo_scaled_font_get_font_face(cairo_scaled_font_t *scaled_font); //cairo_font_face_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_get_reference_count cairo_scaled_font_get_reference_count(cairo_scaled_font_t *scaled_font); //unsigned int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_get_type cairo_scaled_font_get_type(cairo_scaled_font_t *scaled_font); //cairo_font_type_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_reference cairo_scaled_font_reference(cairo_scaled_font_t *scaled_font); //cairo_scaled_font_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_status cairo_scaled_font_status(cairo_scaled_font_t *scaled_font); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_antialias cairo_set_antialias(cairo_t *cr,cairo_antialias_t antialias); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_fill_rule cairo_set_fill_rule(cairo_t *cr,cairo_fill_rule_t fill_rule); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_font_face cairo_set_font_face(cairo_t *cr,cairo_font_face_t *font_face); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_font_size cairo_set_font_size(cairo_t *cr,double size); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_line_cap cairo_set_line_cap(cairo_t *cr,cairo_line_cap_t line_cap); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_line_join cairo_set_line_join(cairo_t *cr,cairo_line_join_t line_join); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_line_width cairo_set_line_width(cairo_t *cr,double width); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_miter_limit cairo_set_miter_limit(cairo_t *cr,double limit); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_operator cairo_set_operator(cairo_t *cr,cairo_operator_t op); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_source cairo_set_source(cairo_t *cr,cairo_pattern_t *source); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_source_rgb cairo_set_source_rgb(cairo_t *cr,double red,double green,double blue); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_tolerance cairo_set_tolerance(cairo_t *cr,double tolerance); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_show_glyphs cairo_show_glyphs(cairo_t *cr,const cairo_glyph_t *glyphs,int num_glyphs); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_show_page cairo_show_page(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_show_text cairo_show_text(cairo_t *cr,const char *utf8); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_status cairo_status(cairo_t *cr); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_status_to_string cairo_status_to_string(cairo_status_t status); //const char *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_stroke cairo_stroke(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_stroke_preserve cairo_stroke_preserve(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_stroke_to_path cairo_stroke_to_path(cairo_t *cr); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_copy_page cairo_surface_copy_page(cairo_surface_t *surface); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_destroy cairo_surface_destroy(cairo_surface_t *surface); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_finish cairo_surface_finish(cairo_surface_t *surface); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_flush cairo_surface_flush(cairo_surface_t *surface); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_content cairo_surface_get_content(cairo_surface_t *surface); //cairo_content_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_device cairo_surface_get_device(cairo_surface_t *surface); //cairo_device_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_reference_count cairo_surface_get_reference_count(cairo_surface_t *surface); //unsigned int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_type cairo_surface_get_type(cairo_surface_t *surface); //cairo_surface_type_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_has_show_text_glyphs cairo_surface_has_show_text_glyphs(cairo_surface_t *surface); //cairo_bool_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_mark_dirty cairo_surface_mark_dirty(cairo_surface_t *surface); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_observer_elapsed cairo_surface_observer_elapsed(cairo_surface_t *surface); //double<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_reference cairo_surface_reference(cairo_surface_t *surface); //cairo_surface_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_show_page cairo_surface_show_page(cairo_surface_t *surface); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_status cairo_surface_status(cairo_surface_t *surface); //cairo_status_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_text_cluster_allocate cairo_text_cluster_allocate(int num_clusters); //cairo_text_cluster_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_text_cluster_free cairo_text_cluster_free(cairo_text_cluster_t *clusters); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_text_path cairo_text_path(cairo_t *cr,const char *utf8); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_toy_font_face_get_family cairo_toy_font_face_get_family(cairo_font_face_t *font_face); //const char *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_toy_font_face_get_slant cairo_toy_font_face_get_slant(cairo_font_face_t *font_face); //cairo_font_slant_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_toy_font_face_get_weight cairo_toy_font_face_get_weight(cairo_font_face_t *font_face); //cairo_font_weight_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_translate cairo_translate(cairo_t *cr,double tx,double ty); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_create cairo_user_font_face_create(void); //cairo_font_face_t *<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_init_func cairo_user_font_face_get_init_func(cairo_font_face_t *font_face); //cairo_user_scaled_font_init_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_render_glyph_func cairo_user_font_face_get_render_glyph_func(cairo_font_face_t *font_face); //cairo_user_scaled_font_render_glyph_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_text_to_glyphs_func cairo_user_font_face_get_text_to_glyphs_func(cairo_font_face_t *font_face); //cairo_user_scaled_font_text_to_glyphs_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_unicode_to_glyph_func cairo_user_font_face_get_unicode_to_glyph_func(cairo_font_face_t *font_face); //cairo_user_scaled_font_unicode_to_glyph_func_t<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_to_device cairo_user_to_device(cairo_t *cr,double *x,double *y); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_to_device_distance cairo_user_to_device_distance(cairo_t *cr,double *dx,double *dy); //void<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_version cairo_version(void); //int<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_version_string cairo_version_string(void); //const char*<ESC>:normal0f(<CR>

" cairo-xcb.h defs
iabbrev <buffer> cairo_xcb_device_debug_cap_xrender_version cairo_xcb_device_debug_cap_xrender_version(cairo_device_t *device,int major_version,int minor_version); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_device_debug_cap_xshm_version cairo_xcb_device_debug_cap_xshm_version(cairo_device_t *device,int major_version,int minor_version); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_device_debug_get_precision cairo_xcb_device_debug_get_precision(cairo_device_t *device); //int<ESC>0f(<CR>
iabbrev <buffer> cairo_xcb_device_debug_set_precision cairo_xcb_device_debug_set_precision(cairo_device_t *device,int precision); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_device_get_connection cairo_xcb_device_get_connection(cairo_device_t *device); //xcb_connection_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_surface_create cairo_xcb_surface_create(xcb_connection_t *connection,xcb_drawable_t drawable,xcb_visualtype_t *visual,int width,int height); //cairo_surface_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_surface_create_for_bitmap cairo_xcb_surface_create_for_bitmap(xcb_connection_t *connection,xcb_screen_t *screen,xcb_pixmap_t bitmap,int width,int height); //cairo_surface_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_surface_create_with_xrender_format cairo_xcb_surface_create_with_xrender_format(xcb_connection_t *connection,xcb_screen_t *screen,xcb_drawable_t drawable,xcb_render_pictforminfo_t *format,int width,int height); //cairo_surface_t * <ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_surface_set_drawable cairo_xcb_surface_set_drawable(cairo_surface_t *surface,xcb_drawable_t drawable,int width,int height); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xcb_surface_set_size cairo_xcb_surface_set_size(cairo_surface_t *surface,int width,int height); //void<ESC>:normal 0f(<CR>

" cairo-xlib.h defs
iabbrev <buffer> cairo_xlib_device_debug_cap_xrender_version cairo_xlib_device_debug_cap_xrender_version(cairo_device_t *device,int major_version,int minor_version); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_device_debug_get_precision cairo_xlib_device_debug_get_precision(cairo_device_t *device); //int<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_device_debug_set_precision cairo_xlib_device_debug_set_precision(cairo_device_t *device,int precision); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_create cairo_xlib_surface_create(Display *dpy,Drawable drawable,Visual *visual,int width,int height); //cairo_surface_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_create_for_bitmap cairo_xlib_surface_create_for_bitmap(Display *dpy,Pixmap bitmap,Screen *screen,int width,int height); //cairo_surface_t *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_depth cairo_xlib_surface_get_depth(cairo_surface_t *surface); //int<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_display cairo_xlib_surface_get_display(cairo_surface_t *surface); //Display *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_drawable cairo_xlib_surface_get_drawable(cairo_surface_t *surface); //Drawable<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_height cairo_xlib_surface_get_height(cairo_surface_t *surface); //int<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_screen cairo_xlib_surface_get_screen(cairo_surface_t *surface); //Screen *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_visual cairo_xlib_surface_get_visual(cairo_surface_t *surface); //Visual *<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_get_width cairo_xlib_surface_get_width(cairo_surface_t *surface); //int<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_set_drawable cairo_xlib_surface_set_drawable(cairo_surface_t *surface,Drawable drawable,int width,int height); //void<ESC>:normal 0f(<CR>
iabbrev <buffer> cairo_xlib_surface_set_size cairo_xlib_surface_set_size(cairo_surface_t *surface,int width,int height); //void<ESC>:normal 0f(<CR>
