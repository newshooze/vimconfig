if exists("b:did_ftplugin")
  finish
endif

set errorformat=%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GInfile included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\, line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory `%f',%X%*\a[%*\d]: Leaving directory `%f',%D%*\a: Entering directory `%f',%X%*\a: Leaving directory `%f',%DMaking %*\a in %f,%f|%l| %m

set tags=~/.vim/doc/c/**/tags
set dict=~/.vim/ftplugin/c.vim
set complete+=k

let maplocalleader = ","
map <buffer> ( <Nop>
map <buffer> ) <Nop>

" Edit this file
nnoremap <buffer> <localleader>e :edit ~/.vim/ftplugin/c.vim<CR>

nnoremap <buffer> <localleader>x :view /usr/include/X11/Xlib.h<CR>

" Open quickfix list
nnoremap <buffer> <localleader>q :copen 5<CR>
" Open location list
nnoremap <buffer> <localleader>l :lopen 5<CR>
" Open command line history
nnoremap <buffer> <localleader>c :<C-F>
" Open forward search history
nnoremap <buffer> <localleader>/ /<C-F>
" Open reverse search history
nnoremap <buffer> <localleader>? ?<C-F>

nnoremap <buffer> <S-K> :tag <C-r><C-W><CR>
nnoremap <buffer> <C-K> :!man <C-r><C-W><CR> 
" Edit this file
nnoremap <buffer> <F3> <ESC>:source ~/.vim/ftplugin/c.vim<CR>

" Switch to header or source
nnoremap <buffer> <F4> <ESC>:e %:r.h<CR>
nnoremap <buffer> <S-F4> <ESC>:e %:r.c<CR>
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

nnoremap <buffer> <F10> :read ~/.vim/template/SDL2.vim<CR>gg^
nnoremap <buffer> <F11> :read ~/.vim/template/x11.vim<CR>gg^
nnoremap <buffer> <F12> :read ~/.vim/template/c.vim<CR>gg^

command! -buffer TemSDL2 :read ~/.vim/template/SDL2.vim
command! -buffer Temx11 :read ~/.vim/template/x11.vim
command! -buffer Tem :read ~/.vim/template/c.vim

function s:AVX() abort
	source ~/.vim/ftplugin/simd/xmmabbreviations.vim
	set dict+=~/.vim/ftplugin/simd/xmmabbreviations.vim
endfunction

command! -buffer AVX :call <SID>AVX()

" stdio.h
iabbrev <buffer> fgets fgets(buffer,size,FILE); /* char* */<ESC>?(<CR>
iabbrev <buffer> fgetc fgetc(FILE); /* int */<ESC>?(<CR>
iabbrev <buffer> fopen fopen("filename","r"); /* FILE* */<ESC>?(<CR>
iabbrev <buffer> fread fread(buffer,size,n,FILE); /* size_t */<ESC>?(<CR>
iabbrev <buffer> fwrite fwrite(buffer,size,n,FILE); /* size_t */<ESC>?(<CR>
iabbrev <buffer> fclose fclose(FILE); /* int */<ESC>?(<CR>
iabbrev <buffer> fseek fseek(FILE,offset,wence); /* int - wence is SEEK_SET,SEEK_CUR,SEEK_END */<ESC>?(<CR>
iabbrev <buffer> ftell ftell(FILE); /* long */<ESC>?(<CR>
iabbrev <buffer> rewind rewind(FILE); /* void */<ESC>?(<CR>
iabbrev <buffer> popen popen("command --args","r"); /* FILE* */<ESC>?(<CR>
iabbrev <buffer> pclose pclose(FILE); /* int */<ESC>?(<CR>
iabbrev <buffer> rewind rewind(FILE); /* void */<ESC>?(<CR>
iabbrev <buffer> printf printf("",); /* int */<ESC>?(<CR>
iabbrev <buffer> fprintf fprintf(FILE,format); /* int */<ESC>?(<CR>
iabbrev <buffer> sprintf sprintf(buffer,format); /* int */<ESC>?(<CR>
iabbrev <buffer> snprintf snprintf(buffer,size_t,format); /* int */<ESC>?(<CR>

" string.h
iabbrev <buffer> memcpy memcpy(dest,src,n); /* void */<ESC>?(<CR>
iabbrev <buffer> memmove memmove(dest,src,n); /* void */<ESC>?(<CR>
iabbrev <buffer> memccpy memccpy(dest,src,c,n); /* void */<ESC>?(<CR>
iabbrev <buffer> memset memset(dest,c,n); /* void */<ESC>?(<CR>
iabbrev <buffer> memcmp memcmp(s1,s2,n); /* int */<ESC>?(<CR>
iabbrev <buffer> memchr memchr(s,c,n); /* void* - Search N bytes of S for C. */<ESC>?(<CR>
iabbrev <buffer> rawmemchr rawmemchr(void*,c); /* void* */<ESC>?(<CR>
iabbrev <buffer> memrchr memrchr(s,c,n); /* void* - Search N bytes of S for the final occurrence of C. */<ESC>?(<CR>
iabbrev <buffer> strcpy strcpy(dest,src); /* char* */<ESC>?(<CR>
iabbrev <buffer> strncpy strncpy(dest,src,n); /* char* */<ESC>?(<CR>
iabbrev <buffer> strcat strcat(dest,src); /* char* */<ESC>?(<CR>
iabbrev <buffer> strncat strncat(dest,src,n); /* char* */<ESC>?(<CR>
iabbrev <buffer> strcmp strcmp(s1,s2); /* int */<ESC>?(<CR>
iabbrev <buffer> strncmp strncmp(s1,s2,n); /* int */<ESC>?(<CR>
iabbrev <buffer> strcoll strcoll(s1,s2); /* int - Compare the collated forms of S1 and S2. */<ESC>?(<CR>
iabbrev <buffer> strdup strdup(s); /* char* - Duplicate S, returning an identical malloc'd s */<ESC>?(<CR>
iabbrev <buffer> strndup strndup(s,n); /* char* - Return a malloc'd copy of at most N bytes of S. */<ESC>?<CR>
iabbrev <buffer> strchr strchr(s,c); /* char* */<ESC>?(<CR>
iabbrev <buffer> strchrnul strchrnul(s,c); /* char* */<ESC>?(<CR>
iabbrev <buffer> strcspn strcspn(s,c); /* size_t */<ESC>?(<CR>
iabbrev <buffer> strspn strspn(s,c); /* size_t */<ESC>?(<CR>
iabbrev <buffer> strpbrk strpbrk(s,c); /* char* - Find the first occurrence in S of any character in C. */<ESC>?(<CR>
iabbrev <buffer> strstr strstr(haystack,needle); /* char* */<ESC>?(<CR>
iabbrev <buffer> strtok strtok(s,delim); /* char* */<ESC>?(<CR>
iabbrev <buffer> strlen strlen(s); /* size_t */<ESC>?(<CR>
iabbrev <buffer> strerror strerror(int); /* char* */<ESC>?(<CR>
iabbrev <buffer> basename basename(filename); /* char* */<ESC>?(<CR>


" stdlib.h
iabbrev <buffer> aligned_alloc aligned_alloc(alignment,size); /* void* - ISOC11 */<ESC>?(<CR>
iabbrev <buffer> abort abort(); /* void */<ESC>?(<CR>
iabbrev <buffer> atexit atexit(void (*__func) (void)); /* int */<ESC>?(<CR> 
iabbrev <buffer> exit exit(int); /* void */<ESC>?(<CR>
iabbrev <buffer> getenv getenv(char*); /* char* */<ESC>?(<CR>
iabbrev <buffer> putenv putenv(char*); /* int */<ESC>?(<CR>
iabbrev <buffer> system system(char*); /* int */<ESC>?(<CR>
iabbrev <buffer> qsort qsort(base,member,size,function); /* void */<ESC>?(<CR>
iabbrev <buffer> abs abs(int); /* int */<ESC>?(<CR>
iabbrev <buffer> labs labs(long int); /* long int */<ESC>?(<CR>
iabbrev <buffer> div div(int,int); /* div_t */<ESC>?(<CR>
iabbrev <buffer> ldiv ldiv(long int,long int); /* ldiv_t */<ESC>?(<CR>

" time.h
iabbrev <buffer> clock clock(); /* clock_t */<ESC>?(<CR>
iabbrev <buffer> time time(time_t*) /* time_t */<ESC>?(<CR>
iabbrev <buffer> difftime difftime(time_t,time_t) /* double */<ESC>?(<CR>
iabbrev <buffer> mktime mktime(struct tm *tp) /* time_t */<ESC>?(<CR>
iabbrev <buffer> strftime strftime(char*,size_t,format,struct *tm); /* size_t */<ESC>?(<CR>
iabbrev <buffer> asctime asctime(struct tm*); /* char* */<ESC>?(<CR>
iabbrev <buffer> timer_create(colckid_t,struct sigevent*,timer_t*); /* int */<ESC>?(<CR>



" sys/mman.h memory mapping mmap
iabbrev <buffer> mmap mmap(void *addr,size_t len,int prot,int flags,int fd,off_t offset); /* void* */<ESC>?(<CR>
iabbrev <buffer> mmap64 mmap64(void *addr,size_t len,int prot,int flags,int fd,off64_t offset); /* void* */<ESC>?(<CR>
iabbrev <buffer> munmap munmap(void *addr,size_t len); /* 0(success) -1(error) */<ESC>?(<CR>
iabbrev <buffer> mlock mlock(const void *addr,size_t len); /* int */<ESC>?(<CR>
iabbrev <buffer> mprotect mprotect(void *addr,size_t len,int prot); /* 0(success) -1(error) */<ESC>?(<CR>
iabbrev <buffer> msync msync(void *addr,size_t len,int flags); /* int */<ESC>?(<CR>
iabbrev <buffer> madvise madvise(void *addr,size_t len,int advice); /* int */<ESC>?(<CR>
iabbrev <buffer> posix_madvise posix_madvise(void *addr,size_t len,int advice); /* int */<ESC>?(<CR>
iabbrev <buffer> munlock munlock(const void *addr,size_t len); /* int */<ESC>?(<CR>
iabbrev <buffer> mlockall mlockall(int flags); /* int */<ESC>?(<CR>
iabbrev <buffer> munlockall munlockall(); /* int */<ESC>?(<CR>
iabbrev <buffer> mincore mincore(void *start,size_t len,unsigned char *vec); /* int */<ESC>?(<CR>
iabbrev <buffer> mremap mremap (void *addr,size_t old_len,size_t new_len,int flags, ...); /* int */<ESC>?(<CR> 
iabbrev <buffer> shm_open shm_open (const char *name,int oflag,mode_t mode); /* int */<ESC>?(<CR>
iabbrev <buffer> shm_unlink shm_unlink(const char *name); /* int */<ESC>?(<CR>

" sys/ioctl.h
iabbrev <buffer> ioctl ioctl(int fd,unsigned long int request, void *data); /* int */<ESC>?(<CR>

" stdlib.h
"
" XRender defs
iabbrev <buffer> XRenderAddGlyphs XRenderAddGlyphs(display,GlyphSet	glyphset,_Xconst Glyph *gids,_Xconst XGlyphInfo	*glyphs,int nglyphs,_Xconst char*images,int nbyte_images); /* void */<ESC>?(<CR> 
iabbrev <buffer> XRenderAddTraps XRenderAddTraps(display,picture,xOff,yOff,XTrap*,ntrap); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderChangePicture XRenderChangePicture(display,picture,CP,XRenderPictureAttributes*); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeDoublePoly XRenderCompositeDoublePoly(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,xDst,yDst,XPointDouble*,npoint,int winding); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeString16 XRenderCompositeString16(display,PictOp,src,dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst unsigned short *string,int nchar); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeString32 XRenderCompositeString32(display,int op,Picture src,Picture dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst unsigned int *string,int nchar); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeString8 XRenderCompositeString8(display,int op,Picture src,Picture dst,*maskFormat,GlyphSet glyphset,int xSrc,int ySrc,int xDst,int yDst,_Xconst char *string,int nchar); /* void */<ESC>175<CR> 
iabbrev <buffer> XRenderCompositeText16 XRenderCompositeText16(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt16 *elts,int nelt); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeText32 XRenderCompositeText32(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt32 *elts,int nelt); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeText8 XRenderCompositeText8(display,int op,Picture src,Picture dst,*maskFormat,int xSrc,int ySrc,int xDst,int yDst,_Xconst XGlyphElt8 *elts,int nelt); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeTrapezoids XRenderCompositeTrapezoids(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,XTrapezoid*,ntrap); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeTriangles XRenderCompositeTriangles(display,PictOp,src,dest,XRenderPictFormat*,xsrc,ysrc,XTriangle*,ntriangle); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCompositeTriFan XRenderCompositeTriFan(display,PictOp,src,dst,XRenderPictFormat*,xSrc,ySrc,XPointFixed*,npoint); /* void */<ESC>?(<CR> 
iabbrev <buffer> XRenderCompositeTriStrip XRenderCompositeTriStrip(display,PictOp,src,dest,XRenderPictFormat*,xSrc,ySrc,XPointFixed*,npoint); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderComposite XRenderComposite(display,PictOp,src,mask,dst,src_x,src_y,mask_x,mask_y,dst_x,dst_y,width,height); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateAnimCursor XRenderCreateAnimCursor(display,int ncursor,XAnimCursor*cursors); /* Cursor */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateConicalGradient XRenderCreateConicalGradient(display,XConicalGradient*,XFixed *stops,XRenderColor *colors,int nstops); /* Picture */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateCursor XRenderCreateCursor(display,Picture source,unsigned int x,unsigned int y); /* Cursor */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateGlyphSet XRenderCreateGlyphSet(display,*format); /* GlyphSet */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateLinearGradient XRenderCreateLinearGradient(display,XLinearGradient*,XFixed *stops,XRenderColor* colors,int nstops); /* Picture */<ESC>?(<CR>
iabbrev <buffer> XRenderCreatePicture XRenderCreatePicture(display,Drawable,XRenderPictFormat,valuemask,XRenderPictureAttributes*); /* Picture */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateRadialGradient XRenderCreateRadialGradient(display,XRadialGradient*,XFixed *stops,XRenderColor *colors,int nstops); /* Picture */<ESC>?(<CR>
iabbrev <buffer> XRenderCreateSolidFill XRenderCreateSolidFill(display,XRenderColor*); /* Picture */<ESC>?(<CR>
iabbrev <buffer> XRenderFillRectangles XRenderFillRectangles(display,PictOp,dst,XRenderColor*,XRectangle*,n_rects); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderFillRectangle XRenderFillRectangle(display,PictOp,dst,XRenderColor*,x,y,width,height); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderFindFormat XRenderFindFormat(display,unsigned long mask,*templ,int count); /* XRenderPictFormat* */<ESC>?(<CR>
iabbrev <buffer> XRenderFindStandardFormat XRenderFindStandardFormat(display,PictStandardFormat); /* XRenderPictFormat* */<ESC>?(<CR>
iabbrev <buffer> XRenderFindVisualFormat XRenderFindVisualFormat(display,Visual*); /* XRenderPictFormat* */<ESC>?(<CR>
iabbrev <buffer> XRenderFreeGlyphSet XRenderFreeGlyphSet(display,GlyphSet glyphset); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderFreeGlyphs XRenderFreeGlyphs(display,GlyphSet glyphset,_Xconst Glyph *gids,int nglyphs); /* void */<ESC>?(<CR> 
iabbrev <buffer> XRenderFreePicture XRenderFreePicture(display,picture); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderParseColor XRenderParseColor(display,char *,XRenderColor*); /* Status */<ESC>?(<CR>
iabbrev <buffer> XRenderQueryExtension XRenderQueryExtension(display,int *event_basep,int *error_basep); /* Bool */<ESC>?(<CR> 
iabbrev <buffer> XRenderQueryFilters XRenderQueryFilters(display,drawable); /* XFilters* */<ESC>?(<CR> 
iabbrev <buffer> XRenderQueryFormats XRenderQueryFormats(display); /* Status */<ESC>?(<CR>
iabbrev <buffer> XRenderQueryPictIndexValues XRenderQueryPictIndexValues(display,	*format,int *num); /* XIndexValue* */<ESC>?(<CR>
iabbrev <buffer> XRenderQuerySubpixelOrder XRenderQuerySubpixelOrder(display,int screen); /* int */<ESC>?(<CR>
iabbrev <buffer> XRenderQueryVersion XRenderQueryVersion(display,int *major_versionp, int *minor_versionp); /* Status */<ESC>?(<CR>
iabbrev <buffer> XRenderReferenceGlyphSet XRenderReferenceGlyphSet(display,GlyphSet existing); /* GlyphSet */<ESC>?(<CR>
iabbrev <buffer> XRenderSetPictureClipRectangles XRenderSetPictureClipRectangles(display,Picture picture,int xOrigin,int yOrigin,_Xconst XRectangle *rects,int n); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderSetPictureClipRegion XRenderSetPictureClipRegion(display,Picture picture,Region r); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderSetPictureFilter XRenderSetPictureFilter(display,picture,char* filter,XFixed *params,int nparams); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderSetPictureTransform XRenderSetPictureTransform(display,picture,XTransform*); /* void */<ESC>?(<CR>
iabbrev <buffer> XRenderSetSubpixelOrder XRenderSetSubpixelOrder(display,screen,int subpixel); /* Bool */<ESC>?(<CR>

" Xft.h
iabbrev <buffer> XftCharExists XftCharExists(display,XftFont*pub,FcChar32ucs4); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftCharFontSpecRender XftCharFontSpecRender(display,intop,Picturesrc,Picturedst,intsrcx,intsrcy,_XconstXftCharFontSpec*chars,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftCharSpecRender XftCharSpecRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,_XconstXftCharSpec*chars,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftColorAllocName XftColorAllocName(display,_XconstVisual*visual,Colormapcmap,_Xconstchar*name,XftColor*result); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XftColorAllocValue XftColorAllocValue(display,Visual*visual,Colormapcmap,_XconstXRenderColor*color,XftColor*result); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XftColorFree XftColorFree(display,Visual*visual,Colormapcmap,XftColor*color); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDefaultHasRender XftDefaultHasRender(display); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XftDefaultSet XftDefaultSet(display,FcPattern*defaults); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XftDefaultSubstitute XftDefaultSubstitute(display,intscreen,FcPattern*pattern); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDirSave XftDirSave(FcFontSet*set,_Xconstchar*dir); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftDirScan XftDirScan(FcFontSet*set,_Xconstchar*dir,FcBoolforce); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftDrawChange XftDrawChange(XftDraw*draw,Drawabledrawable); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawCharFontSpec XftDrawCharFontSpec(XftDraw*draw,_XconstXftColor*color,_XconstXftCharFontSpec*chars,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawCharSpec XftDrawCharSpec(XftDraw*draw,_XconstXftColor*color,XftFont*pub,_XconstXftCharSpec*chars,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawColormap XftDrawColormap(XftDraw*draw); /* Colormap  */<ESC>?(<CR>
iabbrev <buffer> XftDrawCreateAlpha XftDrawCreateAlpha(display,Pixmappixmap,intdepth); /* XftDraw *  */<ESC>?(<CR>
iabbrev <buffer> XftDrawCreateBitmap XftDrawCreateBitmap(display,Pixmapbitmap); /* XftDraw *  */<ESC>?(<CR>
iabbrev <buffer> XftDrawCreate XftDrawCreate(display,Drawabledrawable,Visual*visual,Colormapcolormap); /* XftDraw *  */<ESC>?(<CR>
iabbrev <buffer> XftDrawDestroy XftDrawDestroy(XftDraw*draw); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawDisplay XftDrawDisplay(XftDraw*draw); /* Display *  */<ESC>?(<CR>
iabbrev <buffer> XftDrawDrawable XftDrawDrawable(XftDraw*draw); /* Drawable  */<ESC>?(<CR>
iabbrev <buffer> XftDrawGlyphFontSpec XftDrawGlyphFontSpec(XftDraw*draw,_XconstXftColor*color,_XconstXftGlyphFontSpec*glyphs,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawGlyphSpec XftDrawGlyphSpec(XftDraw*draw,_XconstXftColor*color,XftFont*pub,_XconstXftGlyphSpec*glyphs,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawGlyphs XftDrawGlyphs(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFT_UInt*glyphs,intnglyphs); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawPicture XftDrawPicture(XftDraw*draw); /* Picture  */<ESC>?(<CR>
iabbrev <buffer> XftDrawRect XftDrawRect(XftDraw*draw,_XconstXftColor*color,intx,inty,unsignedintwidth,unsignedintheight); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawSetClipRectangles XftDrawSetClipRectangles(XftDraw*draw,intxOrigin,intyOrigin,_XconstXRectangle*rects,intn); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XftDrawSetClip XftDrawSetClip(XftDraw*draw,Regionr); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XftDrawSetSubwindowMode XftDrawSetSubwindowMode(XftDraw*draw,intmode); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawSrcPicture XftDrawSrcPicture(XftDraw*draw,_XconstXftColor*color); /* Picture  */<ESC>?(<CR>
iabbrev <buffer> XftDrawString16 XftDrawString16(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar16*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawString32 XftDrawString32(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar32*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawString8 XftDrawString8(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawStringUtf16 XftDrawStringUtf16(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,FcEndianendian,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawStringUtf8 XftDrawStringUtf8(XftDraw*draw,_XconstXftColor*color,XftFont*pub,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftDrawVisual XftDrawVisual(XftDraw*draw); /* Visual *  */<ESC>?(<CR>
iabbrev <buffer> XftFontCheckGlyph XftFontCheckGlyph(display,XftFont*pub,FcBoolneed_bitmaps,FT_UIntglyph,FT_UInt*missing,int*nmissing); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftFontClose XftFontClose(display,XftFont*pub); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftFontCopy XftFontCopy(display,XftFont*pub); /* XftFont *  */<ESC>?(<CR>
iabbrev <buffer> XftFontInfoCreate XftFontInfoCreate(display,_XconstFcPattern*pattern); /* XftFontInfo *  */<ESC>?(<CR>
iabbrev <buffer> XftFontInfoDestroy XftFontInfoDestroy(display,XftFontInfo*fi); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftFontInfoEqual XftFontInfoEqual(_XconstXftFontInfo*a,_XconstXftFontInfo*b); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftFontInfoHash XftFontInfoHash(_XconstXftFontInfo*fi); /* FcChar32  */<ESC>?(<CR>
iabbrev <buffer> XftFontLoadGlyphs XftFontLoadGlyphs(display,XftFont*pub,FcBoolneed_bitmaps,_XconstFT_UInt*glyphs,intnglyph); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftFontMatch XftFontMatch(display,intscreen,_XconstFcPattern*pattern,FcResult*result); /* FcPattern *  */<ESC>?(<CR>
iabbrev <buffer> XftFontOpenInfo XftFontOpenInfo(display,FcPattern*pattern,XftFontInfo*fi); /* XftFont *  */<ESC>?(<CR>
iabbrev <buffer> XftFontOpenName XftFontOpenName(display,intscreen,_Xconstchar*name); /* XftFont *  */<ESC>?(<CR>
iabbrev <buffer> XftFontOpenPattern XftFontOpenPattern(display,FcPattern*pattern); /* XftFont *  */<ESC>?(<CR>
iabbrev <buffer> XftFontOpen XftFontOpen(display,intscreen,...)_X_SENTINEL(0); /* XftFont *  */<ESC>?(<CR>
iabbrev <buffer> XftFontOpenXlfd XftFontOpenXlfd(display,intscreen,_Xconstchar*xlfd); /* XftFont *  */<ESC>?(<CR>
iabbrev <buffer> XftFontUnloadGlyphs XftFontUnloadGlyphs(display,XftFont*pub,_XconstFT_UInt*glyphs,intnglyph); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftGlyphExtents XftGlyphExtents(display,XftFont*pub,_XconstFT_UInt*glyphs,intnglyphs,XGlyphInfo*extents); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftGlyphFontSpecRender XftGlyphFontSpecRender(display,intop,Picturesrc,Picturedst,intsrcx,intsrcy,_XconstXftGlyphFontSpec*glyphs,intnglyphs); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftGlyphRender XftGlyphRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFT_UInt*glyphs,intnglyphs); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftGlyphSpecRender XftGlyphSpecRender(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,_XconstXftGlyphSpec*glyphs,intnglyphs); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftInitFtLibrary XftInitFtLibrary(); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftInit XftInit(_Xconstchar*config); /* FcBool  */<ESC>?(<CR>
iabbrev <buffer> XftListFonts XftListFonts(display,intscreen,...)_X_SENTINEL(0); /* FcFontSet *  */<ESC>?(<CR>
iabbrev <buffer> XftLockFace XftLockFace(XftFont*pub); /* FT_Face  */<ESC>?(<CR>
iabbrev <buffer> XftTextExtents16 XftTextExtents16(display,XftFont*pub,_XconstFcChar16*string,intlen,XGlyphInfo*extents); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextExtents32 XftTextExtents32(display,XftFont*pub,_XconstFcChar32*string,intlen,XGlyphInfo*extents); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextExtents8 XftTextExtents8(display,XftFont*pub,_XconstFcChar8*string,intlen,XGlyphInfo*extents); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextExtentsUtf16 XftTextExtentsUtf16(display,XftFont*pub,_XconstFcChar8*string,FcEndianendian,intlen,XGlyphInfo*extents); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextExtentsUtf8 XftTextExtentsUtf8(display,XftFont*pub,_XconstFcChar8*string,intlen,XGlyphInfo*extents); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender16BE XftTextRender16BE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender16LE XftTextRender16LE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender16 XftTextRender16(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar16*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender32BE XftTextRender32BE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender32LE XftTextRender32LE(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender32 XftTextRender32(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar32*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRender8 XftTextRender8(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRenderUtf16 XftTextRenderUtf16(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,FcEndianendian,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftTextRenderUtf8 XftTextRenderUtf8(display,intop,Picturesrc,XftFont*pub,Picturedst,intsrcx,intsrcy,intx,inty,_XconstFcChar8*string,intlen); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftUnlockFace XftUnlockFace(XftFont*pub); /* void  */<ESC>?(<CR>
iabbrev <buffer> XftXlfdParse XftXlfdParse(_Xconstchar*xlfd_orig,Boolignore_scalable,Boolcomplete); /* FcPattern *  */<ESC>?(<CR>

" Xlib defs X11 x11 xlib
iabbrev <buffer> XActivateScreenSaver XActivateScreenSaver(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAddConnectionWatch XAddConnectionWatch(Display*,XConnectionWatchProc,XPointer); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XAddExtension XAddExtension(Display*); /* XExtCodes * */<ESC>?(<CR>
iabbrev <buffer> XAddHost XAddHost(Display*,XHostAddress*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAddHosts XAddHosts(Display*,XHostAddress*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAddToExtensionList XAddToExtensionList(struct _XExtData**,XExtData*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAddToSaveSet XAddToSaveSet(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAllPlanes XAllPlanes(); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XAllocColor XAllocColor(Display*,Colormap,XColor*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XAllocColorCells XAllocColorCells(Display*,Colormap,Bool ,unsigned long*,unsigned int,unsigned long*,unsigned int); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XAllocColorPlanes XAllocColorPlanes(Display*,Colormap,Bool,unsigned long*,int,int,int,int,unsigned long*,unsigned long*,unsigned long*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XAllocNamedColor XAllocNamedColor(Display*,Colormap,_Xconst char*,XColor*,XColor*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XAllowEvents XAllowEvents(Display*,int,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAutoRepeatOff XAutoRepeatOff(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XAutoRepeatOn XAutoRepeatOn(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XBaseFontNameListOfFontSet XBaseFontNameListOfFontSet(XFontSet); /* char * */<ESC>?(<CR>
iabbrev <buffer> XBell XBell(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XBitmapBitOrder XBitmapBitOrder(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XBitmapPad XBitmapPad(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XBitmapUnit XBitmapUnit(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XBlackPixel XBlackPixel(Display*,int); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XBlackPixelOfScreen XBlackPixelOfScreen(Screen*); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XCellsOfScreen XCellsOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeActivePointerGrab XChangeActivePointerGrab(Display*,unsigned int,Cursor,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeGC XChangeGC(Display*,GC,unsigned long,XGCValues*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeKeyboardControl XChangeKeyboardControl(Display*,unsigned long,XKeyboardControl*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeKeyboardMapping XChangeKeyboardMapping(Display*,int,int,KeySym*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangePointerControl XChangePointerControl(Display*,Bool,Bool,int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeProperty XChangeProperty(Display*,Window,Atom,Atom,int,int,_Xconst unsigned char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeSaveSet XChangeSaveSet(Display*,Window,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XChangeWindowAttributes XChangeWindowAttributes(Display*,Window,unsigned long,XSetWindowAttributes*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCheckIfEvent XCheckIfEvent(Display*,XEvent*,Bool(*)(Display*,XEvent*,XPointer),XPointer); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XCheckMaskEvent XCheckMaskEvent(Display*,long,XEvent*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XCheckTypedEvent XCheckTypedEvent(Display*,int,XEvent*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XCheckTypedWindowEvent XCheckTypedWindowEvent(Display*,Window,int,XEvent*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XCheckWindowEvent XCheckWindowEvent(Display*,Window,long,XEvent*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XCirculateSubwindows XCirculateSubwindows(Display*,Window,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCirculateSubwindowsDown XCirculateSubwindowsDown(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCirculateSubwindowsUp XCirculateSubwindowsUp(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XClearArea XClearArea(Display*,Window,int,int,unsigned int,unsigned int,Bool); /* int  */<ESC>?(<CR>
iabbrev <buffer> XClearWindow XClearWindow(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCloseDisplay XCloseDisplay(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCloseIM XCloseIM(XIM); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XCloseOM XCloseOM(XOM); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XConfigureWindow XConfigureWindow(Display*,Window,unsigned int,XWindowChanges*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XConnectionNumber XConnectionNumber(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XContextDependentDrawing XContextDependentDrawing(XFontSet); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XContextualDrawing XContextualDrawing(XFontSet); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XConvertSelection XConvertSelection(Display*,Atom,Atom ,Atom,Window,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCopyArea XCopyArea(Display*,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCopyColormapAndFree XCopyColormapAndFree(Display*,Colormap); /* Colormap  */<ESC>?(<CR>
iabbrev <buffer> XCopyGC XCopyGC(Display*,GC,unsigned long,GC); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCopyPlane XCopyPlane(Display*,Drawable,Drawable,GC,int,int,unsigned int,unsigned int,int,int,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XCreateBitmapFromData XCreateBitmapFromData(Display*,Drawable,_Xconst char*,unsigned int,unsigned int); /* Pixmap  */<ESC>?(<CR>
iabbrev <buffer> XCreateColormap XCreateColormap(Display*,Window,Visual*,int); /* Colormap  */<ESC>?(<CR>
iabbrev <buffer> XCreateFontCursor XCreateFontCursor(Display*,unsigned int); /* Cursor  */<ESC>?(<CR>
iabbrev <buffer> XCreateFontSet XCreateFontSet(Display*,_Xconst char*,char***,int*,char**); /* XFontSet  */<ESC>?(<CR>
iabbrev <buffer> XCreateGC XCreateGC(Display*,Drawable,unsigned long,XGCValues*); /* GC  */<ESC>?(<CR>
iabbrev <buffer> XCreateGlyphCursor XCreateGlyphCursor(Display*,Font,Font,unsigned int,unsigned int,XColor _Xconst *,XColor _Xconst *); /* Cursor  */<ESC>?(<CR>
iabbrev <buffer> XCreateIC XCreateIC(XIM ,...) _X_SENTINEL(0); /* XIC  */<ESC>?(<CR>
iabbrev <buffer> XCreateImage XCreateImage(Display*,Visual*,unsigned int,int,int,char*,unsigned int,unsigned int,int,int); /* XImage * */<ESC>?(<CR>
iabbrev <buffer> XCreateOC XCreateOC(XOM,...) _X_SENTINEL(0); /* XOC  */<ESC>?(<CR>
iabbrev <buffer> XCreatePixmap XCreatePixmap(Display*,Drawable,unsigned int,unsigned int,unsigned int); /* Pixmap  */<ESC>?(<CR>
iabbrev <buffer> XCreatePixmapCursor XCreatePixmapCursor(Display*,Pixmap,Pixmap,XColor*,XColor*,unsigned int,unsigned int); /* Cursor  */<ESC>?(<CR>
iabbrev <buffer> XCreatePixmapFromBitmapData XCreatePixmapFromBitmapData(Display*,Drawable,char*,unsigned int,unsigned int,unsigned long,unsigned long,unsigned int); /* Pixmap  */<ESC>?(<CR>
iabbrev <buffer> XCreateSimpleWindow XCreateSimpleWindow(Display*,Window,int,int,unsigned int,unsigned int,unsigned int,unsigned long,unsigned long); /* Window  */<ESC>?(<CR>
iabbrev <buffer> XCreateWindow XCreateWindow(Display*,Window,int,int,unsigned int,unsigned int,unsigned int,int,unsigned int,Visual*,unsigned long,XSetWindowAttributes*); /* Window  */<ESC>?(<CR>
iabbrev <buffer> XDefaultColormap XDefaultColormap(Display*,int); /* Colormap  */<ESC>?(<CR>
iabbrev <buffer> XDefaultColormapOfScreen XDefaultColormapOfScreen(Screen*); /* Colormap  */<ESC>?(<CR>
iabbrev <buffer> XDefaultDepth XDefaultDepth(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDefaultDepthOfScreen XDefaultDepthOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDefaultGC XDefaultGC(Display*,int); /* GC  */<ESC>?(<CR>
iabbrev <buffer> XDefaultGCOfScreen XDefaultGCOfScreen(Screen*); /* GC  */<ESC>?(<CR>
iabbrev <buffer> XDefaultRootWindow XDefaultRootWindow(Display*); /* Window  */<ESC>?(<CR>
iabbrev <buffer> XDefaultScreen XDefaultScreen(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDefaultScreenOfDisplay XDefaultScreenOfDisplay(Display*); /* Screen * */<ESC>?(<CR>
iabbrev <buffer> XDefaultVisual XDefaultVisual(Display*,int); /* Visual * */<ESC>?(<CR>
iabbrev <buffer> XDefaultVisualOfScreen XDefaultVisualOfScreen(Screen*); /* Visual * */<ESC>?(<CR>
iabbrev <buffer> XDefineCursor XDefineCursor(Display*,Window,Cursor); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDeleteModifiermapEntry XDeleteModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int); /* XModifierKeymap * */<ESC>?(<CR>
iabbrev <buffer> XDeleteProperty XDeleteProperty(Display*,Window,Atom); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDestroyIC XDestroyIC(XIC); /* void  */<ESC>?(<CR>
iabbrev <buffer> XDestroyOC XDestroyOC(XOC); /* void  */<ESC>?(<CR>
iabbrev <buffer> XDestroySubwindows XDestroySubwindows(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDestroyWindow XDestroyWindow(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDirectionalDependentDrawing XDirectionalDependentDrawing(XFontSet); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XDisableAccessControl XDisableAccessControl(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayCells XDisplayCells(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayHeight XDisplayHeight(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayHeightMM XDisplayHeightMM(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayKeycodes XDisplayKeycodes(Display*,int*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayMotionBufferSize XDisplayMotionBufferSize(Display*); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XDisplayName XDisplayName(_Xconst char*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XDisplayOfIM XDisplayOfIM(XIM); /* Display * */<ESC>?(<CR>
iabbrev <buffer> XDisplayOfOM XDisplayOfOM(XOM); /* Display * */<ESC>?(<CR>
iabbrev <buffer> XDisplayOfScreen XDisplayOfScreen(Screen*); /* Display * */<ESC>?(<CR>
iabbrev <buffer> XDisplayPlanes XDisplayPlanes(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayString XDisplayString(Display*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XDisplayWidth XDisplayWidth(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDisplayWidthMM XDisplayWidthMM(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDoesBackingStore XDoesBackingStore(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDoesSaveUnders XDoesSaveUnders(Screen*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XDrawArc XDrawArc(Display*,Drawable,GC,int,int,unsigned int,unsigned int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawArcs XDrawArcs(Display*,Drawable,GC,XArc*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawImageString XDrawImageString(Display*,Drawable,GC,int,int,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawImageString16 XDrawImageString16(Display*,Drawable,GC,int,int,_Xconst XChar2b*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawLine XDrawLine(Display*,Drawable,GC,int,int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawLines XDrawLines(Display*,Drawable,GC,XPoint*,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawPoint XDrawPoint(Display*,Drawable,GC,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawPoints XDrawPoints(Display*,Drawable,GC,XPoint*,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawRectangle XDrawRectangle(Display*,Drawable,GC,int,int,unsigned int,unsigned int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawRectangles XDrawRectangles(Display*,Drawable,GC,XRectangle*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawSegments XDrawSegments(Display*,Drawable,GC,XSegment*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawString XDrawString(Display*,Drawable,GC,int,int,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawString16 XDrawString16(Display*,Drawable,GC,int,int,_Xconst XChar2b*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawText XDrawText(Display*,Drawable,GC,int,int,XTextItem*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XDrawText16 XDrawText16(Display*,Drawable,GC,int,int,XTextItem16*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XEHeadOfExtensionList XEHeadOfExtensionList(XEDataObject); /* XExtData ** */<ESC>?(<CR>
iabbrev <buffer> XEnableAccessControl XEnableAccessControl(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XEventMaskOfScreen XEventMaskOfScreen(Screen*); /* long  */<ESC>?(<CR>
iabbrev <buffer> XEventsQueued XEventsQueued(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XExtendedMaxRequestSize XExtendedMaxRequestSize(Display*); /* long  */<ESC>?(<CR>
iabbrev <buffer> XExtentsOfFontSet XExtentsOfFontSet(XFontSet); /* XFontSetExtents * */<ESC>?(<CR>
iabbrev <buffer> XFetchBuffer XFetchBuffer(Display*,int*,int); /* char * */<ESC>?(<CR>
iabbrev <buffer> XFetchBytes XFetchBytes(Display*,int*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XFetchName XFetchName(Display*,Window,char**); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XFillArc XFillArc(Display*,Drawable,GC,int,int,unsigned int,unsigned int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFillArcs XFillArcs(Display*,Drawable,GC,XArc*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFillPolygon XFillPolygon(Display*,Drawable,GC,XPoint*,int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFillRectangle XFillRectangle(Display*,Drawable,GC,int,int,unsigned int,unsigned int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFillRectangles XFillRectangles(Display*,Drawable,GC,XRectangle*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFilterEvent XFilterEvent(XEvent*,Window); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XFindOnExtensionList XFindOnExtensionList(XExtData**,int); /* XExtData * */<ESC>?(<CR>
iabbrev <buffer> XFlush XFlush(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFlushGC XFlushGC(Display*,GC); /* void  */<ESC>?(<CR>
iabbrev <buffer> XFontsOfFontSet XFontsOfFontSet(XFontSet,XFontStruct***,char***); /* int  */<ESC>?(<CR>
iabbrev <buffer> XForceScreenSaver XForceScreenSaver(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFree XFree(void*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeColormap XFreeColormap(Display*,Colormap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeColors XFreeColors(Display*,Colormap,unsigned long*,int,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeCursor XFreeCursor(Display*,Cursor); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeEventData XFreeEventData(Display*,XGenericEventCookie*); /* void  */<ESC>?(<CR>
iabbrev <buffer> XFreeExtensionList XFreeExtensionList(char**); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeFont XFreeFont(Display*,XFontStruct*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeFontInfo XFreeFontInfo(char**,XFontStruct*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeFontNames XFreeFontNames(char**); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeFontPath XFreeFontPath(char**); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeFontSet XFreeFontSet(Display*,XFontSet); /* void  */<ESC>?(<CR>
iabbrev <buffer> XFreeGC XFreeGC(Display*,GC); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeModifiermap XFreeModifiermap(XModifierKeymap*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreePixmap XFreePixmap(Display*,Pixmap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XFreeStringList XFreeStringList(char**); /* void  */<ESC>?(<CR>
iabbrev <buffer> XGContextFromGC XGContextFromGC(GC); /* GContext  */<ESC>?(<CR>
iabbrev <buffer> XGeometry XGeometry(Display*,int,_Xconst char*,_Xconst char*,unsigned int,unsigned int,unsigned int,int,int,int*,int*,int*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetAtomName XGetAtomName(Display*,Atom); /* char * */<ESC>?(<CR>
iabbrev <buffer> XGetAtomNames XGetAtomNames(Display*,Atom*,int,char**); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetCommand XGetCommand(Display*,Window,char***,int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetDefault XGetDefault(Display*,_Xconst char*,_Xconst char*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XGetErrorDatabaseText XGetErrorDatabaseText(Display*,_Xconst char*,_Xconst char*,_Xconst char*,char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetErrorText XGetErrorText(Display*,int,char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetEventData XGetEventData(Display*,XGenericEventCookie*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XGetFontPath XGetFontPath(Display*,int*); /* char ** */<ESC>?(<CR>
iabbrev <buffer> XGetFontProperty XGetFontProperty(XFontStruct*,Atom,unsigned long*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XGetGCValues XGetGCValues(Display*,GC,unsigned long,XGCValues*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetGeometry XGetGeometry(Display*,Drawable,Window*,int*,int*,unsigned int*,unsigned int*,unsigned int*,unsigned int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetICValues XGetICValues(XIC ,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XGetIMValues XGetIMValues(XIM ,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XGetIconName XGetIconName(Display*,Window,char**); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetImage XGetImage(Display*,Drawable,int,int,unsigned int,unsigned int,unsigned long,int); /* XImage * */<ESC>?(<CR>
iabbrev <buffer> XGetInputFocus XGetInputFocus(Display*,Window*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetKeyboardControl XGetKeyboardControl(Display*,XKeyboardState*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetKeyboardMapping XGetKeyboardMapping(Display*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int,int*); /* KeySym * */<ESC>?(<CR>
iabbrev <buffer> XGetModifierMapping XGetModifierMapping(Display*); /* XModifierKeymap * */<ESC>?(<CR>
iabbrev <buffer> XGetMotionEvents XGetMotionEvents(Display*,Window,Time,Time,int*); /* XTimeCoord * */<ESC>?(<CR>
iabbrev <buffer> XGetOCValues XGetOCValues(XOC,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XGetOMValues XGetOMValues(XOM,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XGetPointerControl XGetPointerControl(Display*,int*,int*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetPointerMapping XGetPointerMapping(Display*,unsigned char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetScreenSaver XGetScreenSaver(Display*,int*,int*,int*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGetSelectionOwner XGetSelectionOwner(Display*,Atom); /* Window  */<ESC>?(<CR>
iabbrev <buffer> XGetSubImage XGetSubImage(Display*,Drawable,int,int,unsigned int,unsigned int,unsigned long,int,XImage*,int,int); /* XImage * */<ESC>?(<CR>
iabbrev <buffer> XGetTransientForHint XGetTransientForHint(Display*,Window,Window*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetWMColormapWindows XGetWMColormapWindows(Display*,Window,Window**,int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetWMProtocols XGetWMProtocols(Display*,Window,Atom**,int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetWindowAttributes XGetWindowAttributes(Display*,Window,XWindowAttributes*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XGetWindowProperty XGetWindowProperty(Display*,Window,Atom,long,long,Bool,Atom,Atom*,int*,unsigned long*,unsigned long*,unsigned char**); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGrabButton XGrabButton(Display*,unsigned int,unsigned int,Window,Bool,unsigned int,int,int,Window,Cursor); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGrabKey XGrabKey(Display*,int,unsigned int,Window,Bool,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGrabKeyboard XGrabKeyboard(Display*,Window,Bool,int,int,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGrabPointer XGrabPointer(Display*,Window,Bool,unsigned int,int,int,Window,Cursor,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XGrabServer XGrabServer(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XHeightMMOfScreen XHeightMMOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XHeightOfScreen XHeightOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XIMOfIC XIMOfIC(XIC); /* XIM  */<ESC>?(<CR>
iabbrev <buffer> XIconifyWindow XIconifyWindow(Display*,Window,int); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XIfEvent XIfEvent(Display*,XEvent*,Bool(*)(Display*,XEvent*,XPointer),XPointer); /* int  */<ESC>?(<CR>
iabbrev <buffer> XImageByteOrder XImageByteOrder(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XInitExtension XInitExtension(Display*,_Xconst char*); /* XExtCodes * */<ESC>?(<CR>
iabbrev <buffer> XInitImage XInitImage(XImage*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XInitThreads XInitThreads(); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XInsertModifiermapEntry XInsertModifiermapEntry(XModifierKeymap*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int); /* XModifierKeymap * */<ESC>?(<CR>
iabbrev <buffer> XInstallColormap XInstallColormap(Display*,Colormap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XInternAtom XInternAtom(Display*,_Xconst char*,Bool); /* Atom  */<ESC>?(<CR>
iabbrev <buffer> XInternAtoms XInternAtoms(Display*,char**,int,Bool,Atom*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XInternalConnectionNumbers XInternalConnectionNumbers(Display*,int**,int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XKeycodeToKeysym XKeycodeToKeysym(Display*,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int); /* KeySym  */<ESC>?(<CR>
iabbrev <buffer> XKeysymToKeycode XKeysymToKeycode(Display*,KeySym); /* KeyCode  */<ESC>?(<CR>
iabbrev <buffer> XKeysymToString XKeysymToString(KeySym); /* char * */<ESC>?(<CR>
iabbrev <buffer> XKillClient XKillClient(Display*,XID); /* int  */<ESC>?(<CR>
iabbrev <buffer> XLastKnownRequestProcessed XLastKnownRequestProcessed(Display*); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XListDepths XListDepths(Display*,int,int*); /* int * */<ESC>?(<CR>
iabbrev <buffer> XListExtensions XListExtensions(Display*,int*); /* char ** */<ESC>?(<CR>
iabbrev <buffer> XListFonts XListFonts(Display*,_Xconst char*,int,int*); /* char ** */<ESC>?(<CR>
iabbrev <buffer> XListFontsWithInfo XListFontsWithInfo(Display*,_Xconst char*,int,int*,XFontStruct**); /* char ** */<ESC>?(<CR>
iabbrev <buffer> XListHosts XListHosts(Display*,int*,Bool*); /* XHostAddress * */<ESC>?(<CR>
iabbrev <buffer> XListInstalledColormaps XListInstalledColormaps(Display*,Window,int*); /* Colormap * */<ESC>?(<CR>
iabbrev <buffer> XListPixmapFormats XListPixmapFormats(Display*,int*); /* XPixmapFormatValues * */<ESC>?(<CR>
iabbrev <buffer> XListProperties XListProperties(Display*,Window,int*); /* Atom * */<ESC>?(<CR>
iabbrev <buffer> XLoadFont XLoadFont(Display*,_Xconst char*); /* Font  */<ESC>?(<CR>
iabbrev <buffer> XLoadQueryFont XLoadQueryFont(Display*,_Xconst char*); /* XFontStruct * */<ESC>?(<CR>
iabbrev <buffer> XLocaleOfFontSet XLocaleOfFontSet(XFontSet); /* char * */<ESC>?(<CR>
iabbrev <buffer> XLocaleOfIM XLocaleOfIM(XIM); /* char * */<ESC>?(<CR>
iabbrev <buffer> XLocaleOfOM XLocaleOfOM(XOM); /* char * */<ESC>?(<CR>
iabbrev <buffer> XLockDisplay XLockDisplay(Display*); /* void  */<ESC>?(<CR>
iabbrev <buffer> XLookupColor XLookupColor(Display*,Colormap,_Xconst char*,XColor*,XColor*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XLookupKeysym XLookupKeysym(XKeyEvent*,int); /* KeySym  */<ESC>?(<CR>
iabbrev <buffer> XLowerWindow XLowerWindow(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMapRaised XMapRaised(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMapSubwindows XMapSubwindows(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMapWindow XMapWindow(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMaskEvent XMaskEvent(Display*,long,XEvent*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMaxCmapsOfScreen XMaxCmapsOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMaxRequestSize XMaxRequestSize(Display*); /* long  */<ESC>?(<CR>
iabbrev <buffer> XMinCmapsOfScreen XMinCmapsOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMoveResizeWindow XMoveResizeWindow(Display*,Window,int,int,unsigned int,unsigned int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XMoveWindow XMoveWindow(Display*,Window,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XNewModifiermap XNewModifiermap(int); /* XModifierKeymap * */<ESC>?(<CR>
iabbrev <buffer> XNextEvent XNextEvent(Display*,XEvent*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XNextRequest XNextRequest(Display*); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XNoOp XNoOp(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XOMOfOC XOMOfOC(XOC); /* XOM  */<ESC>?(<CR>
iabbrev <buffer> XOpenDisplay XOpenDisplay(_Xconst char*); /* Display * */<ESC>?(<CR>
iabbrev <buffer> XOpenIM XOpenIM(Display*,struct _XrmHashBucketRec*,char*,char*); /* XIM  */<ESC>?(<CR>
iabbrev <buffer> XOpenOM XOpenOM(Display*,struct _XrmHashBucketRec*,_Xconst char*,_Xconst char*); /* XOM  */<ESC>?(<CR>
iabbrev <buffer> XParseColor XParseColor(Display*,Colormap,_Xconst char*,XColor*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XParseGeometry XParseGeometry(_Xconst char*,int*,int*,unsigned int*,unsigned int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XPeekEvent XPeekEvent(Display*,XEvent*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XPeekIfEvent XPeekIfEvent(Display*,XEvent*,Bool(*)(Display*,XEvent*,XPointer),XPointer); /* int  */<ESC>?(<CR>
iabbrev <buffer> XPending XPending(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XPlanesOfScreen XPlanesOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XProcessInternalConnection XProcessInternalConnection(Display*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XProtocolRevision XProtocolRevision(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XProtocolVersion XProtocolVersion(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XPutBackEvent XPutBackEvent(Display*,XEvent*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XPutImage XPutImage(Display*,Drawable,GC,XImage*,int,int,int,int,unsigned int,unsigned int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQLength XQLength(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQueryBestCursor XQueryBestCursor(Display*,Drawable,unsigned int ,unsigned int,unsigned int*,unsigned int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XQueryBestSize XQueryBestSize(Display*,int,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XQueryBestStipple XQueryBestStipple(Display*,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XQueryBestTile XQueryBestTile(Display*,Drawable,unsigned int,unsigned int,unsigned int*,unsigned int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XQueryColor XQueryColor(Display*,Colormap,XColor*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQueryColors XQueryColors(Display*,Colormap,XColor*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQueryExtension XQueryExtension(Display*,_Xconst char*,int*,int*,int*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XQueryFont XQueryFont(Display*,XID); /* XFontStruct * */<ESC>?(<CR>
iabbrev <buffer> XQueryKeymap XQueryKeymap(Display*,char [32]); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQueryPointer XQueryPointer(Display*,Window,Window*,Window*,int*,int*,int*,int*,unsigned int*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XQueryTextExtents XQueryTextExtents(Display*,XID,_Xconst char*,int,int*,int*,int*,XCharStruct*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQueryTextExtents16 XQueryTextExtents16(Display*,XID,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XQueryTree XQueryTree(Display*,Window,Window*,Window*,Window**,unsigned int*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XRaiseWindow XRaiseWindow(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XReadBitmapFile XReadBitmapFile(Display*,Drawable ,_Xconst char*,unsigned int*,unsigned int*,Pixmap*,int*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XReadBitmapFileData XReadBitmapFileData(_Xconst char*,unsigned int*,unsigned int*,unsigned char**,int*,int*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRebindKeysym XRebindKeysym(Display*,KeySym,KeySym*,int,_Xconst unsigned char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRecolorCursor XRecolorCursor(Display*,Cursor,XColor*,XColor*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XReconfigureWMWindow XReconfigureWMWindow(Display*,Window,int,unsigned int,XWindowChanges*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XRefreshKeyboardMapping XRefreshKeyboardMapping(XMappingEvent*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRegisterIMInstantiateCallback XRegisterIMInstantiateCallback(Display*,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XRemoveConnectionWatch XRemoveConnectionWatch(Display*,XConnectionWatchProc,XPointer); /* void  */<ESC>?(<CR>
iabbrev <buffer> XRemoveFromSaveSet XRemoveFromSaveSet(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRemoveHost XRemoveHost(Display*,XHostAddress*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRemoveHosts XRemoveHosts(Display*,XHostAddress*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XReparentWindow XReparentWindow(Display*,Window,Window,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XResetScreenSaver XResetScreenSaver(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XResizeWindow XResizeWindow(Display*,Window,unsigned int,unsigned int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XResourceManagerString XResourceManagerString(Display*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XRestackWindows XRestackWindows(Display*,Window*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRootWindow XRootWindow(Display*,int); /* Window  */<ESC>?(<CR>
iabbrev <buffer> XRootWindowOfScreen XRootWindowOfScreen(Screen*); /* Window  */<ESC>?(<CR>
iabbrev <buffer> XRotateBuffers XRotateBuffers(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XRotateWindowProperties XRotateWindowProperties(Display*,Window,Atom*,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XScreenCount XScreenCount(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XScreenNumberOfScreen XScreenNumberOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XScreenOfDisplay XScreenOfDisplay(Display*,int); /* Screen * */<ESC>?(<CR>
iabbrev <buffer> XScreenResourceString XScreenResourceString(Screen*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSelectInput XSelectInput(Display*,Window,long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSendEvent XSendEvent(Display*,Window,Bool,long,XEvent*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XServerVendor XServerVendor(Display*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSetAccessControl XSetAccessControl(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetAfterFunction int(*XSetAfterFunction(Display*,int(*)(Display*)))(Display*);<ESC>?(<CR>
iabbrev <buffer> XSetArcMode XSetArcMode(Display*,GC,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetAuthorization XSetAuthorization(char *,int,char *,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XSetBackground XSetBackground(Display*,GC,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetClipMask XSetClipMask(Display*,GC,Pixmap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetClipOrigin XSetClipOrigin(Display*,GC,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetClipRectangles XSetClipRectangles(Display*,GC,int,int,XRectangle*,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetCloseDownMode XSetCloseDownMode(Display*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetCommand XSetCommand(Display*,Window,char**,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetDashes XSetDashes(Display*,GC,int,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetErrorHandler XSetErrorHandler (XErrorHandler); /* XErrorHandler  */<ESC>?(<CR>
iabbrev <buffer> XSetFillRule XSetFillRule(Display*,GC,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetFillStyle XSetFillStyle(Display*,GC,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetFont XSetFont(Display*,GC,Font); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetFontPath XSetFontPath(Display*,char**,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetForeground XSetForeground(Display*,GC,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetFunction XSetFunction(Display*,GC,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetGraphicsExposures XSetGraphicsExposures(Display*,GC,Bool); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetICFocus XSetICFocus(XIC); /* void  */<ESC>?(<CR>
iabbrev <buffer> XSetICValues XSetICValues(XIC ,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSetIMValues XSetIMValues(XIM ,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSetIOErrorExitHandler XSetIOErrorExitHandler (Display*,XIOErrorExitHandler,void*); /* void  */<ESC>?(<CR>
iabbrev <buffer> XSetIOErrorHandler XSetIOErrorHandler (XIOErrorHandler); /* XIOErrorHandler  */<ESC>?(<CR>
iabbrev <buffer> XSetIconName XSetIconName(Display*,Window,_Xconst char*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetInputFocus XSetInputFocus(Display*,Window,int,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetLineAttributes XSetLineAttributes(Display*,GC,unsigned int,int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetLocaleModifiers XSetLocaleModifiers(const char*); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSetModifierMapping XSetModifierMapping(Display*,XModifierKeymap*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetOCValues XSetOCValues(XOC,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSetOMValues XSetOMValues(XOM,...) _X_SENTINEL(0); /* char * */<ESC>?(<CR>
iabbrev <buffer> XSetPlaneMask XSetPlaneMask(Display*,GC,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetPointerMapping XSetPointerMapping(Display*,_Xconst unsigned char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetScreenSaver XSetScreenSaver(Display*,int,int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetSelectionOwner XSetSelectionOwner(Display*,Atom ,Window,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetState XSetState(Display*,GC,unsigned long ,unsigned long,int,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetStipple XSetStipple(Display*,GC,Pixmap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetSubwindowMode XSetSubwindowMode(Display*,GC,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetTSOrigin XSetTSOrigin(Display*,GC,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetTile XSetTile(Display*,GC,Pixmap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetTransientForHint XSetTransientForHint(Display*,Window,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetWMColormapWindows XSetWMColormapWindows(Display*,Window,Window*,int); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XSetWMProtocols XSetWMProtocols(Display*,Window,Atom*,int); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XSetWindowBackground XSetWindowBackground(Display*,Window,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetWindowBackgroundPixmap XSetWindowBackgroundPixmap(Display*,Window,Pixmap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetWindowBorder XSetWindowBorder(Display*,Window,unsigned long); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetWindowBorderPixmap XSetWindowBorderPixmap(Display*,Window,Pixmap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetWindowBorderWidth XSetWindowBorderWidth(Display*,Window,unsigned int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSetWindowColormap XSetWindowColormap(Display*,Window,Colormap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStoreBuffer XStoreBuffer(Display*,_Xconst char*,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStoreBytes XStoreBytes(Display*,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStoreColor XStoreColor(Display*,Colormap,XColor*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStoreColors XStoreColors(Display*,Colormap,XColor*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStoreName XStoreName(Display*,Window,_Xconst char*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStoreNamedColor XStoreNamedColor(Display*,Colormap,_Xconst char*,unsigned long,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XStringToKeysym XStringToKeysym(_Xconst char*); /* KeySym  */<ESC>?(<CR>
iabbrev <buffer> XSupportsLocale XSupportsLocale (); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XSync XSync(Display*,Bool); /* int  */<ESC>?(<CR>
iabbrev <buffer> XSynchronize int(*XSynchronize(Display*,Bool))(Display*);<ESC>?(<CR>
iabbrev <buffer> XTextExtents XTextExtents(XFontStruct*,_Xconst char*,int,int*,int*,int*,XCharStruct*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XTextExtents16 XTextExtents16(XFontStruct*,_Xconst XChar2b*,int,int*,int*,int*,XCharStruct*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XTextWidth XTextWidth(XFontStruct*,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XTextWidth16 XTextWidth16(XFontStruct*,_Xconst XChar2b*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XTranslateCoordinates XTranslateCoordinates(Display*,Window,Window,int,int,int*,int*,Window*); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XUndefineCursor XUndefineCursor(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUngrabButton XUngrabButton(Display*,unsigned int,unsigned int,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUngrabKey XUngrabKey(Display*,int,unsigned int,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUngrabKeyboard XUngrabKeyboard(Display*,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUngrabPointer XUngrabPointer(Display*,Time); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUngrabServer XUngrabServer(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUninstallColormap XUninstallColormap(Display*,Colormap); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUnloadFont XUnloadFont(Display*,Font); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUnlockDisplay XUnlockDisplay(Display*); /* void  */<ESC>?(<CR>
iabbrev <buffer> XUnmapSubwindows XUnmapSubwindows(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUnmapWindow XUnmapWindow(Display*,Window); /* int  */<ESC>?(<CR>
iabbrev <buffer> XUnregisterIMInstantiateCallback XUnregisterIMInstantiateCallback(Display*,struct _XrmHashBucketRec*,char*,char*,XIDProc,XPointer); /* Bool  */<ESC>?(<CR>
iabbrev <buffer> XUnsetICFocus XUnsetICFocus(XIC); /* void  */<ESC>?(<CR>
iabbrev <buffer> XVaCreateNestedList XVaCreateNestedList(int ,...) _X_SENTINEL(0); /* XVaNestedList  */<ESC>?(<CR>
iabbrev <buffer> XVendorRelease XVendorRelease(Display*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XVisualIDFromVisual XVisualIDFromVisual(Visual*); /* VisualID  */<ESC>?(<CR>
iabbrev <buffer> XWarpPointer XWarpPointer(Display*,Window,Window,int,int,unsigned int,unsigned int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XWhitePixel XWhitePixel(Display*,int); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XWhitePixelOfScreen XWhitePixelOfScreen(Screen*); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> XWidthMMOfScreen XWidthMMOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XWidthOfScreen XWidthOfScreen(Screen*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XWindowEvent XWindowEvent(Display*,Window,long,XEvent*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XWithdrawWindow XWithdrawWindow(Display*,Window,int); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XWriteBitmapFile XWriteBitmapFile(Display*,_Xconst char*,Pixmap,unsigned int,unsigned int,int,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XmbDrawImageString XmbDrawImageString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XmbDrawString XmbDrawString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XmbDrawText XmbDrawText(Display*,Drawable,GC,int,int,XmbTextItem*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XmbLookupString XmbLookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XmbResetIC XmbResetIC(XIC); /* char * */<ESC>?(<CR>
iabbrev <buffer> XmbTextEscapement XmbTextEscapement(XFontSet,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XmbTextExtents XmbTextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XmbTextPerCharExtents XmbTextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XrmInitialize XrmInitialize(); /* void  */<ESC>?(<CR>
iabbrev <buffer> Xutf8DrawImageString Xutf8DrawImageString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> Xutf8DrawString Xutf8DrawString(Display*,Drawable,XFontSet,GC,int,int,_Xconst char*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> Xutf8DrawText Xutf8DrawText(Display*,Drawable,GC,int,int,XmbTextItem*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> Xutf8LookupString Xutf8LookupString(XIC,XKeyPressedEvent*,char*,int,KeySym*,Status*); /* int  */<ESC>?(<CR>
iabbrev <buffer> Xutf8ResetIC Xutf8ResetIC(XIC); /* char * */<ESC>?(<CR>
iabbrev <buffer> Xutf8TextEscapement Xutf8TextEscapement(XFontSet,_Xconst char*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> Xutf8TextExtents Xutf8TextExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*); /* int  */<ESC>?(<CR>
iabbrev <buffer> Xutf8TextPerCharExtents Xutf8TextPerCharExtents(XFontSet,_Xconst char*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> XwcDrawImageString XwcDrawImageString(Display*,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XwcDrawString XwcDrawString(Display*,Drawable,XFontSet,GC,int,int,_Xconst wchar_t*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XwcDrawText XwcDrawText(Display*,Drawable,GC,int,int,XwcTextItem*,int); /* void  */<ESC>?(<CR>
iabbrev <buffer> XwcLookupString XwcLookupString(XIC,XKeyPressedEvent*,wchar_t*,int,KeySym*,Status*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XwcResetIC XwcResetIC(XIC); /* wchar_t * */<ESC>?(<CR>
iabbrev <buffer> XwcTextEscapement XwcTextEscapement(XFontSet,_Xconst wchar_t*,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> XwcTextExtents XwcTextExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*); /* int  */<ESC>?(<CR>
iabbrev <buffer> XwcTextPerCharExtents XwcTextPerCharExtents(XFontSet,_Xconst wchar_t*,int,XRectangle*,XRectangle*,int,int*,XRectangle*,XRectangle*); /* Status  */<ESC>?(<CR>
iabbrev <buffer> _Xmblen _Xmblen(char *str,int len); /* int  */<ESC>?(<CR>
iabbrev <buffer> _Xmbtowc _Xmbtowc(wchar_t *,char *,int); /* int  */<ESC>?(<CR>
iabbrev <buffer> _Xwctomb _Xwctomb(char *,wchar_t); /* int  */<ESC>?(<CR>

"XKBlib.h xkblib XKBlib
iabbrev <buffer> XkbTranslateKeySym XkbTranslateKeySym(Display*,KeySym *,unsigned int,char*,int,int*) /* int  */
iabbrev <buffer> XkbResizeKeyActions XkbResizeKeyActions(XkbDescPtr,int,int) /* XkbAction * */
iabbrev <buffer> XkbUpdateKeyTypeVirtualMods XkbUpdateKeyTypeVirtualMods(XkbDescPtr,XkbKeyTypePtr,unsigned int,XkbChangesPtr) /* void  */
iabbrev <buffer> XkbIgnoreExtension XkbIgnoreExtension(Bool) /* Bool  */
iabbrev <buffer> XkbOpenDisplay XkbOpenDisplay(char*,int*,int*,int*,int*,int*) /* Display * */
iabbrev <buffer> XkbQueryExtension XkbQueryExtension(Display*,int*,int*,int*,int*,int*) /* Bool  */
iabbrev <buffer> XkbUseExtension XkbUseExtension(Display*,int*,int*) /* Bool  */
iabbrev <buffer> XkbLibraryVersion XkbLibraryVersion(int*,int*) /* Bool  */
iabbrev <buffer> XkbSetXlibControls XkbSetXlibControls(Display*,unsigned int,unsigned int) /* unsigned int  */
iabbrev <buffer> XkbGetXlibControls XkbGetXlibControls(Display*) /* unsigned int  */
iabbrev <buffer> XkbXlibControlsImplemented XkbXlibControlsImplemented() /* unsigned int  */
iabbrev <buffer> XkbSetAtomFuncs XkbSetAtomFuncs(XkbInternAtomFunc,XkbGetAtomNameFunc) /* void  */
iabbrev <buffer> XkbKeycodeToKeysym XkbKeycodeToKeysym(Display *,#if NeedWidePrototypes unsigned int,#else KeyCode,#endif int,int) /* KeySym  */
iabbrev <buffer> XkbKeysymToModifiers XkbKeysymToModifiers(Display*,KeySym) /* unsigned int  */
iabbrev <buffer> XkbLookupKeySym XkbLookupKeySym(Display*,KeyCode,unsigned int,unsigned int*,KeySym *) /* Bool  */
iabbrev <buffer> XkbLookupKeyBinding XkbLookupKeyBinding(Display*,KeySym,unsigned int,char*,int,int*) /* int  */
iabbrev <buffer> XkbTranslateKeyCode XkbTranslateKeyCode(XkbDescPtr,KeyCode,unsigned int,unsigned int*,KeySym *) /* Bool  */
iabbrev <buffer> XkbSetAutoRepeatRate XkbSetAutoRepeatRate(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbGetAutoRepeatRate XkbGetAutoRepeatRate(Display*,unsigned int,unsigned int*,unsigned int*) /* Bool  */
iabbrev <buffer> XkbChangeEnabledControls XkbChangeEnabledControls(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbDeviceBell XkbDeviceBell(Display*,Window,int,int,int,int,Atom) /* Bool  */
iabbrev <buffer> XkbForceDeviceBell XkbForceDeviceBell(Display*,int,int,int,int) /* Bool  */
iabbrev <buffer> XkbDeviceBellEvent XkbDeviceBellEvent(Display*,Window,int,int,int,int,Atom) /* Bool  */
iabbrev <buffer> XkbBell XkbBell(Display*,Window,int,Atom) /* Bool  */
iabbrev <buffer> XkbForceBell XkbForceBell(Display*,int) /* Bool  */
iabbrev <buffer> XkbBellEvent XkbBellEvent(Display*,Window,int,Atom) /* Bool  */
iabbrev <buffer> XkbSelectEvents XkbSelectEvents(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbSelectEventDetails XkbSelectEventDetails(Display*,unsigned int,unsigned int,unsigned long,unsigned long) /* Bool  */
iabbrev <buffer> XkbNoteMapChanges XkbNoteMapChanges(XkbMapChangesPtr,XkbMapNotifyEvent *,unsigned int) /* void  */
iabbrev <buffer> XkbNoteNameChanges XkbNoteNameChanges(XkbNameChangesPtr,XkbNamesNotifyEvent *,unsigned int) /* void  */
iabbrev <buffer> XkbGetIndicatorState XkbGetIndicatorState(Display*,unsigned int,unsigned int*) /* Status  */
iabbrev <buffer> XkbGetDeviceIndicatorState XkbGetDeviceIndicatorState(Display*,unsigned int,unsigned int,unsigned int,unsigned int*) /* Status  */
iabbrev <buffer> XkbGetIndicatorMap XkbGetIndicatorMap(Display*,unsigned long,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbSetIndicatorMap XkbSetIndicatorMap(Display*,unsigned long,XkbDescPtr) /* Bool  */
iabbrev <buffer> XkbGetNamedIndicator XkbGetNamedIndicator(Display*,Atom,int*,Bool *,XkbIndicatorMapPtr,Bool *) /* Bool  */
iabbrev <buffer> XkbGetNamedDeviceIndicator XkbGetNamedDeviceIndicator(Display*,unsigned int,unsigned int,unsigned int,Atom,int*,Bool *,XkbIndicatorMapPtr,Bool *) /* Bool  */
iabbrev <buffer> XkbSetNamedIndicator XkbSetNamedIndicator(Display*,Atom,Bool,Bool,Bool,XkbIndicatorMapPtr) /* Bool  */
iabbrev <buffer> XkbSetNamedDeviceIndicator XkbSetNamedDeviceIndicator(Display*,unsigned int,unsigned int,unsigned int,Atom,Bool,Bool,Bool,XkbIndicatorMapPtr) /* Bool  */
iabbrev <buffer> XkbLockModifiers XkbLockModifiers(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbLatchModifiers XkbLatchModifiers(Display*,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbLockGroup XkbLockGroup(Display*,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbLatchGroup XkbLatchGroup(Display*,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbSetServerInternalMods XkbSetServerInternalMods(Display*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbSetIgnoreLockMods XkbSetIgnoreLockMods(Display*,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbVirtualModsToReal XkbVirtualModsToReal(XkbDescPtr,unsigned int,unsigned int*) /* Bool  */
iabbrev <buffer> XkbComputeEffectiveMap XkbComputeEffectiveMap(XkbDescPtr,XkbKeyTypePtr,unsigned char*) /* Bool  */
iabbrev <buffer> XkbInitCanonicalKeyTypes XkbInitCanonicalKeyTypes(XkbDescPtr,unsigned int,int) /* Status  */
iabbrev <buffer> XkbAllocKeyboard XkbAllocKeyboard() /* XkbDescPtr  */
iabbrev <buffer> XkbFreeKeyboard XkbFreeKeyboard(XkbDescPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbAllocClientMap XkbAllocClientMap(XkbDescPtr,unsigned int,unsigned int) /* Status  */
iabbrev <buffer> XkbAllocServerMap XkbAllocServerMap(XkbDescPtr,unsigned int,unsigned int) /* Status  */
iabbrev <buffer> XkbFreeClientMap XkbFreeClientMap(XkbDescPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbFreeServerMap XkbFreeServerMap(XkbDescPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbAddKeyType XkbAddKeyType(XkbDescPtr,Atom,int,Bool,int) /* XkbKeyTypePtr  */
iabbrev <buffer> XkbAllocIndicatorMaps XkbAllocIndicatorMaps(XkbDescPtr) /* Status  */
iabbrev <buffer> XkbFreeIndicatorMaps XkbFreeIndicatorMaps(XkbDescPtr) /* void  */
iabbrev <buffer> XkbGetMap XkbGetMap(Display*,unsigned int,unsigned int) /* XkbDescPtr  */
iabbrev <buffer> XkbGetUpdatedMap XkbGetUpdatedMap(Display*,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetMapChanges XkbGetMapChanges(Display*,XkbDescPtr,XkbMapChangesPtr) /* Status  */
iabbrev <buffer> XkbRefreshKeyboardMapping XkbRefreshKeyboardMapping(XkbMapNotifyEvent *) /* Status  */
iabbrev <buffer> XkbGetKeyTypes XkbGetKeyTypes(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetKeySyms XkbGetKeySyms(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetKeyActions XkbGetKeyActions(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetKeyBehaviors XkbGetKeyBehaviors(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetVirtualMods XkbGetVirtualMods(Display*,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetKeyExplicitComponents XkbGetKeyExplicitComponents(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetKeyModifierMap XkbGetKeyModifierMap(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbGetKeyVirtualModMap XkbGetKeyVirtualModMap(Display*,unsigned int,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbAllocControls XkbAllocControls(XkbDescPtr,unsigned int) /* Status  */
iabbrev <buffer> XkbFreeControls XkbFreeControls(XkbDescPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbGetControls XkbGetControls(Display*,unsigned long,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbSetControls XkbSetControls(Display*,unsigned long,XkbDescPtr) /* Bool  */
iabbrev <buffer> XkbNoteControlsChanges XkbNoteControlsChanges(XkbControlsChangesPtr,XkbControlsNotifyEvent *,unsigned int) /* void  */
iabbrev <buffer> XkbAllocCompatMap XkbAllocCompatMap(XkbDescPtr,unsigned int,unsigned int) /* Status  */
iabbrev <buffer> XkbFreeCompatMap XkbFreeCompatMap(XkbDescPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbGetCompatMap XkbGetCompatMap(Display*,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbSetCompatMap XkbSetCompatMap(Display*,unsigned int,XkbDescPtr,Bool) /* Bool  */
iabbrev <buffer> XkbAddSymInterpret XkbAddSymInterpret(XkbDescPtr,XkbSymInterpretPtr,Bool,XkbChangesPtr) /* XkbSymInterpretPtr  */
iabbrev <buffer> XkbAllocNames XkbAllocNames(XkbDescPtr,unsigned int,int,int) /* Status  */
iabbrev <buffer> XkbGetNames XkbGetNames(Display*,unsigned int,XkbDescPtr) /* Status  */
iabbrev <buffer> XkbSetNames XkbSetNames(Display*,unsigned int,unsigned int,unsigned int,XkbDescPtr) /* Bool  */
iabbrev <buffer> XkbChangeNames XkbChangeNames(Display*,XkbDescPtr,XkbNameChangesPtr) /* Bool  */
iabbrev <buffer> XkbFreeNames XkbFreeNames(XkbDescPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbGetState XkbGetState(Display*,unsigned int,XkbStatePtr) /* Status  */
iabbrev <buffer> XkbSetMap XkbSetMap(Display*,unsigned int,XkbDescPtr) /* Bool  */
iabbrev <buffer> XkbChangeMap XkbChangeMap(Display*,XkbDescPtr,XkbMapChangesPtr) /* Bool  */
iabbrev <buffer> XkbSetDetectableAutoRepeat XkbSetDetectableAutoRepeat(Display*,Bool,Bool *) /* Bool  */
iabbrev <buffer> XkbGetDetectableAutoRepeat XkbGetDetectableAutoRepeat(Display*,Bool *) /* Bool  */
iabbrev <buffer> XkbSetAutoResetControls XkbSetAutoResetControls(Display*,unsigned int,unsigned int*,unsigned int*) /* Bool  */
iabbrev <buffer> XkbGetAutoResetControls XkbGetAutoResetControls(Display*,unsigned int*,unsigned int*) /* Bool  */
iabbrev <buffer> XkbSetPerClientControls XkbSetPerClientControls(Display*,unsigned int,unsigned int*) /* Bool  */
iabbrev <buffer> XkbGetPerClientControls XkbGetPerClientControls(Display*,unsigned int*) /* Bool  */
iabbrev <buffer> XkbCopyKeyType XkbCopyKeyType(XkbKeyTypePtr,XkbKeyTypePtr) /* Status  */
iabbrev <buffer> XkbCopyKeyTypes XkbCopyKeyTypes(XkbKeyTypePtr,XkbKeyTypePtr,int) /* Status  */
iabbrev <buffer> XkbResizeKeyType XkbResizeKeyType(XkbDescPtr,int,int,Bool,int) /* Status  */
iabbrev <buffer> XkbResizeKeySyms XkbResizeKeySyms(XkbDescPtr,int,int) /* KeySym * */
iabbrev <buffer> XkbChangeTypesOfKey XkbChangeTypesOfKey(XkbDescPtr,int,int,unsigned int,int*,XkbMapChangesPtr) /* Status  */
iabbrev <buffer> XkbChangeKeycodeRange XkbChangeKeycodeRange(XkbDescPtr,int,int,XkbChangesPtr) /* Status  */
iabbrev <buffer> XkbListComponents XkbListComponents(Display*,unsigned int,XkbComponentNamesPtr,int*) /* XkbComponentListPtr  */
iabbrev <buffer> XkbFreeComponentList XkbFreeComponentList(XkbComponentListPtr) /* void  */
iabbrev <buffer> XkbGetKeyboard XkbGetKeyboard(Display*,unsigned int,unsigned int) /* XkbDescPtr  */
iabbrev <buffer> XkbGetKeyboardByName XkbGetKeyboardByName(Display*,unsigned int,XkbComponentNamesPtr,unsigned int,unsigned int,Bool) /* XkbDescPtr  */
iabbrev <buffer> XkbKeyTypesForCoreSymbols XkbKeyTypesForCoreSymbols( XkbDescPtr,int,KeySym *,unsigned int,int*,KeySym *) /* int  */
iabbrev <buffer> XkbApplyCompatMapToKey XkbApplyCompatMapToKey( XkbDescPtr,KeyCode,XkbChangesPtr) /* Bool  */
iabbrev <buffer> XkbUpdateMapFromCore XkbUpdateMapFromCore( XkbDescPtr,KeyCode,int,int,KeySym *,XkbChangesPtr) /* Bool  */
iabbrev <buffer> XkbAddDeviceLedInfo XkbAddDeviceLedInfo(XkbDeviceInfoPtr,unsigned int,unsigned int) /* XkbDeviceLedInfoPtr  */
iabbrev <buffer> XkbResizeDeviceButtonActions XkbResizeDeviceButtonActions(XkbDeviceInfoPtr,unsigned int) /* Status  */
iabbrev <buffer> XkbAllocDeviceInfo XkbAllocDeviceInfo(unsigned int,unsigned int,unsigned int) /* XkbDeviceInfoPtr  */
iabbrev <buffer> XkbFreeDeviceInfo XkbFreeDeviceInfo(XkbDeviceInfoPtr,unsigned int,Bool) /* void  */
iabbrev <buffer> XkbNoteDeviceChanges XkbNoteDeviceChanges(XkbDeviceChangesPtr,XkbExtensionDeviceNotifyEvent *,unsigned int) /* void  */
iabbrev <buffer> XkbGetDeviceInfo XkbGetDeviceInfo(Display*,unsigned int,unsigned int,unsigned int,unsigned int) /* XkbDeviceInfoPtr  */
iabbrev <buffer> XkbGetDeviceInfoChanges XkbGetDeviceInfoChanges(Display*,XkbDeviceInfoPtr,XkbDeviceChangesPtr) /* Status  */
iabbrev <buffer> XkbGetDeviceButtonActions XkbGetDeviceButtonActions(Display*,XkbDeviceInfoPtr,Bool,unsigned int,unsigned int) /* Status  */
iabbrev <buffer> XkbGetDeviceLedInfo XkbGetDeviceLedInfo(Display*,XkbDeviceInfoPtr,unsigned int,unsigned int,unsigned int) /* Status  */
iabbrev <buffer> XkbSetDeviceInfo XkbSetDeviceInfo(Display*,unsigned int,XkbDeviceInfoPtr) /* Bool  */
iabbrev <buffer> XkbChangeDeviceInfo XkbChangeDeviceInfo(Display*,XkbDeviceInfoPtr,XkbDeviceChangesPtr) /* Bool  */
iabbrev <buffer> XkbSetDeviceLedInfo XkbSetDeviceLedInfo(Display*,XkbDeviceInfoPtr,unsigned int,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbSetDeviceButtonActions XkbSetDeviceButtonActions(Display*,XkbDeviceInfoPtr,unsigned int,unsigned int) /* Bool  */
iabbrev <buffer> XkbToControl XkbToControl(char) /* char  */
iabbrev <buffer> XkbSetDebuggingFlags XkbSetDebuggingFlags(Display*,unsigned int,unsigned int,char*,unsigned int,unsigned int,unsigned int*,unsigned int*) /* Bool  */
iabbrev <buffer> XkbApplyVirtualModChanges XkbApplyVirtualModChanges( XkbDescPtr,unsigned int,XkbChangesPtr) /* Bool  */
iabbrev <buffer> XkbUpdateActionVirtualMods XkbUpdateActionVirtualMods(XkbDescPtr,XkbAction *,unsigned int) /* Bool  */

" Xpm.h defs
iabbrev <buffer> XpmAttributesSize XpmAttributesSize(); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateBufferFromImage XpmCreateBufferFromImage(Display *display,char **buffer_return,XImage *image,XImage *shapeimage,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateBufferFromPixmap XpmCreateBufferFromPixmap(Display *display,char **buffer_return,Pixmap pixmap,Pixmap shapemask,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateBufferFromXpmImage XpmCreateBufferFromXpmImage(char **buffer_return,XpmImage *image,XpmInfo *info); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateDataFromImage XpmCreateDataFromImage(Display *display,char ***data_return,XImage *image,XImage *shapeimage,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateDataFromPixmap XpmCreateDataFromPixmap(Display *display,char ***data_return,Pixmap pixmap,Pixmap shapemask,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateDataFromXpmImage XpmCreateDataFromXpmImage(char ***data_return,XpmImage *image,XpmInfo *info); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateImageFromBuffer XpmCreateImageFromBuffer(Display *display,char *buffer,XImage **image_return,XImage **shapemask_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateImageFromData XpmCreateImageFromData(Display *display,char **data,XImage **image_return,XImage **shapemask_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateImageFromXpmImage XpmCreateImageFromXpmImage(Display *display,XpmImage *image,XImage **image_return,XImage **shapeimage_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreatePixmapFromBuffer XpmCreatePixmapFromBuffer(Display *display,Drawable d,char *buffer,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreatePixmapFromData XpmCreatePixmapFromData(Display *display,Drawable d,char **data,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreatePixmapFromXpmImage XpmCreatePixmapFromXpmImage(Display *display,Drawable d,XpmImage *image,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateXpmImageFromBuffer XpmCreateXpmImageFromBuffer(char *buffer,XpmImage *image,XpmInfo *info); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateXpmImageFromData XpmCreateXpmImageFromData(char **data,XpmImage *image,XpmInfo *info); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateXpmImageFromImage XpmCreateXpmImageFromImage(Display *display,XImage *image,XImage *shapeimage,XpmImage *xpmimage,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmCreateXpmImageFromPixmap XpmCreateXpmImageFromPixmap(Display *display,Pixmap pixmap,Pixmap shapemask,XpmImage *xpmimage,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmFree XpmFree(void *ptr); /* void  */<ESC>?(<CR>
iabbrev <buffer> XpmFreeAttributes XpmFreeAttributes(XpmAttributes *attributes); /* void  */<ESC>?(<CR>
iabbrev <buffer> XpmFreeExtensions XpmFreeExtensions(XpmExtension *extensions,int nextensions); /* void  */<ESC>?(<CR>
iabbrev <buffer> XpmFreeXpmImage XpmFreeXpmImage(XpmImage *image); /* void  */<ESC>?(<CR>
iabbrev <buffer> XpmFreeXpmInfo XpmFreeXpmInfo(XpmInfo *info); /* void  */<ESC>?(<CR>
iabbrev <buffer> XpmGetErrorString XpmGetErrorString(int errcode); /* char*  */<ESC>?(<CR>
iabbrev <buffer> XpmGetParseError XpmGetParseError(char *filename,int *linenum_return,int *charnum_return); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmLibraryVersion XpmLibraryVersion(); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmReadFileToBuffer XpmReadFileToBuffer(const char *filename,char **buffer_return); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmReadFileToData XpmReadFileToData(const char *filename,char ***data_return); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmReadFileToImage XpmReadFileToImage(Display *display,const char *filename,XImage **image_return,XImage **shapeimage_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmReadFileToPixmap XpmReadFileToPixmap(Display *display,Drawable d,const char *filename,Pixmap *pixmap_return,Pixmap *shapemask_return,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmReadFileToXpmImage XpmReadFileToXpmImage(const char *filename,XpmImage *image,XpmInfo *info); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmWriteFileFromBuffer XpmWriteFileFromBuffer(const char *filename,char *buffer); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmWriteFileFromData XpmWriteFileFromData(const char *filename,char **data); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmWriteFileFromImage XpmWriteFileFromImage(Display *display,const char *filename,XImage *image,XImage *shapeimage,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmWriteFileFromPixmap XpmWriteFileFromPixmap(Display *display,const char *filename,Pixmap pixmap,Pixmap shapemask,XpmAttributes *attributes); /* int  */<ESC>?(<CR>
iabbrev <buffer> XpmWriteFileFromXpmImage XpmWriteFileFromXpmImage(const char *filename,XpmImage *image,XpmInfo *info); /* int  */<ESC>?(<CR>

" cairo.h defs
iabbrev <buffer> cairo_clip cairo_clip(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_clip_preserve cairo_clip_preserve(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_close_path cairo_close_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_clip_rectangle_list cairo_copy_clip_rectangle_list(cairo_t *cr); /*cairo_rectangle_list_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_page cairo_copy_page(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_path cairo_copy_path(cairo_t *cr); /*cairo_path_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_copy_path_flat cairo_copy_path_flat(cairo_t *cr); /*cairo_path_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_create cairo_create(cairo_surface_t *target); /*cairo_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_debug_reset_static_data cairo_debug_reset_static_data(); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_destroy cairo_destroy(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_acquire cairo_device_acquire(cairo_device_t *device); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_destroy cairo_device_destroy(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_finish cairo_device_finish(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_flush cairo_device_flush(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_get_reference_count cairo_device_get_reference_count(cairo_device_t *device); /*unsigned int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_get_type cairo_device_get_type(cairo_device_t *device); /*cairo_device_type_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_elapsed cairo_device_observer_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_fill_elapsed cairo_device_observer_fill_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_glyphs_elapsed cairo_device_observer_glyphs_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_mask_elapsed cairo_device_observer_mask_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_paint_elapsed cairo_device_observer_paint_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_observer_stroke_elapsed cairo_device_observer_stroke_elapsed(cairo_device_t *device); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_reference cairo_device_reference(cairo_device_t *device); /*cairo_device_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_release cairo_device_release(cairo_device_t *device); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_status cairo_device_status(cairo_device_t *device); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_to_user cairo_device_to_user(cairo_t *cr,double *x,double *y); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_device_to_user_distance cairo_device_to_user_distance(cairo_t *cr,double *dx,double *dy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_fill cairo_fill(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_fill_preserve cairo_fill_preserve(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_destroy cairo_font_face_destroy(cairo_font_face_t *font_face); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_get_reference_count cairo_font_face_get_reference_count(cairo_font_face_t *font_face); /*unsigned int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_get_type cairo_font_face_get_type(cairo_font_face_t *font_face); /*cairo_font_type_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_reference cairo_font_face_reference(cairo_font_face_t *font_face); /*cairo_font_face_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_face_status cairo_font_face_status(cairo_font_face_t *font_face); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_copy cairo_font_options_copy(const cairo_font_options_t *original); /*cairo_font_options_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_create cairo_font_options_create(); /*cairo_font_options_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_destroy cairo_font_options_destroy(cairo_font_options_t *options); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_antialias cairo_font_options_get_antialias(const cairo_font_options_t *options); /*cairo_antialias_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_hint_metrics cairo_font_options_get_hint_metrics(const cairo_font_options_t *options); /*cairo_hint_metrics_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_hint_style cairo_font_options_get_hint_style(const cairo_font_options_t *options); /*cairo_hint_style_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_get_subpixel_order cairo_font_options_get_subpixel_order(const cairo_font_options_t *options); /*cairo_subpixel_order_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_hash cairo_font_options_hash(const cairo_font_options_t *options); /*unsigned long */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_font_options_status cairo_font_options_status(cairo_font_options_t *options); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_antialias cairo_get_antialias(cairo_t *cr); /*cairo_antialias_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_current_point cairo_get_current_point(cairo_t *cr,double *x,double *y); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_dash cairo_get_dash(cairo_t *cr,double *dashes,double *offset); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_dash_count cairo_get_dash_count(cairo_t *cr); /*int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_fill_rule cairo_get_fill_rule(cairo_t *cr); /*cairo_fill_rule_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_font_face cairo_get_font_face(cairo_t *cr); /*cairo_font_face_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_group_target cairo_get_group_target(cairo_t *cr); /*cairo_surface_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_line_cap cairo_get_line_cap(cairo_t *cr); /*cairo_line_cap_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_line_join cairo_get_line_join(cairo_t *cr); /*cairo_line_join_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_line_width cairo_get_line_width(cairo_t *cr); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_matrix cairo_get_matrix(cairo_t *cr,cairo_matrix_t *matrix); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_miter_limit cairo_get_miter_limit(cairo_t *cr); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_operator cairo_get_operator(cairo_t *cr); /*cairo_operator_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_reference_count cairo_get_reference_count(cairo_t *cr); /*unsigned int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_scaled_font cairo_get_scaled_font(cairo_t *cr); /*cairo_scaled_font_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_source cairo_get_source(cairo_t *cr); /*cairo_pattern_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_target cairo_get_target(cairo_t *cr); /*cairo_surface_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_get_tolerance cairo_get_tolerance(cairo_t *cr); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_glyph_allocate cairo_glyph_allocate(int num_glyphs); /*cairo_glyph_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_glyph_free cairo_glyph_free(cairo_glyph_t *glyphs); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_glyph_path cairo_glyph_path(cairo_t *cr,const cairo_glyph_t *glyphs,int num_glyphs); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_has_current_point cairo_has_current_point(cairo_t *cr); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_identity_matrix cairo_identity_matrix(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_create_from_png cairo_image_surface_create_from_png(const char *filename); /*cairo_surface_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_data cairo_image_surface_get_data(cairo_surface_t *surface); /*unsigned char * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_format cairo_image_surface_get_format(cairo_surface_t *surface); /*cairo_format_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_height cairo_image_surface_get_height(cairo_surface_t *surface); /*int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_stride cairo_image_surface_get_stride(cairo_surface_t *surface); /*int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_image_surface_get_width cairo_image_surface_get_width(cairo_surface_t *surface); /*int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_in_clip cairo_in_clip(cairo_t *cr,double x,double y); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_in_fill cairo_in_fill(cairo_t *cr,double x,double y); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_in_stroke cairo_in_stroke(cairo_t *cr,double x,double y); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_line_to cairo_line_to(cairo_t *cr,double x,double y); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_init_identity cairo_matrix_init_identity(cairo_matrix_t *matrix); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_invert cairo_matrix_invert(cairo_matrix_t *matrix); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_rotate cairo_matrix_rotate(cairo_matrix_t *matrix,double radians); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_scale cairo_matrix_scale(cairo_matrix_t *matrix,double sx,double sy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_matrix_translate cairo_matrix_translate(cairo_matrix_t *matrix,double tx,double ty); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_mesh_pattern_begin_patch cairo_mesh_pattern_begin_patch(cairo_pattern_t *pattern); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_mesh_pattern_end_patch cairo_mesh_pattern_end_patch(cairo_pattern_t *pattern); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_move_to cairo_move_to(cairo_t *cr,double x,double y); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_new_path cairo_new_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_new_sub_path cairo_new_sub_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_paint cairo_paint(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_path_destroy cairo_path_destroy(cairo_path_t *path); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_create_for_surface cairo_pattern_create_for_surface(cairo_surface_t *surface); /*cairo_pattern_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_create_mesh cairo_pattern_create_mesh(); /*cairo_pattern_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_create_rgb cairo_pattern_create_rgb(double red,double green,double blue); /*cairo_pattern_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_destroy cairo_pattern_destroy(cairo_pattern_t *pattern); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_extend cairo_pattern_get_extend(cairo_pattern_t *pattern); /*cairo_extend_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_filter cairo_pattern_get_filter(cairo_pattern_t *pattern); /*cairo_filter_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_reference_count cairo_pattern_get_reference_count(cairo_pattern_t *pattern); /*unsigned int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_get_type cairo_pattern_get_type(cairo_pattern_t *pattern); /*cairo_pattern_type_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_reference cairo_pattern_reference(cairo_pattern_t *pattern); /*cairo_pattern_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_set_extend cairo_pattern_set_extend(cairo_pattern_t *pattern,cairo_extend_t extend); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_set_filter cairo_pattern_set_filter(cairo_pattern_t *pattern,cairo_filter_t filter); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pattern_status cairo_pattern_status(cairo_pattern_t *pattern); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pop_group cairo_pop_group(cairo_t *cr); /*cairo_pattern_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_pop_group_to_source cairo_pop_group_to_source(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_push_group cairo_push_group(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_push_group_with_content cairo_push_group_with_content(cairo_t *cr,cairo_content_t content); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_callback_data cairo_raster_source_pattern_get_callback_data(cairo_pattern_t *pattern); /*void * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_copy cairo_raster_source_pattern_get_copy(cairo_pattern_t *pattern); /*cairo_raster_source_copy_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_finish cairo_raster_source_pattern_get_finish(cairo_pattern_t *pattern); /*cairo_raster_source_finish_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_raster_source_pattern_get_snapshot cairo_raster_source_pattern_get_snapshot(cairo_pattern_t *pattern); /*cairo_raster_source_snapshot_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rectangle_list_destroy cairo_rectangle_list_destroy(cairo_rectangle_list_t *rectangle_list); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_reference cairo_reference(cairo_t *cr); /*cairo_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_contains_point cairo_region_contains_point(const cairo_region_t *region,int x,int y); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_copy cairo_region_copy(const cairo_region_t *original); /*cairo_region_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_create cairo_region_create(); /*cairo_region_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_create_rectangle cairo_region_create_rectangle(const cairo_rectangle_int_t *rectangle); /*cairo_region_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_destroy cairo_region_destroy(cairo_region_t *region); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_equal cairo_region_equal(const cairo_region_t *a,const cairo_region_t *b); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_intersect cairo_region_intersect(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_is_empty cairo_region_is_empty(const cairo_region_t *region); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_num_rectangles cairo_region_num_rectangles(const cairo_region_t *region); /*int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_reference cairo_region_reference(cairo_region_t *region); /*cairo_region_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_status cairo_region_status(const cairo_region_t *region); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_subtract cairo_region_subtract(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_translate cairo_region_translate(cairo_region_t *region,int dx,int dy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_union cairo_region_union(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_region_xor cairo_region_xor(cairo_region_t *dst,const cairo_region_t *other); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rel_line_to cairo_rel_line_to(cairo_t *cr,double dx,double dy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rel_move_to cairo_rel_move_to(cairo_t *cr,double dx,double dy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_reset_clip cairo_reset_clip(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_restore cairo_restore(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_rotate cairo_rotate(cairo_t *cr,double angle); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_save cairo_save(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scale cairo_scale(cairo_t *cr,double sx,double sy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_destroy cairo_scaled_font_destroy(cairo_scaled_font_t *scaled_font); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_get_font_face cairo_scaled_font_get_font_face(cairo_scaled_font_t *scaled_font); /*cairo_font_face_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_get_reference_count cairo_scaled_font_get_reference_count(cairo_scaled_font_t *scaled_font); /*unsigned int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_get_type cairo_scaled_font_get_type(cairo_scaled_font_t *scaled_font); /*cairo_font_type_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_reference cairo_scaled_font_reference(cairo_scaled_font_t *scaled_font); /*cairo_scaled_font_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_scaled_font_status cairo_scaled_font_status(cairo_scaled_font_t *scaled_font); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_antialias cairo_set_antialias(cairo_t *cr,cairo_antialias_t antialias); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_fill_rule cairo_set_fill_rule(cairo_t *cr,cairo_fill_rule_t fill_rule); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_font_face cairo_set_font_face(cairo_t *cr,cairo_font_face_t *font_face); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_font_size cairo_set_font_size(cairo_t *cr,double size); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_line_cap cairo_set_line_cap(cairo_t *cr,cairo_line_cap_t line_cap); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_line_join cairo_set_line_join(cairo_t *cr,cairo_line_join_t line_join); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_line_width cairo_set_line_width(cairo_t *cr,double width); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_miter_limit cairo_set_miter_limit(cairo_t *cr,double limit); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_operator cairo_set_operator(cairo_t *cr,cairo_operator_t op); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_source cairo_set_source(cairo_t *cr,cairo_pattern_t *source); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_source_rgb cairo_set_source_rgb(cairo_t *cr,double red,double green,double blue); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_set_tolerance cairo_set_tolerance(cairo_t *cr,double tolerance); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_show_glyphs cairo_show_glyphs(cairo_t *cr,const cairo_glyph_t *glyphs,int num_glyphs); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_show_page cairo_show_page(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_show_text cairo_show_text(cairo_t *cr,const char *utf8); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_status cairo_status(cairo_t *cr); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_status_to_string cairo_status_to_string(cairo_status_t status); /*const char * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_stroke cairo_stroke(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_stroke_preserve cairo_stroke_preserve(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_stroke_to_path cairo_stroke_to_path(cairo_t *cr); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_copy_page cairo_surface_copy_page(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_destroy cairo_surface_destroy(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_finish cairo_surface_finish(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_flush cairo_surface_flush(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_content cairo_surface_get_content(cairo_surface_t *surface); /*cairo_content_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_device cairo_surface_get_device(cairo_surface_t *surface); /*cairo_device_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_reference_count cairo_surface_get_reference_count(cairo_surface_t *surface); /*unsigned int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_get_type cairo_surface_get_type(cairo_surface_t *surface); /*cairo_surface_type_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_has_show_text_glyphs cairo_surface_has_show_text_glyphs(cairo_surface_t *surface); /*cairo_bool_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_mark_dirty cairo_surface_mark_dirty(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_observer_elapsed cairo_surface_observer_elapsed(cairo_surface_t *surface); /*double */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_reference cairo_surface_reference(cairo_surface_t *surface); /*cairo_surface_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_show_page cairo_surface_show_page(cairo_surface_t *surface); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_surface_status cairo_surface_status(cairo_surface_t *surface); /*cairo_status_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_text_cluster_allocate cairo_text_cluster_allocate(int num_clusters); /*cairo_text_cluster_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_text_cluster_free cairo_text_cluster_free(cairo_text_cluster_t *clusters); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_text_path cairo_text_path(cairo_t *cr,const char *utf8); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_toy_font_face_get_family cairo_toy_font_face_get_family(cairo_font_face_t *font_face); /*const char * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_toy_font_face_get_slant cairo_toy_font_face_get_slant(cairo_font_face_t *font_face); /*cairo_font_slant_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_toy_font_face_get_weight cairo_toy_font_face_get_weight(cairo_font_face_t *font_face); /*cairo_font_weight_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_translate cairo_translate(cairo_t *cr,double tx,double ty); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_create cairo_user_font_face_create(); /*cairo_font_face_t * */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_init_func cairo_user_font_face_get_init_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_init_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_render_glyph_func cairo_user_font_face_get_render_glyph_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_render_glyph_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_text_to_glyphs_func cairo_user_font_face_get_text_to_glyphs_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_text_to_glyphs_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_font_face_get_unicode_to_glyph_func cairo_user_font_face_get_unicode_to_glyph_func(cairo_font_face_t *font_face); /*cairo_user_scaled_font_unicode_to_glyph_func_t */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_to_device cairo_user_to_device(cairo_t *cr,double *x,double *y); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_user_to_device_distance cairo_user_to_device_distance(cairo_t *cr,double *dx,double *dy); /*void */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_version cairo_version(); /*int */<ESC>:normal0f(<CR>
iabbrev <buffer> cairo_version_string cairo_version_string(); /*const char* */<ESC>:normal0f(<CR>

" cairo-xcb.h defs
iabbrev <buffer> cairo_xcb_device_debug_cap_xrender_version cairo_xcb_device_debug_cap_xrender_version(cairo_device_t *device,int major_version,int minor_version); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_device_debug_cap_xshm_version cairo_xcb_device_debug_cap_xshm_version(cairo_device_t *device,int major_version,int minor_version); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_device_debug_get_precision cairo_xcb_device_debug_get_precision(cairo_device_t *device); /*int */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_device_debug_set_precision cairo_xcb_device_debug_set_precision(cairo_device_t *device,int precision); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_device_get_connection cairo_xcb_device_get_connection(cairo_device_t *device); /*xcb_connection_t * */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_surface_create cairo_xcb_surface_create(xcb_connection_t *connection,xcb_drawable_t drawable,xcb_visualtype_t *visual,int width,int height); /*cairo_surface_t * */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_surface_create_for_bitmap cairo_xcb_surface_create_for_bitmap(xcb_connection_t *connection,xcb_screen_t *screen,xcb_pixmap_t bitmap,int width,int height); /*cairo_surface_t * */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_surface_create_with_xrender_format cairo_xcb_surface_create_with_xrender_format(xcb_connection_t *connection,xcb_screen_t *screen,xcb_drawable_t drawable,xcb_render_pictforminfo_t *format,int width,int height); /*cairo_surface_t *  */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_surface_set_drawable cairo_xcb_surface_set_drawable(cairo_surface_t *surface,xcb_drawable_t drawable,int width,int height); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xcb_surface_set_size cairo_xcb_surface_set_size(cairo_surface_t *surface,int width,int height); /*void */<ESC>?(<CR>

" cairo-xlib.h defs
iabbrev <buffer> cairo_xlib_device_debug_cap_xrender_version cairo_xlib_device_debug_cap_xrender_version(cairo_device_t *device,int major_version,int minor_version); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_device_debug_get_precision cairo_xlib_device_debug_get_precision(cairo_device_t *device); /*int */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_device_debug_set_precision cairo_xlib_device_debug_set_precision(cairo_device_t *device,int precision); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_create cairo_xlib_surface_create(Display *dpy,Drawable drawable,Visual *visual,int width,int height); /*cairo_surface_t * */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_create_for_bitmap cairo_xlib_surface_create_for_bitmap(Display *dpy,Pixmap bitmap,Screen *screen,int width,int height); /*cairo_surface_t * */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_depth cairo_xlib_surface_get_depth(cairo_surface_t *surface); /*int */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_display cairo_xlib_surface_get_display(cairo_surface_t *surface); /*Display * */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_drawable cairo_xlib_surface_get_drawable(cairo_surface_t *surface); /*Drawable */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_height cairo_xlib_surface_get_height(cairo_surface_t *surface); /*int */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_screen cairo_xlib_surface_get_screen(cairo_surface_t *surface); /*Screen * */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_visual cairo_xlib_surface_get_visual(cairo_surface_t *surface); /*Visual * */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_get_width cairo_xlib_surface_get_width(cairo_surface_t *surface); /*int */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_set_drawable cairo_xlib_surface_set_drawable(cairo_surface_t *surface,Drawable drawable,int width,int height); /*void */<ESC>?(<CR>
iabbrev <buffer> cairo_xlib_surface_set_size cairo_xlib_surface_set_size(cairo_surface_t *surface,int width,int height); /*void */<ESC>?(<CR>

" sdl sdl2 SDL SDL2 sdl.h SDL.h defs
iabbrev <buffer> IMG_Init IMG_Init(int flags); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_Linked_Version IMG_Linked_Version(); /* const SDL_version *  */<ESC>?(<CR>
iabbrev <buffer> IMG_Load IMG_Load(const char *file); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadBMP_RW IMG_LoadBMP_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadCUR_RW IMG_LoadCUR_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadGIF_RW IMG_LoadGIF_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadICO_RW IMG_LoadICO_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadJPG_RW IMG_LoadJPG_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadLBM_RW IMG_LoadLBM_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadPCX_RW IMG_LoadPCX_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadPNG_RW IMG_LoadPNG_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadPNM_RW IMG_LoadPNM_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadSVG_RW IMG_LoadSVG_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadTGA_RW IMG_LoadTGA_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadTIF_RW IMG_LoadTIF_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadTexture IMG_LoadTexture(SDL_Renderer *renderer,const char *file); /* SDL_Texture *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadTextureTyped_RW IMG_LoadTextureTyped_RW(SDL_Renderer *renderer,SDL_RWops *src,int freesrc,const char *type); /* SDL_Texture *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadTexture_RW IMG_LoadTexture_RW(SDL_Renderer *renderer,SDL_RWops *src,int freesrc); /* SDL_Texture *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadTyped_RW IMG_LoadTyped_RW(SDL_RWops *src,int freesrc,const char *type); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadWEBP_RW IMG_LoadWEBP_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadXCF_RW IMG_LoadXCF_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadXPM_RW IMG_LoadXPM_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_LoadXV_RW IMG_LoadXV_RW(SDL_RWops *src); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_Load_RW IMG_Load_RW(SDL_RWops *src,int freesrc); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_Quit IMG_Quit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> IMG_ReadXPMFromArray IMG_ReadXPMFromArray(char **xpm); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> IMG_SaveJPG IMG_SaveJPG(SDL_Surface *surface,const char *file,int quality); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_SaveJPG_RW IMG_SaveJPG_RW(SDL_Surface *surface,SDL_RWops *dst,int freedst,int quality); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_SavePNG IMG_SavePNG(SDL_Surface *surface,const char *file); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_SavePNG_RW IMG_SavePNG_RW(SDL_Surface *surface,SDL_RWops *dst,int freedst); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isBMP IMG_isBMP(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isCUR IMG_isCUR(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isGIF IMG_isGIF(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isICO IMG_isICO(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isJPG IMG_isJPG(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isLBM IMG_isLBM(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isPCX IMG_isPCX(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isPNG IMG_isPNG(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isPNM IMG_isPNM(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isSVG IMG_isSVG(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isTIF IMG_isTIF(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isWEBP IMG_isWEBP(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isXCF IMG_isXCF(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isXPM IMG_isXPM(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> IMG_isXV IMG_isXV(SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_AllocateChannels Mix_AllocateChannels(int numchans); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_CloseAudio Mix_CloseAudio(); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_ExpireChannel Mix_ExpireChannel(int channel,int ticks); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadeInChannelTimed Mix_FadeInChannelTimed(int channel,Mix_Chunk *chunk,int loops,int ms,int ticks); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadeInMusic Mix_FadeInMusic(Mix_Music *music,int loops,int ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadeInMusicPos Mix_FadeInMusicPos(Mix_Music *music,int loops,int ms,double position); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadeOutChannel Mix_FadeOutChannel(int which,int ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadeOutGroup Mix_FadeOutGroup(int tag,int ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadeOutMusic Mix_FadeOutMusic(int ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadingChannel Mix_FadingChannel(int which); /* Mix_Fading  */<ESC>?(<CR>
iabbrev <buffer> Mix_FadingMusic Mix_FadingMusic(); /* Mix_Fading  */<ESC>?(<CR>
iabbrev <buffer> Mix_FreeChunk Mix_FreeChunk(Mix_Chunk *chunk); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_FreeMusic Mix_FreeMusic(Mix_Music *music); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetChunk Mix_GetChunk(int channel); /* Mix_Chunk *  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetChunkDecoder Mix_GetChunkDecoder(int index); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetMusicDecoder Mix_GetMusicDecoder(int index); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetMusicHookData Mix_GetMusicHookData(); /* void *  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetMusicType Mix_GetMusicType(const Mix_Music *music); /* Mix_MusicType  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetNumChunkDecoders Mix_GetNumChunkDecoders(); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetNumMusicDecoders Mix_GetNumMusicDecoders(); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetSoundFonts Mix_GetSoundFonts(); /* const char*  */<ESC>?(<CR>
iabbrev <buffer> Mix_GetSynchroValue Mix_GetSynchroValue(); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GroupAvailable Mix_GroupAvailable(int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GroupChannel Mix_GroupChannel(int which,int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GroupChannels Mix_GroupChannels(int from,int to,int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GroupCount Mix_GroupCount(int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GroupNewer Mix_GroupNewer(int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_GroupOldest Mix_GroupOldest(int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_HaltChannel Mix_HaltChannel(int channel); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_HaltGroup Mix_HaltGroup(int tag); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_HaltMusic Mix_HaltMusic(); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_HasChunkDecoder Mix_HasChunkDecoder(const char *name); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> Mix_HasMusicDecoder Mix_HasMusicDecoder(const char *name); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> Mix_Init Mix_Init(int flags); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_Linked_Version Mix_Linked_Version(); /* const SDL_version *  */<ESC>?(<CR>
iabbrev <buffer> Mix_LoadMUS Mix_LoadMUS(const char *file); /* Mix_Music *  */<ESC>?(<CR>
iabbrev <buffer> Mix_LoadMUSType_RW Mix_LoadMUSType_RW(SDL_RWops *src,Mix_MusicType type,int freesrc); /* Mix_Music *  */<ESC>?(<CR>
iabbrev <buffer> Mix_LoadMUS_RW Mix_LoadMUS_RW(SDL_RWops *src,int freesrc); /* Mix_Music *  */<ESC>?(<CR>
iabbrev <buffer> Mix_LoadWAV_RW Mix_LoadWAV_RW(SDL_RWops *src,int freesrc); /* Mix_Chunk *  */<ESC>?(<CR>
iabbrev <buffer> Mix_OpenAudio Mix_OpenAudio(int frequency,Uint16 format,int channels,int chunksize); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_OpenAudioDevice Mix_OpenAudioDevice(int frequency,Uint16 format,int channels,int chunksize,const char* device,int allowed_changes); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_Pause Mix_Pause(int channel); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_PauseMusic Mix_PauseMusic(); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_Paused Mix_Paused(int channel); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_PausedMusic Mix_PausedMusic(); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_PlayChannelTimed Mix_PlayChannelTimed(int channel,Mix_Chunk *chunk,int loops,int ticks); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_PlayMusic Mix_PlayMusic(Mix_Music *music,int loops); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_Playing Mix_Playing(int channel); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_PlayingMusic Mix_PlayingMusic(); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_QuerySpec Mix_QuerySpec(int *frequency,Uint16 *format,int *channels); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_QuickLoad_RAW Mix_QuickLoad_RAW(Uint8 *mem,Uint32 len); /* Mix_Chunk *  */<ESC>?(<CR>
iabbrev <buffer> Mix_QuickLoad_WAV Mix_QuickLoad_WAV(Uint8 *mem); /* Mix_Chunk *  */<ESC>?(<CR>
iabbrev <buffer> Mix_Quit Mix_Quit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_RegisterEffect Mix_RegisterEffect(int chan,Mix_EffectFunc_t f,Mix_EffectDone_t d,void *arg); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_ReserveChannels Mix_ReserveChannels(int num); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_Resume Mix_Resume(int channel); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_ResumeMusic Mix_ResumeMusic(); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_RewindMusic Mix_RewindMusic(); /* void  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetDistance Mix_SetDistance(int channel,Uint8 distance); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetMusicCMD Mix_SetMusicCMD(const char *command); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetMusicPosition Mix_SetMusicPosition(double position); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetPanning Mix_SetPanning(int channel,Uint8 left,Uint8 right); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetPosition Mix_SetPosition(int channel,Sint16 angle,Uint8 distance); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetReverseStereo Mix_SetReverseStereo(int channel,int flip); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetSoundFonts Mix_SetSoundFonts(const char *paths); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_SetSynchroValue Mix_SetSynchroValue(int value); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_UnregisterAllEffects Mix_UnregisterAllEffects(int channel); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_UnregisterEffect Mix_UnregisterEffect(int channel,Mix_EffectFunc_t f); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_Volume Mix_Volume(int channel,int volume); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_VolumeChunk Mix_VolumeChunk(Mix_Chunk *chunk,int volume); /* int  */<ESC>?(<CR>
iabbrev <buffer> Mix_VolumeMusic Mix_VolumeMusic(int volume); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_AddSocket SDLNet_AddSocket(SDLNet_SocketSet set,SDLNet_GenericSocket sock); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_AllocPacket SDLNet_AllocPacket(int size); /* UDPpacket *  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_AllocPacketV SDLNet_AllocPacketV(int howmany,int size); /* UDPpacket **  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_AllocSocketSet SDLNet_AllocSocketSet(int maxsockets); /* SDLNet_SocketSet  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_CheckSockets SDLNet_CheckSockets(SDLNet_SocketSet set,Uint32 timeout); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_DelSocket SDLNet_DelSocket(SDLNet_SocketSet set,SDLNet_GenericSocket sock); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_FreePacket SDLNet_FreePacket(UDPpacket *packet); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_FreePacketV SDLNet_FreePacketV(UDPpacket **packetV); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_FreeSocketSet SDLNet_FreeSocketSet(SDLNet_SocketSet set); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_GetError SDLNet_GetError(); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_GetLocalAddresses SDLNet_GetLocalAddresses(IPaddress *addresses,int maxcount); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_Init SDLNet_Init(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_Linked_Version SDLNet_Linked_Version(); /* const SDLNet_version *  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_Quit SDLNet_Quit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_ResizePacket SDLNet_ResizePacket(UDPpacket *packet,int newsize); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_ResolveHost SDLNet_ResolveHost(IPaddress *address,const char *host,Uint16 port); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_ResolveIP SDLNet_ResolveIP(const IPaddress *ip); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_SetError SDLNet_SetError(const char *fmt,...); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_TCP_Accept SDLNet_TCP_Accept(TCPsocket server); /* TCPsocket  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_TCP_Close SDLNet_TCP_Close(TCPsocket sock); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_TCP_GetPeerAddress SDLNet_TCP_GetPeerAddress(TCPsocket sock); /* IPaddress *  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_TCP_Open SDLNet_TCP_Open(IPaddress *ip); /* TCPsocket  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_TCP_Recv SDLNet_TCP_Recv(TCPsocket sock,void *data,int maxlen); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_TCP_Send SDLNet_TCP_Send(TCPsocket sock,const void *data,int len); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_Bind SDLNet_UDP_Bind(UDPsocket sock,int channel,const IPaddress *address); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_Close SDLNet_UDP_Close(UDPsocket sock); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_GetPeerAddress SDLNet_UDP_GetPeerAddress(UDPsocket sock,int channel); /* IPaddress *  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_Open SDLNet_UDP_Open(Uint16 port); /* UDPsocket  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_Recv SDLNet_UDP_Recv(UDPsocket sock,UDPpacket *packet); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_RecvV SDLNet_UDP_RecvV(UDPsocket sock,UDPpacket **packets); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_Send SDLNet_UDP_Send(UDPsocket sock,int channel,UDPpacket *packet); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_SendV SDLNet_UDP_SendV(UDPsocket sock,UDPpacket **packets,int npackets); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_SetPacketLoss SDLNet_UDP_SetPacketLoss(UDPsocket sock,int percent); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDLNet_UDP_Unbind SDLNet_UDP_Unbind(UDPsocket sock,int channel); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AddEventWatch SDL_AddEventWatch(SDL_EventFilter filter,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AddHintCallback SDL_AddHintCallback(const char *name,SDL_HintCallback callback,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AddTimer SDL_AddTimer(Uint32 interval,SDL_TimerCallback callback,void *param); /* SDL_TimerID  */<ESC>?(<CR>
iabbrev <buffer> SDL_AllocFormat SDL_AllocFormat(Uint32 pixel_format); /* SDL_PixelFormat *  */<ESC>?(<CR>
iabbrev <buffer> SDL_AllocPalette SDL_AllocPalette(int ncolors); /* SDL_Palette * */<ESC>?(<CR>
iabbrev <buffer> SDL_AllocRW SDL_AllocRW(); /* SDL_RWops * */<ESC>?(<CR>
iabbrev <buffer> SDL_AndroidBackButton SDL_AndroidBackButton(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AndroidGetActivity SDL_AndroidGetActivity(); /* void *  */<ESC>?(<CR>
iabbrev <buffer> SDL_AndroidGetExternalStoragePath SDL_AndroidGetExternalStoragePath(); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_AndroidGetExternalStorageState SDL_AndroidGetExternalStorageState(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AndroidGetInternalStoragePath SDL_AndroidGetInternalStoragePath(); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_AndroidGetJNIEnv SDL_AndroidGetJNIEnv(); /* void *  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicAdd SDL_AtomicAdd(SDL_atomic_t *a,int v); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicCAS SDL_AtomicCAS(SDL_atomic_t *a,int oldval,int newval); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicCASPtr SDL_AtomicCASPtr(void **a,void *oldval,void *newval); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicGet SDL_AtomicGet(SDL_atomic_t *a); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicGetPtr SDL_AtomicGetPtr(void **a); /* void*  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicLock SDL_AtomicLock(SDL_SpinLock *lock); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicSet SDL_AtomicSet(SDL_atomic_t *a,int v); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicSetPtr SDL_AtomicSetPtr(void **a,void* v); /* void*  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicTryLock SDL_AtomicTryLock(SDL_SpinLock *lock); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_AtomicUnlock SDL_AtomicUnlock(SDL_SpinLock *lock); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioInit SDL_AudioInit(const char *driver_name); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioQuit SDL_AudioQuit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioStreamAvailable SDL_AudioStreamAvailable(SDL_AudioStream *stream); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioStreamClear SDL_AudioStreamClear(SDL_AudioStream *stream); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioStreamFlush SDL_AudioStreamFlush(SDL_AudioStream *stream); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioStreamGet SDL_AudioStreamGet(SDL_AudioStream *stream,void *buf,int len); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_AudioStreamPut SDL_AudioStreamPut(SDL_AudioStream *stream,const void *buf,int len); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_BuildAudioCVT SDL_BuildAudioCVT(SDL_AudioCVT * cvt,SDL_AudioFormat src_format,Uint8 src_channels,int src_rate,SDL_AudioFormat dst_format,Uint8 dst_channels,int dst_rate); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_CalculateGammaRamp SDL_CalculateGammaRamp(float gamma,Uint16 * ramp); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_CaptureMouse SDL_CaptureMouse(SDL_bool enabled); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ClearError SDL_ClearError(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_ClearHints SDL_ClearHints(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_ClearQueuedAudio SDL_ClearQueuedAudio(SDL_AudioDeviceID dev); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_CloseAudio SDL_CloseAudio(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_CloseAudioDevice SDL_CloseAudioDevice(SDL_AudioDeviceID dev); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_ComposeCustomBlendMode SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor,SDL_BlendFactor dstColorFactor,SDL_BlendOperation colorOperation,SDL_BlendFactor srcAlphaFactor,SDL_BlendFactor dstAlphaFactor,SDL_BlendOperation alphaOperation); /* SDL_BlendMode  */<ESC>?(<CR>
iabbrev <buffer> SDL_CondBroadcast SDL_CondBroadcast(SDL_cond * cond); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_CondSignal SDL_CondSignal(SDL_cond * cond); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_CondWait SDL_CondWait(SDL_cond * cond,SDL_mutex * mutex); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_CondWaitTimeout SDL_CondWaitTimeout(SDL_cond * cond,SDL_mutex * mutex,Uint32 ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ConvertAudio SDL_ConvertAudio(SDL_AudioCVT * cvt); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ConvertPixels SDL_ConvertPixels(int width,int height,Uint32 src_format,const void * src,int src_pitch,Uint32 dst_format,void * dst,int dst_pitch); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ConvertSurface SDL_ConvertSurface (SDL_Surface * src,const SDL_PixelFormat * fmt,Uint32 flags); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_ConvertSurfaceFormat SDL_ConvertSurfaceFormat (SDL_Surface * src,Uint32 pixel_format,Uint32 flags); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateColorCursor SDL_CreateColorCursor(SDL_Surface *surface,int hot_x,int hot_y); /* SDL_Cursor * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateCond SDL_CreateCond(); /* SDL_cond * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateCursor SDL_CreateCursor(const Uint8 * data,const Uint8 * mask,int w,int h,int hot_x,int hot_y); /* SDL_Cursor * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateMutex SDL_CreateMutex(); /* SDL_mutex * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateRGBSurface SDL_CreateRGBSurface (Uint32 flags,int width,int height,int depth,Uint32 Rmask,Uint32 Gmask,Uint32 Bmask,Uint32 Amask); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateRGBSurfaceFrom SDL_CreateRGBSurfaceFrom(void *pixels,int width,int height,int depth,int pitch,Uint32 Rmask,Uint32 Gmask,Uint32 Bmask,Uint32 Amask); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateRGBSurfaceWithFormat SDL_CreateRGBSurfaceWithFormat (Uint32 flags,int width,int height,int depth,Uint32 format); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateRGBSurfaceWithFormatFrom SDL_CreateRGBSurfaceWithFormatFrom (void *pixels,int width,int height,int depth,int pitch,Uint32 format); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateRenderer SDL_CreateRenderer(SDL_Window * window,int index,Uint32 flags); /* SDL_Renderer *  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateSemaphore SDL_CreateSemaphore(Uint32 initial_value); /* SDL_sem * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateShapedWindow SDL_CreateShapedWindow(const char *title,unsigned int x,unsigned int y,unsigned int w,unsigned int h,Uint32 flags); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateSoftwareRenderer SDL_CreateSoftwareRenderer(SDL_Surface * surface); /* SDL_Renderer *  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateSystemCursor SDL_CreateSystemCursor(SDL_SystemCursor id); /* SDL_Cursor * */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateTexture SDL_CreateTexture(SDL_Renderer * renderer,Uint32 format,int access,int w,int h); /* SDL_Texture *  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateTextureFromSurface SDL_CreateTextureFromSurface(SDL_Renderer * renderer,SDL_Surface * surface); /* SDL_Texture *  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateWindow SDL_CreateWindow(const char *title,int x,int y,int w,int h,Uint32 flags); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateWindowAndRenderer SDL_CreateWindowAndRenderer( int width,int height,Uint32 window_flags,SDL_Window **window,SDL_Renderer **renderer); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_CreateWindowFrom SDL_CreateWindowFrom(const void *data); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_DXGIGetOutputInfo SDL_DXGIGetOutputInfo( int displayIndex,int *adapterIndex,int *outputIndex ); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_DelEventWatch SDL_DelEventWatch(SDL_EventFilter filter,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DelHintCallback SDL_DelHintCallback(const char *name,SDL_HintCallback callback,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_Delay SDL_Delay(Uint32 ms); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DequeueAudio SDL_DequeueAudio(SDL_AudioDeviceID dev,void *data,Uint32 len); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_DestroyCond SDL_DestroyCond(SDL_cond * cond); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DestroyMutex SDL_DestroyMutex(SDL_mutex * mutex); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DestroyRenderer SDL_DestroyRenderer(SDL_Renderer * renderer); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DestroySemaphore SDL_DestroySemaphore(SDL_sem * sem); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DestroyTexture SDL_DestroyTexture(SDL_Texture * texture); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DestroyWindow SDL_DestroyWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DetachThread SDL_DetachThread(SDL_Thread * thread); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_Direct SDL_Direct3D9GetAdapterIndex( int displayIndex ); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_DisableScreenSaver SDL_DisableScreenSaver(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_DuplicateSurface SDL_DuplicateSurface(SDL_Surface * surface); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_EnableScreenSaver SDL_EnableScreenSaver(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_EnclosePoints SDL_EnclosePoints(const SDL_Point * points,int count,const SDL_Rect * clip,SDL_Rect * result); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_Error SDL_Error(SDL_errorcode code); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_EventState SDL_EventState(Uint32 type,int state); /* Uint8  */<ESC>?(<CR>
iabbrev <buffer> SDL_FillRect SDL_FillRect (SDL_Surface * dst,const SDL_Rect * rect,Uint32 color); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_FillRects SDL_FillRects (SDL_Surface * dst,const SDL_Rect * rects,int count,Uint32 color); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_FilterEvents SDL_FilterEvents(SDL_EventFilter filter,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FlushEvent SDL_FlushEvent(Uint32 type); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FlushEvents SDL_FlushEvents(Uint32 minType,Uint32 maxType); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreeAudioStream SDL_FreeAudioStream(SDL_AudioStream *stream); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreeCursor SDL_FreeCursor(SDL_Cursor * cursor); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreeFormat SDL_FreeFormat(SDL_PixelFormat *format); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreePalette SDL_FreePalette(SDL_Palette * palette); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreeRW SDL_FreeRW(SDL_RWops * area); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreeSurface SDL_FreeSurface(SDL_Surface * surface); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_FreeWAV SDL_FreeWAV(Uint8 * audio_buf); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_BindTexture SDL_GL_BindTexture(SDL_Texture *texture,float *texw,float *texh); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_CreateContext SDL_GL_CreateContext(SDL_Window * window); /* SDL_GLContext  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_DeleteContext SDL_GL_DeleteContext(SDL_GLContext context); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_ExtensionSupported SDL_GL_ExtensionSupported(const char *extension); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_GetAttribute SDL_GL_GetAttribute(SDL_GLattr attr,int *value); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_GetCurrentContext SDL_GL_GetCurrentContext(); /* SDL_GLContext  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_GetCurrentWindow SDL_GL_GetCurrentWindow(); /* SDL_Window*  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_GetDrawableSize SDL_GL_GetDrawableSize(SDL_Window * window,int *w,int *h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_GetProcAddress SDL_GL_GetProcAddress(const char *proc); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_GetSwapInterval SDL_GL_GetSwapInterval(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_LoadLibrary SDL_GL_LoadLibrary(const char *path); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_MakeCurrent SDL_GL_MakeCurrent(SDL_Window * window,SDL_GLContext context); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_ResetAttributes SDL_GL_ResetAttributes(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_SetAttribute SDL_GL_SetAttribute(SDL_GLattr attr,int value); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_SetSwapInterval SDL_GL_SetSwapInterval(int interval); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_SwapWindow SDL_GL_SwapWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_UnbindTexture SDL_GL_UnbindTexture(SDL_Texture *texture); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GL_UnloadLibrary SDL_GL_UnloadLibrary(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerAddMapping SDL_GameControllerAddMapping(const char* mappingString); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerAddMappingsFromRW SDL_GameControllerAddMappingsFromRW(SDL_RWops * rw,int freerw); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerClose SDL_GameControllerClose(SDL_GameController *gamecontroller); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerEventState SDL_GameControllerEventState(int state); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerFromInstanceID SDL_GameControllerFromInstanceID(SDL_JoystickID joyid); /* SDL_GameController * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerFromPlayerIndex SDL_GameControllerFromPlayerIndex(int player_index); /* SDL_GameController * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetAttached SDL_GameControllerGetAttached(SDL_GameController *gamecontroller); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetAxis SDL_GameControllerGetAxis (SDL_GameController *gamecontroller,SDL_GameControllerAxis axis); /* Sint16 */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetAxisFromString SDL_GameControllerGetAxisFromString(const char *pchString); /* SDL_GameControllerAxis  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetBindForAxis SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,SDL_GameControllerAxis axis); /* SDL_GameControllerButtonBind  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetBindForButton SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,SDL_GameControllerButton button); /* SDL_GameControllerButtonBind  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetButton SDL_GameControllerGetButton(SDL_GameController *gamecontroller,SDL_GameControllerButton button); /* Uint8  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetButtonFromString SDL_GameControllerGetButtonFromString(const char *pchString); /* SDL_GameControllerButton  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetJoystick SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller); /* SDL_Joystick * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetPlayerIndex SDL_GameControllerGetPlayerIndex(SDL_GameController *gamecontroller); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetProduct SDL_GameControllerGetProduct(SDL_GameController * gamecontroller); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetProductVersion SDL_GameControllerGetProductVersion(SDL_GameController * gamecontroller); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetStringForAxis SDL_GameControllerGetStringForAxis(SDL_GameControllerAxis axis); /* const char*  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetStringForButton SDL_GameControllerGetStringForButton(SDL_GameControllerButton button); /* const char*  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetType SDL_GameControllerGetType(SDL_GameController *gamecontroller); /* SDL_GameControllerType  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerGetVendor SDL_GameControllerGetVendor(SDL_GameController * gamecontroller); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerMapping SDL_GameControllerMapping(SDL_GameController * gamecontroller); /* char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerMappingForDeviceIndex SDL_GameControllerMappingForDeviceIndex(int joystick_index); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerMappingForGUID SDL_GameControllerMappingForGUID(SDL_JoystickGUID guid); /* char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerMappingForIndex SDL_GameControllerMappingForIndex(int mapping_index); /* char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerName SDL_GameControllerName(SDL_GameController *gamecontroller); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerNameForIndex SDL_GameControllerNameForIndex(int joystick_index); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerNumMappings SDL_GameControllerNumMappings(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerOpen SDL_GameControllerOpen(int joystick_index); /* SDL_GameController * */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerRumble SDL_GameControllerRumble(SDL_GameController *gamecontroller,Uint16 low_frequency_rumble,Uint16 high_frequency_rumble,Uint32 duration_ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerSetPlayerIndex SDL_GameControllerSetPlayerIndex(SDL_GameController *gamecontroller,int player_index); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerTypeForIndex SDL_GameControllerTypeForIndex(int joystick_index); /* SDL_GameControllerType  */<ESC>?(<CR>
iabbrev <buffer> SDL_GameControllerUpdate SDL_GameControllerUpdate(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAndroidSDKVersion SDL_GetAndroidSDKVersion(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAssertionHandler SDL_GetAssertionHandler(void **puserdata); /* SDL_AssertionHandler  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAssertionReport SDL_GetAssertionReport(); /* const SDL_AssertData *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAudioDeviceName SDL_GetAudioDeviceName(int index,int iscapture); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAudioDeviceStatus SDL_GetAudioDeviceStatus(SDL_AudioDeviceID dev); /* SDL_AudioStatus */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAudioDriver SDL_GetAudioDriver(int index); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetAudioStatus SDL_GetAudioStatus(); /* SDL_AudioStatus  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetBasePath SDL_GetBasePath(); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetCPUCacheLineSize SDL_GetCPUCacheLineSize(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetCPUCount SDL_GetCPUCount(); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetClipRect SDL_GetClipRect(SDL_Surface * surface,SDL_Rect * rect); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetClipboardText SDL_GetClipboardText(); /* char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetClosestDisplayMode SDL_GetClosestDisplayMode(int displayIndex,const SDL_DisplayMode * mode,SDL_DisplayMode * closest); /* SDL_DisplayMode *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetColorKey SDL_GetColorKey(SDL_Surface * surface,Uint32 * key); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetCurrentAudioDriver SDL_GetCurrentAudioDriver(); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetCurrentDisplayMode SDL_GetCurrentDisplayMode(int displayIndex,SDL_DisplayMode * mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetCurrentVideoDriver SDL_GetCurrentVideoDriver(); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetCursor SDL_GetCursor(); /* SDL_Cursor * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDefaultAssertionHandler SDL_GetDefaultAssertionHandler(); /* SDL_AssertionHandler  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDefaultCursor SDL_GetDefaultCursor(); /* SDL_Cursor * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDesktopDisplayMode SDL_GetDesktopDisplayMode(int displayIndex,SDL_DisplayMode * mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDisplayBounds SDL_GetDisplayBounds(int displayIndex,SDL_Rect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDisplayDPI SDL_GetDisplayDPI(int displayIndex,float * ddpi,float * hdpi,float * vdpi); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDisplayMode SDL_GetDisplayMode(int displayIndex,int modeIndex,SDL_DisplayMode * mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDisplayName SDL_GetDisplayName(int displayIndex); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDisplayOrientation SDL_GetDisplayOrientation(int displayIndex); /* SDL_DisplayOrientation  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetDisplayUsableBounds SDL_GetDisplayUsableBounds(int displayIndex,SDL_Rect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetError SDL_GetError(); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetEventFilter SDL_GetEventFilter(SDL_EventFilter * filter,void **userdata); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetGlobalMouseState SDL_GetGlobalMouseState(int *x,int *y); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetGrabbedWindow SDL_GetGrabbedWindow(void); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetHint SDL_GetHint(const char *name); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetHintBoolean SDL_GetHintBoolean(const char *name,SDL_bool default_value); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetKeyFromName SDL_GetKeyFromName(const char *name); /* SDL_Keycode  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetKeyFromScancode SDL_GetKeyFromScancode(SDL_Scancode scancode); /* SDL_Keycode  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetKeyName SDL_GetKeyName(SDL_Keycode key); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetKeyboardFocus SDL_GetKeyboardFocus(void); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetKeyboardState SDL_GetKeyboardState(int *numkeys); /* const Uint8 * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetMemoryFunctions SDL_GetMemoryFunctions(SDL_malloc_func *malloc_func,SDL_calloc_func *calloc_func,SDL_realloc_func *realloc_func,SDL_free_func *free_func); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetModState SDL_GetModState(void); /* SDL_Keymod  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetMouseFocus SDL_GetMouseFocus(void); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetMouseState SDL_GetMouseState(int *x,int *y); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumAllocations SDL_GetNumAllocations(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumAudioDevices SDL_GetNumAudioDevices(int iscapture); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumAudioDrivers SDL_GetNumAudioDrivers(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumDisplayModes SDL_GetNumDisplayModes(int displayIndex); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumRenderDrivers SDL_GetNumRenderDrivers(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumTouchDevices SDL_GetNumTouchDevices(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumTouchFingers SDL_GetNumTouchFingers(SDL_TouchID touchID); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumVideoDisplays SDL_GetNumVideoDisplays(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetNumVideoDrivers SDL_GetNumVideoDrivers(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetPerformanceCounter SDL_GetPerformanceCounter(void); /* Uint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetPerformanceFrequency SDL_GetPerformanceFrequency(void); /* Uint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetPixelFormatName SDL_GetPixelFormatName(Uint32 format); /* const char*  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetPlatform SDL_GetPlatform (void); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetPowerInfo SDL_GetPowerInfo(int *secs,int *pct); /* SDL_PowerState  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetPrefPath SDL_GetPrefPath(const char *org,const char *app); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetQueuedAudioSize SDL_GetQueuedAudioSize(SDL_AudioDeviceID dev); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRGB SDL_GetRGB(Uint32 pixel,const SDL_PixelFormat * format,Uint8 * r,Uint8 * g,Uint8 * b); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRGBA SDL_GetRGBA(Uint32 pixel,const SDL_PixelFormat * format,Uint8 * r,Uint8 * g,Uint8 * b,Uint8 * a); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRelativeMouseMode SDL_GetRelativeMouseMode(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRelativeMouseState SDL_GetRelativeMouseState(int *x,int *y); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRenderDrawBlendMode SDL_GetRenderDrawBlendMode(SDL_Renderer * renderer,SDL_BlendMode *blendMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRenderDrawColor SDL_GetRenderDrawColor(SDL_Renderer * renderer,Uint8 * r,Uint8 * g,Uint8 * b,Uint8 * a); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRenderDriverInfo SDL_GetRenderDriverInfo(int index,SDL_RendererInfo * info); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRenderTarget SDL_GetRenderTarget(SDL_Renderer *renderer); /* SDL_Texture *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRenderer SDL_GetRenderer(SDL_Window * window); /* SDL_Renderer *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRendererInfo SDL_GetRendererInfo(SDL_Renderer * renderer,SDL_RendererInfo * info); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRendererOutputSize SDL_GetRendererOutputSize(SDL_Renderer * renderer,int *w,int *h); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRevision SDL_GetRevision(void); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetRevisionNumber SDL_GetRevisionNumber(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetScancodeFromKey SDL_GetScancodeFromKey(SDL_Keycode key); /* SDL_Scancode  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetScancodeFromName SDL_GetScancodeFromName(const char *name); /* SDL_Scancode  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetScancodeName SDL_GetScancodeName(SDL_Scancode scancode); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetShapedWindowMode SDL_GetShapedWindowMode(SDL_Window *window,SDL_WindowShapeMode *shape_mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetSurfaceAlphaMod SDL_GetSurfaceAlphaMod(SDL_Surface * surface,Uint8 * alpha); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetSurfaceBlendMode SDL_GetSurfaceBlendMode(SDL_Surface * surface,SDL_BlendMode *blendMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetSurfaceColorMod SDL_GetSurfaceColorMod(SDL_Surface * surface,Uint8 * r,Uint8 * g,Uint8 * b); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetSystemRAM SDL_GetSystemRAM(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTextureAlphaMod SDL_GetTextureAlphaMod(SDL_Texture * texture,Uint8 * alpha); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTextureBlendMode SDL_GetTextureBlendMode(SDL_Texture * texture,SDL_BlendMode *blendMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTextureColorMod SDL_GetTextureColorMod(SDL_Texture * texture,Uint8 * r,Uint8 * g,Uint8 * b); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTextureScaleMode SDL_GetTextureScaleMode(SDL_Texture * texture,SDL_ScaleMode *scaleMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetThreadID SDL_GetThreadID(SDL_Thread * thread); /* SDL_threadID  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetThreadName SDL_GetThreadName(SDL_Thread *thread); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTicks SDL_GetTicks(void); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTouchDevice SDL_GetTouchDevice(int index); /* SDL_TouchID  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTouchDeviceType SDL_GetTouchDeviceType(SDL_TouchID touchID); /* SDL_TouchDeviceType  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetTouchFinger SDL_GetTouchFinger(SDL_TouchID touchID,int index); /* SDL_Finger *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetVersion SDL_GetVersion(SDL_version * ver); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetVideoDriver SDL_GetVideoDriver(int index); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowBordersSize SDL_GetWindowBordersSize(SDL_Window * window,int *top,int *left,int *bottom,int *right); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowBrightness SDL_GetWindowBrightness(SDL_Window * window); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowData SDL_GetWindowData(SDL_Window * window,const char *name); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowDisplayIndex SDL_GetWindowDisplayIndex(SDL_Window * window); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowDisplayMode SDL_GetWindowDisplayMode(SDL_Window * window,SDL_DisplayMode * mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowFlags SDL_GetWindowFlags(SDL_Window * window); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowFromID SDL_GetWindowFromID(Uint32 id); /* SDL_Window *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowGammaRamp SDL_GetWindowGammaRamp(SDL_Window * window,Uint16 * red,Uint16 * green,Uint16 * blue); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowGrab SDL_GetWindowGrab(SDL_Window * window); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowID SDL_GetWindowID(SDL_Window * window); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowMaximumSize SDL_GetWindowMaximumSize(SDL_Window * window,int *w,int *h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowMinimumSize SDL_GetWindowMinimumSize(SDL_Window * window,int *w,int *h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowOpacity SDL_GetWindowOpacity(SDL_Window * window,float * out_opacity); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowPixelFormat SDL_GetWindowPixelFormat(SDL_Window * window); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowPosition SDL_GetWindowPosition(SDL_Window * window,int *x,int *y); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowSize SDL_GetWindowSize(SDL_Window * window,int *w,int *h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowSurface SDL_GetWindowSurface(SDL_Window * window); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowTitle SDL_GetWindowTitle(SDL_Window * window); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_GetWindowWMInfo SDL_GetWindowWMInfo(SDL_Window * window,SDL_SysWMinfo * info); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetYUVConversionMode SDL_GetYUVConversionMode(void); /* SDL_YUV_CONVERSION_MODE  */<ESC>?(<CR>
iabbrev <buffer> SDL_GetYUVConversionModeForResolution SDL_GetYUVConversionModeForResolution(int width,int height); /* SDL_YUV_CONVERSION_MODE  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticClose SDL_HapticClose(SDL_Haptic * haptic); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticDestroyEffect SDL_HapticDestroyEffect(SDL_Haptic * haptic,int effect); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticEffectSupported SDL_HapticEffectSupported(SDL_Haptic * haptic,SDL_HapticEffect * effect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticGetEffectStatus SDL_HapticGetEffectStatus(SDL_Haptic * haptic,int effect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticIndex SDL_HapticIndex(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticName SDL_HapticName(int device_index); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticNewEffect SDL_HapticNewEffect(SDL_Haptic * haptic,SDL_HapticEffect * effect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticNumAxes SDL_HapticNumAxes(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticNumEffects SDL_HapticNumEffects(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticNumEffectsPlaying SDL_HapticNumEffectsPlaying(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticOpen SDL_HapticOpen(int device_index); /* SDL_Haptic * */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticOpenFromJoystick SDL_HapticOpenFromJoystick(SDL_Joystick * joystick); /* SDL_Haptic * */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticOpenFromMouse SDL_HapticOpenFromMouse(void); /* SDL_Haptic * */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticOpened SDL_HapticOpened(int device_index); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticPause SDL_HapticPause(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticQuery SDL_HapticQuery(SDL_Haptic * haptic); /* unsigned int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticRumbleInit SDL_HapticRumbleInit(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticRumblePlay SDL_HapticRumblePlay(SDL_Haptic * haptic,float strength,Uint32 length ); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticRumbleStop SDL_HapticRumbleStop(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticRumbleSupported SDL_HapticRumbleSupported(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticRunEffect SDL_HapticRunEffect(SDL_Haptic * haptic,int effect,Uint32 iterations); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticSetAutocenter SDL_HapticSetAutocenter(SDL_Haptic * haptic,int autocenter); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticSetGain SDL_HapticSetGain(SDL_Haptic * haptic,int gain); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticStopAll SDL_HapticStopAll(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticStopEffect SDL_HapticStopEffect(SDL_Haptic * haptic,int effect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticUnpause SDL_HapticUnpause(SDL_Haptic * haptic); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_HapticUpdateEffect SDL_HapticUpdateEffect(SDL_Haptic * haptic,int effect,SDL_HapticEffect * data); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_Has SDL_Has3DNow(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasARMSIMD SDL_HasARMSIMD(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasAVX SDL_HasAVX(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasAVX SDL_HasAVX2(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasAVX SDL_HasAVX512F(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasAltiVec SDL_HasAltiVec(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasClipboardText SDL_HasClipboardText(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasColorKey SDL_HasColorKey(SDL_Surface * surface); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasEvent SDL_HasEvent(Uint32 type); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasEvents SDL_HasEvents(Uint32 minType,Uint32 maxType); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasIntersection SDL_HasIntersection(const SDL_Rect * A,const SDL_Rect * B); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasMMX SDL_HasMMX(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasNEON SDL_HasNEON(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasRDTSC SDL_HasRDTSC(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasSSE SDL_HasSSE(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasSSE SDL_HasSSE2(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasSSE SDL_HasSSE3(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasSSE SDL_HasSSE41(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasSSE SDL_HasSSE42(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HasScreenKeyboardSupport SDL_HasScreenKeyboardSupport(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_HideWindow SDL_HideWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_Init SDL_Init(Uint32 flags); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_InitSubSystem SDL_InitSubSystem(Uint32 flags); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_IntersectRect SDL_IntersectRect(const SDL_Rect * A,const SDL_Rect * B,SDL_Rect * result); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IntersectRectAndLine SDL_IntersectRectAndLine(const SDL_Rect * rect,int *X1,int *Y1,int *X2,int *Y2); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsAndroidTV SDL_IsAndroidTV(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsChromebook SDL_IsChromebook(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsDeXMode SDL_IsDeXMode(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsGameController SDL_IsGameController(int joystick_index); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsScreenKeyboardShown SDL_IsScreenKeyboardShown(SDL_Window *window); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsScreenSaverEnabled SDL_IsScreenSaverEnabled(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsShapedWindow SDL_IsShapedWindow(const SDL_Window *window); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsTablet SDL_IsTablet(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_IsTextInputActive SDL_IsTextInputActive(void); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickClose SDL_JoystickClose(SDL_Joystick * joystick); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickCurrentPowerLevel SDL_JoystickCurrentPowerLevel(SDL_Joystick * joystick); /* SDL_JoystickPowerLevel  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickEventState SDL_JoystickEventState(int state); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickFromInstanceID SDL_JoystickFromInstanceID(SDL_JoystickID instance_id); /* SDL_Joystick * */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickFromPlayerIndex SDL_JoystickFromPlayerIndex(int player_index); /* SDL_Joystick * */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetAttached SDL_JoystickGetAttached(SDL_Joystick * joystick); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetAxis SDL_JoystickGetAxis(SDL_Joystick * joystick,int axis); /* Sint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetAxisInitialState SDL_JoystickGetAxisInitialState(SDL_Joystick * joystick,int axis,Sint16 *state); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetBall SDL_JoystickGetBall(SDL_Joystick * joystick,int ball,int *dx,int *dy); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetButton SDL_JoystickGetButton(SDL_Joystick * joystick,int button); /* Uint8  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDeviceGUID SDL_JoystickGetDeviceGUID(int device_index); /* SDL_JoystickGUID  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDeviceInstanceID SDL_JoystickGetDeviceInstanceID(int device_index); /* SDL_JoystickID  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDevicePlayerIndex SDL_JoystickGetDevicePlayerIndex(int device_index); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDeviceProduct SDL_JoystickGetDeviceProduct(int device_index); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDeviceProductVersion SDL_JoystickGetDeviceProductVersion(int device_index); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDeviceType SDL_JoystickGetDeviceType(int device_index); /* SDL_JoystickType  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetDeviceVendor SDL_JoystickGetDeviceVendor(int device_index); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetGUID SDL_JoystickGetGUID(SDL_Joystick * joystick); /* SDL_JoystickGUID  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetGUIDFromString SDL_JoystickGetGUIDFromString(const char *pchGUID); /* SDL_JoystickGUID  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetGUIDString SDL_JoystickGetGUIDString(SDL_JoystickGUID guid,char *pszGUID,int cbGUID); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetHat SDL_JoystickGetHat(SDL_Joystick * joystick,int hat); /* Uint8  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetPlayerIndex SDL_JoystickGetPlayerIndex(SDL_Joystick * joystick); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetProduct SDL_JoystickGetProduct(SDL_Joystick * joystick); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetProductVersion SDL_JoystickGetProductVersion(SDL_Joystick * joystick); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetType SDL_JoystickGetType(SDL_Joystick * joystick); /* SDL_JoystickType  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickGetVendor SDL_JoystickGetVendor(SDL_Joystick * joystick); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickInstanceID SDL_JoystickInstanceID(SDL_Joystick * joystick); /* SDL_JoystickID  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickIsHaptic SDL_JoystickIsHaptic(SDL_Joystick * joystick); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickName SDL_JoystickName(SDL_Joystick * joystick); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickNameForIndex SDL_JoystickNameForIndex(int device_index); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickNumAxes SDL_JoystickNumAxes(SDL_Joystick * joystick); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickNumBalls SDL_JoystickNumBalls(SDL_Joystick * joystick); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickNumButtons SDL_JoystickNumButtons(SDL_Joystick * joystick); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickNumHats SDL_JoystickNumHats(SDL_Joystick * joystick); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickOpen SDL_JoystickOpen(int device_index); /* SDL_Joystick * */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickRumble SDL_JoystickRumble(SDL_Joystick * joystick,Uint16 low_frequency_rumble,Uint16 high_frequency_rumble,Uint32 duration_ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickSetPlayerIndex SDL_JoystickSetPlayerIndex(SDL_Joystick * joystick,int player_index); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_JoystickUpdate SDL_JoystickUpdate(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LinuxSetThreadPriority SDL_LinuxSetThreadPriority(Sint64 threadID,int priority); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadBMP_RW SDL_LoadBMP_RW(SDL_RWops * src,int freesrc); /* SDL_Surface * */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadDollarTemplates SDL_LoadDollarTemplates(SDL_TouchID touchId,SDL_RWops *src); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadFile SDL_LoadFile(const char *file,size_t *datasize); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadFile_RW SDL_LoadFile_RW(SDL_RWops * src,size_t *datasize,int freesrc); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadFunction SDL_LoadFunction(void *handle,const char *name); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadObject SDL_LoadObject(const char *sofile); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_LoadWAV_RW SDL_LoadWAV_RW(SDL_RWops * src,int freesrc,SDL_AudioSpec * spec,Uint8 ** audio_buf,Uint32 * audio_len); /* SDL_AudioSpec * */<ESC>?(<CR>
iabbrev <buffer> SDL_LockAudio SDL_LockAudio(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LockAudioDevice SDL_LockAudioDevice(SDL_AudioDeviceID dev); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LockJoysticks SDL_LockJoysticks(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LockMutex SDL_LockMutex(SDL_mutex * mutex); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_LockSurface SDL_LockSurface(SDL_Surface * surface); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_LockTexture SDL_LockTexture(SDL_Texture * texture,const SDL_Rect * rect,void **pixels,int *pitch); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_LockTextureToSurface SDL_LockTextureToSurface(SDL_Texture *texture,const SDL_Rect *rect,SDL_Surface **surface); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_Log SDL_Log(SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(1); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogCritical SDL_LogCritical(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogDebug SDL_LogDebug(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogError SDL_LogError(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogGetOutputFunction SDL_LogGetOutputFunction(SDL_LogOutputFunction *callback,void **userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogGetPriority SDL_LogGetPriority(int category); /* SDL_LogPriority  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogInfo SDL_LogInfo(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogMessage SDL_LogMessage(int category,SDL_LogPriority priority,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(3); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogMessageV SDL_LogMessageV(int category,SDL_LogPriority priority,const char *fmt,va_list ap); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogResetPriorities SDL_LogResetPriorities(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogSetAllPriority SDL_LogSetAllPriority(SDL_LogPriority priority); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogSetOutputFunction SDL_LogSetOutputFunction(SDL_LogOutputFunction callback,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogSetPriority SDL_LogSetPriority(int category,SDL_LogPriority priority); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogVerbose SDL_LogVerbose(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LogWarn SDL_LogWarn(int category,SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(2); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_LowerBlit SDL_LowerBlit (SDL_Surface * src,SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_LowerBlitScaled SDL_LowerBlitScaled (SDL_Surface * src,SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_MapRGB SDL_MapRGB(const SDL_PixelFormat * format,Uint8 r,Uint8 g,Uint8 b); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_MapRGBA SDL_MapRGBA(const SDL_PixelFormat * format,Uint8 r,Uint8 g,Uint8 b,Uint8 a); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_MasksToPixelFormatEnum SDL_MasksToPixelFormatEnum(int bpp,Uint32 Rmask,Uint32 Gmask,Uint32 Bmask,Uint32 Amask); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_MaximizeWindow SDL_MaximizeWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_MemoryBarrierAcquireFunction SDL_MemoryBarrierAcquireFunction(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_MemoryBarrierReleaseFunction SDL_MemoryBarrierReleaseFunction(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_Metal_CreateView SDL_Metal_CreateView(SDL_Window * window); /* SDL_MetalView  */<ESC>?(<CR>
iabbrev <buffer> SDL_Metal_DestroyView SDL_Metal_DestroyView(SDL_MetalView view); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_MinimizeWindow SDL_MinimizeWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_MixAudio SDL_MixAudio(Uint8 * dst,const Uint8 * src,Uint32 len,int volume); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_MixAudioFormat SDL_MixAudioFormat(Uint8 * dst,const Uint8 * src,SDL_AudioFormat format,Uint32 len,int volume); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_MouseIsHaptic SDL_MouseIsHaptic(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_NewAudioStream SDL_NewAudioStream(const SDL_AudioFormat src_format,const Uint8 src_channels,const int src_rate,const SDL_AudioFormat dst_format,const Uint8 dst_channels,const int dst_rate); /* SDL_AudioStream *  */<ESC>?(<CR>
iabbrev <buffer> SDL_NumHaptics SDL_NumHaptics(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_NumJoysticks SDL_NumJoysticks(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_NumSensors SDL_NumSensors(void); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationDidBecomeActive SDL_OnApplicationDidBecomeActive(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationDidChangeStatusBarOrientation SDL_OnApplicationDidChangeStatusBarOrientation(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationDidEnterBackground SDL_OnApplicationDidEnterBackground(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationDidReceiveMemoryWarning SDL_OnApplicationDidReceiveMemoryWarning(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationWillEnterForeground SDL_OnApplicationWillEnterForeground(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationWillResignActive SDL_OnApplicationWillResignActive(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OnApplicationWillTerminate SDL_OnApplicationWillTerminate(void); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_OpenAudio SDL_OpenAudio(SDL_AudioSpec * desired,SDL_AudioSpec * obtained); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_OpenAudioDevice SDL_OpenAudioDevice(const char *device,int iscapture,const SDL_AudioSpec * desired,SDL_AudioSpec * obtained,int allowed_changes); /* SDL_AudioDeviceID  */<ESC>?(<CR>
iabbrev <buffer> SDL_PauseAudio SDL_PauseAudio(int pause_on); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_PauseAudioDevice SDL_PauseAudioDevice(SDL_AudioDeviceID dev,int pause_on); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_PeepEvents SDL_PeepEvents(SDL_Event * events,int numevents,SDL_eventaction action,Uint32 minType,Uint32 maxType); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_PixelFormatEnumToMasks SDL_PixelFormatEnumToMasks(Uint32 format,int *bpp,Uint32 * Rmask,Uint32 * Gmask,Uint32 * Bmask,Uint32 * Amask); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_PollEvent SDL_PollEvent(SDL_Event * event); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_PumpEvents SDL_PumpEvents(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_PushEvent SDL_PushEvent(SDL_Event * event); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_QueryTexture SDL_QueryTexture(SDL_Texture * texture,Uint32 * format,int *access,int *w,int *h); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_QueueAudio SDL_QueueAudio(SDL_AudioDeviceID dev,const void *data,Uint32 len); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_Quit SDL_Quit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_QuitSubSystem SDL_QuitSubSystem(Uint32 flags); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RWFromConstMem SDL_RWFromConstMem(const void *mem,int size); /* SDL_RWops * */<ESC>?(<CR>
iabbrev <buffer> SDL_RWFromFP SDL_RWFromFP(FILE * fp,SDL_bool autoclose); /* SDL_RWops * */<ESC>?(<CR>
iabbrev <buffer> SDL_RWFromFP SDL_RWFromFP(void * fp,SDL_bool autoclose); /* SDL_RWops * */<ESC>?(<CR>
iabbrev <buffer> SDL_RWFromFile SDL_RWFromFile(const char *file,const char *mode); /* SDL_RWops * */<ESC>?(<CR>
iabbrev <buffer> SDL_RWFromMem SDL_RWFromMem(void *mem,int size); /* SDL_RWops * */<ESC>?(<CR>
iabbrev <buffer> SDL_RWclose SDL_RWclose(SDL_RWops *context); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RWread SDL_RWread(SDL_RWops *context,void *ptr,size_t size,size_t maxnum); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_RWseek SDL_RWseek(SDL_RWops *context,Sint64 offset,int whence); /* Sint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_RWsize SDL_RWsize(SDL_RWops *context); /* Sint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_RWtell SDL_RWtell(SDL_RWops *context); /* Sint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_RWwrite SDL_RWwrite(SDL_RWops *context,const void *ptr,size_t size,size_t num); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_RaiseWindow SDL_RaiseWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadBE SDL_ReadBE16(SDL_RWops * src); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadBE SDL_ReadBE32(SDL_RWops * src); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadBE SDL_ReadBE64(SDL_RWops * src); /* Uint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadLE SDL_ReadLE16(SDL_RWops * src); /* Uint16  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadLE SDL_ReadLE32(SDL_RWops * src); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadLE SDL_ReadLE64(SDL_RWops * src); /* Uint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReadU SDL_ReadU8(SDL_RWops * src); /* Uint8  */<ESC>?(<CR>
iabbrev <buffer> SDL_RecordGesture SDL_RecordGesture(SDL_TouchID touchId); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RegisterApp SDL_RegisterApp(char *name,Uint32 style,void *hInst); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RegisterEvents SDL_RegisterEvents(int numevents); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_RemoveTimer SDL_RemoveTimer(SDL_TimerID id); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderClear SDL_RenderClear(SDL_Renderer * renderer); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderCopy SDL_RenderCopy(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_Rect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderCopyEx SDL_RenderCopyEx(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_Rect * dstrect,const double angle,const SDL_Point *center,const SDL_RendererFlip flip); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderCopyExF SDL_RenderCopyExF(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_FRect * dstrect,const double angle,const SDL_FPoint *center,const SDL_RendererFlip flip); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderCopyF SDL_RenderCopyF(SDL_Renderer * renderer,SDL_Texture * texture,const SDL_Rect * srcrect,const SDL_FRect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawLine SDL_RenderDrawLine(SDL_Renderer * renderer,int x1,int y1,int x2,int y2); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawLineF SDL_RenderDrawLineF(SDL_Renderer * renderer,float x1,float y1,float x2,float y2); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawLines SDL_RenderDrawLines(SDL_Renderer * renderer,const SDL_Point * points,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawLinesF SDL_RenderDrawLinesF(SDL_Renderer * renderer,const SDL_FPoint * points,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawPoint SDL_RenderDrawPoint(SDL_Renderer * renderer,int x,int y); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawPointF SDL_RenderDrawPointF(SDL_Renderer * renderer,float x,float y); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawPoints SDL_RenderDrawPoints(SDL_Renderer * renderer,const SDL_Point * points,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawPointsF SDL_RenderDrawPointsF(SDL_Renderer * renderer,const SDL_FPoint * points,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawRect SDL_RenderDrawRect(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawRectF SDL_RenderDrawRectF(SDL_Renderer * renderer,const SDL_FRect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawRects SDL_RenderDrawRects(SDL_Renderer * renderer,const SDL_Rect * rects,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderDrawRectsF SDL_RenderDrawRectsF(SDL_Renderer * renderer,const SDL_FRect * rects,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderFillRect SDL_RenderFillRect(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderFillRectF SDL_RenderFillRectF(SDL_Renderer * renderer,const SDL_FRect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderFillRects SDL_RenderFillRects(SDL_Renderer * renderer,const SDL_Rect * rects,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderFillRectsF SDL_RenderFillRectsF(SDL_Renderer * renderer,const SDL_FRect * rects,int count); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderFlush SDL_RenderFlush(SDL_Renderer * renderer); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetClipRect SDL_RenderGetClipRect(SDL_Renderer * renderer,SDL_Rect * rect); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetD SDL_RenderGetD3D9Device(SDL_Renderer * renderer); /* IDirect3DDevice9*  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetIntegerScale SDL_RenderGetIntegerScale(SDL_Renderer * renderer); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetLogicalSize SDL_RenderGetLogicalSize(SDL_Renderer * renderer,int *w,int *h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetMetalCommandEncoder SDL_RenderGetMetalCommandEncoder(SDL_Renderer * renderer); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetMetalLayer SDL_RenderGetMetalLayer(SDL_Renderer * renderer); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetScale SDL_RenderGetScale(SDL_Renderer * renderer,float *scaleX,float *scaleY); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderGetViewport SDL_RenderGetViewport(SDL_Renderer * renderer,SDL_Rect * rect); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderIsClipEnabled SDL_RenderIsClipEnabled(SDL_Renderer * renderer); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderPresent SDL_RenderPresent(SDL_Renderer * renderer); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderReadPixels SDL_RenderReadPixels(SDL_Renderer * renderer,const SDL_Rect * rect,Uint32 format,void *pixels,int pitch); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderSetClipRect SDL_RenderSetClipRect(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderSetIntegerScale SDL_RenderSetIntegerScale(SDL_Renderer * renderer,SDL_bool enable); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderSetLogicalSize SDL_RenderSetLogicalSize(SDL_Renderer * renderer,int w,int h); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderSetScale SDL_RenderSetScale(SDL_Renderer * renderer,float scaleX,float scaleY); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderSetViewport SDL_RenderSetViewport(SDL_Renderer * renderer,const SDL_Rect * rect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_RenderTargetSupported SDL_RenderTargetSupported(SDL_Renderer *renderer); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_ReportAssertion SDL_ReportAssertion(SDL_AssertData *,const char *,const char *,int); /* SDL_AssertState  */<ESC>?(<CR>
iabbrev <buffer> SDL_ResetAssertionReport SDL_ResetAssertionReport(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_RestoreWindow SDL_RestoreWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SIMDAlloc SDL_SIMDAlloc(const size_t len); /* void *  */<ESC>?(<CR>
iabbrev <buffer> SDL_SIMDFree SDL_SIMDFree(void *ptr); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SIMDGetAlignment SDL_SIMDGetAlignment(); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_SaveAllDollarTemplates SDL_SaveAllDollarTemplates(SDL_RWops *dst); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SaveBMP_RW SDL_SaveBMP_RW (SDL_Surface * surface,SDL_RWops * dst,int freedst); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SaveDollarTemplate SDL_SaveDollarTemplate(SDL_GestureID gestureId,SDL_RWops *dst); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SemPost SDL_SemPost(SDL_sem * sem); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SemTryWait SDL_SemTryWait(SDL_sem * sem); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SemValue SDL_SemValue(SDL_sem * sem); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_SemWait SDL_SemWait(SDL_sem * sem); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SemWaitTimeout SDL_SemWaitTimeout(SDL_sem * sem,Uint32 ms); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorClose SDL_SensorClose(SDL_Sensor * sensor); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorFromInstanceID SDL_SensorFromInstanceID(SDL_SensorID instance_id); /* SDL_Sensor * */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetData SDL_SensorGetData(SDL_Sensor * sensor,float *data,int num_values); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetDeviceInstanceID SDL_SensorGetDeviceInstanceID(int device_index); /* SDL_SensorID  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetDeviceName SDL_SensorGetDeviceName(int device_index); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetDeviceNonPortableType SDL_SensorGetDeviceNonPortableType(int device_index); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetDeviceType SDL_SensorGetDeviceType(int device_index); /* SDL_SensorType  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetInstanceID SDL_SensorGetInstanceID(SDL_Sensor *sensor); /* SDL_SensorID  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetName SDL_SensorGetName(SDL_Sensor *sensor); /* const char * */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetNonPortableType SDL_SensorGetNonPortableType(SDL_Sensor *sensor); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorGetType SDL_SensorGetType(SDL_Sensor *sensor); /* SDL_SensorType  */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorOpen SDL_SensorOpen(int device_index); /* SDL_Sensor * */<ESC>?(<CR>
iabbrev <buffer> SDL_SensorUpdate SDL_SensorUpdate(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetAssertionHandler SDL_SetAssertionHandler( SDL_AssertionHandler handler,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetClipRect SDL_SetClipRect(SDL_Surface * surface,const SDL_Rect * rect); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetClipboardText SDL_SetClipboardText(const char *text); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetColorKey SDL_SetColorKey(SDL_Surface * surface,int flag,Uint32 key); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetCursor SDL_SetCursor(SDL_Cursor * cursor); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetError SDL_SetError(SDL_PRINTF_FORMAT_STRING const char *fmt,...) SDL_PRINTF_VARARG_FUNC(1); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetEventFilter SDL_SetEventFilter(SDL_EventFilter filter,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetHint SDL_SetHint(const char *name,const char *value); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetHintWithPriority SDL_SetHintWithPriority(const char *name,const char *value,SDL_HintPriority priority); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetMainReady SDL_SetMainReady(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetMemoryFunctions SDL_SetMemoryFunctions(SDL_malloc_func malloc_func,SDL_calloc_func calloc_func,SDL_realloc_func realloc_func,SDL_free_func free_func); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetModState SDL_SetModState(SDL_Keymod modstate); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetPaletteColors SDL_SetPaletteColors(SDL_Palette * palette,const SDL_Color * colors,int firstcolor,int ncolors); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetPixelFormatPalette SDL_SetPixelFormatPalette(SDL_PixelFormat * format,SDL_Palette *palette); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetRelativeMouseMode SDL_SetRelativeMouseMode(SDL_bool enabled); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetRenderDrawBlendMode SDL_SetRenderDrawBlendMode(SDL_Renderer * renderer,SDL_BlendMode blendMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetRenderDrawColor SDL_SetRenderDrawColor(SDL_Renderer * renderer,Uint8 r,Uint8 g,Uint8 b,Uint8 a); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetRenderTarget SDL_SetRenderTarget(SDL_Renderer *renderer,SDL_Texture *texture); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetSurfaceAlphaMod SDL_SetSurfaceAlphaMod(SDL_Surface * surface,Uint8 alpha); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetSurfaceBlendMode SDL_SetSurfaceBlendMode(SDL_Surface * surface,SDL_BlendMode blendMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetSurfaceColorMod SDL_SetSurfaceColorMod(SDL_Surface * surface,Uint8 r,Uint8 g,Uint8 b); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetSurfacePalette SDL_SetSurfacePalette(SDL_Surface * surface,SDL_Palette * palette); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetSurfaceRLE SDL_SetSurfaceRLE(SDL_Surface * surface,int flag); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetTextInputRect SDL_SetTextInputRect(SDL_Rect *rect); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetTextureAlphaMod SDL_SetTextureAlphaMod(SDL_Texture * texture,Uint8 alpha); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetTextureBlendMode SDL_SetTextureBlendMode(SDL_Texture * texture,SDL_BlendMode blendMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetTextureColorMod SDL_SetTextureColorMod(SDL_Texture * texture,Uint8 r,Uint8 g,Uint8 b); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetTextureScaleMode SDL_SetTextureScaleMode(SDL_Texture * texture,SDL_ScaleMode scaleMode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetThreadPriority SDL_SetThreadPriority(SDL_ThreadPriority priority); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowBordered SDL_SetWindowBordered(SDL_Window * window,SDL_bool bordered); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowBrightness SDL_SetWindowBrightness(SDL_Window * window,float brightness); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowData SDL_SetWindowData(SDL_Window * window,const char *name,void *userdata); /* void*  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowDisplayMode SDL_SetWindowDisplayMode(SDL_Window * window,const SDL_DisplayMode * mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowFullscreen SDL_SetWindowFullscreen(SDL_Window * window,Uint32 flags); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowGammaRamp SDL_SetWindowGammaRamp(SDL_Window * window,const Uint16 * red,const Uint16 * green,const Uint16 * blue); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowGrab SDL_SetWindowGrab(SDL_Window * window,SDL_bool grabbed); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowHitTest SDL_SetWindowHitTest(SDL_Window * window,SDL_HitTest callback,void *callback_data); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowIcon SDL_SetWindowIcon(SDL_Window * window,SDL_Surface * icon); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowInputFocus SDL_SetWindowInputFocus(SDL_Window * window); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowMaximumSize SDL_SetWindowMaximumSize(SDL_Window * window,int max_w,int max_h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowMinimumSize SDL_SetWindowMinimumSize(SDL_Window * window,int min_w,int min_h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowModalFor SDL_SetWindowModalFor(SDL_Window * modal_window,SDL_Window * parent_window); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowOpacity SDL_SetWindowOpacity(SDL_Window * window,float opacity); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowPosition SDL_SetWindowPosition(SDL_Window * window,int x,int y); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowResizable SDL_SetWindowResizable(SDL_Window * window,SDL_bool resizable); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowShape SDL_SetWindowShape(SDL_Window *window,SDL_Surface *shape,SDL_WindowShapeMode *shape_mode); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowSize SDL_SetWindowSize(SDL_Window * window,int w,int h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowTitle SDL_SetWindowTitle(SDL_Window * window,const char *title); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetWindowsMessageHook SDL_SetWindowsMessageHook(SDL_WindowsMessageHook callback,void *userdata); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SetYUVConversionMode SDL_SetYUVConversionMode(SDL_YUV_CONVERSION_MODE mode); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_ShowCursor SDL_ShowCursor(int toggle); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ShowMessageBox SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata,int *buttonid); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ShowSimpleMessageBox SDL_ShowSimpleMessageBox(Uint32 flags,const char *title,const char *message,SDL_Window *window); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_ShowWindow SDL_ShowWindow(SDL_Window * window); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_SoftStretch SDL_SoftStretch(SDL_Surface * src,const SDL_Rect * srcrect,SDL_Surface * dst,const SDL_Rect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_StartTextInput SDL_StartTextInput(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_StopTextInput SDL_StopTextInput(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_TLSCreate SDL_TLSCreate(); /* SDL_TLSID  */<ESC>?(<CR>
iabbrev <buffer> SDL_TLSGet SDL_TLSGet(SDL_TLSID id); /* void *  */<ESC>?(<CR>
iabbrev <buffer> SDL_ThreadID SDL_ThreadID(); /* SDL_threadID  */<ESC>?(<CR>
iabbrev <buffer> SDL_TryLockMutex SDL_TryLockMutex(SDL_mutex * mutex); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UIKitRunApp SDL_UIKitRunApp(int argc,char *argv[],SDL_main_func mainFunction); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnionRect SDL_UnionRect(const SDL_Rect * A,const SDL_Rect * B,SDL_Rect * result); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnloadObject SDL_UnloadObject(void *handle); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnlockAudio SDL_UnlockAudio(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnlockAudioDevice SDL_UnlockAudioDevice(SDL_AudioDeviceID dev); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnlockJoysticks SDL_UnlockJoysticks(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnlockMutex SDL_UnlockMutex(SDL_mutex * mutex); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnlockSurface SDL_UnlockSurface(SDL_Surface * surface); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnlockTexture SDL_UnlockTexture(SDL_Texture * texture); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UnregisterApp SDL_UnregisterApp(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_UpdateTexture SDL_UpdateTexture(SDL_Texture * texture,const SDL_Rect * rect,const void *pixels,int pitch); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UpdateWindowSurface SDL_UpdateWindowSurface(SDL_Window * window); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UpdateWindowSurfaceRects SDL_UpdateWindowSurfaceRects(SDL_Window * window,const SDL_Rect * rects,int numrects); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UpdateYUVTexture SDL_UpdateYUVTexture(SDL_Texture * texture,const SDL_Rect * rect,const Uint8 *Yplane,int Ypitch,const Uint8 *Uplane,int Upitch,const Uint8 *Vplane,int Vpitch); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UpperBlit SDL_UpperBlit (SDL_Surface * src,const SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_UpperBlitScaled SDL_UpperBlitScaled (SDL_Surface * src,const SDL_Rect * srcrect,SDL_Surface * dst,SDL_Rect * dstrect); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_VideoInit SDL_VideoInit(const char *driver_name); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_VideoQuit SDL_VideoQuit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_Vulkan_CreateSurface SDL_Vulkan_CreateSurface(												SDL_Window *window,												VkInstance instance,												VkSurfaceKHR* surface); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_Vulkan_GetDrawableSize SDL_Vulkan_GetDrawableSize(SDL_Window * window,int *w,int *h); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_Vulkan_GetInstanceExtensions SDL_Vulkan_GetInstanceExtensions(														SDL_Window *window,														unsigned int *pCount,														const char **pNames); /* SDL_bool  */<ESC>?(<CR>
iabbrev <buffer> SDL_Vulkan_GetVkGetInstanceProcAddr SDL_Vulkan_GetVkGetInstanceProcAddr(); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_Vulkan_LoadLibrary SDL_Vulkan_LoadLibrary(const char *path); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_Vulkan_UnloadLibrary SDL_Vulkan_UnloadLibrary(); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_WaitEvent SDL_WaitEvent(SDL_Event * event); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_WaitEventTimeout SDL_WaitEventTimeout(SDL_Event * event,int timeout); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_WaitThread SDL_WaitThread(SDL_Thread * thread,int *status); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_WarpMouseGlobal SDL_WarpMouseGlobal(int x,int y); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_WarpMouseInWindow SDL_WarpMouseInWindow(SDL_Window * window,int x,int y); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_WasInit SDL_WasInit(Uint32 flags); /* Uint32  */<ESC>?(<CR>
iabbrev <buffer> SDL_WinRTGetDeviceFamily SDL_WinRTGetDeviceFamily(); /* SDL_WinRT_DeviceFamily  */<ESC>?(<CR>
iabbrev <buffer> SDL_WinRTGetFSPathUNICODE SDL_WinRTGetFSPathUNICODE(SDL_WinRT_Path pathType); /* const wchar_t *  */<ESC>?(<CR>
iabbrev <buffer> SDL_WinRTGetFSPathUTF SDL_WinRTGetFSPathUTF8(SDL_WinRT_Path pathType); /* const char *  */<ESC>?(<CR>
iabbrev <buffer> SDL_WinRTRunApp SDL_WinRTRunApp(SDL_main_func mainFunction,void * reserved); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteBE SDL_WriteBE16(SDL_RWops * dst,Uint16 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteBE SDL_WriteBE32(SDL_RWops * dst,Uint32 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteBE SDL_WriteBE64(SDL_RWops * dst,Uint64 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteLE SDL_WriteLE16(SDL_RWops * dst,Uint16 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteLE SDL_WriteLE32(SDL_RWops * dst,Uint32 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteLE SDL_WriteLE64(SDL_RWops * dst,Uint64 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_WriteU SDL_WriteU8(SDL_RWops * dst,Uint8 value); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_abs SDL_abs(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_acos SDL_acos(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_acosf SDL_acosf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_asin SDL_asin(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_asinf SDL_asinf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_atan SDL_atan(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_atan SDL_atan2(double x,double y); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_atan SDL_atan2f(float x,float y); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_atanf SDL_atanf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_atof SDL_atof(const char *str); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_atoi SDL_atoi(const char *str); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_calloc SDL_calloc(size_t nmemb,size_t size); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_ceil SDL_ceil(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_ceilf SDL_ceilf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_copysign SDL_copysign(double x,double y); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_copysignf SDL_copysignf(float x,float y); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_cos SDL_cos(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_cosf SDL_cosf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_exp SDL_exp(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_expf SDL_expf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_fabs SDL_fabs(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_fabsf SDL_fabsf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_floor SDL_floor(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_floorf SDL_floorf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_fmod SDL_fmod(double x,double y); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_fmodf SDL_fmodf(float x,float y); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_free SDL_free(void *mem); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_getenv SDL_getenv(const char *name); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_iPhoneSetAnimationCallback SDL_iPhoneSetAnimationCallback(SDL_Window * window,int interval,void (*callback)(void*),void *callbackParam); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_iPhoneSetEventPump SDL_iPhoneSetEventPump(SDL_bool enabled); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_iconv SDL_iconv(SDL_iconv_t cd,const char **inbuf,size_t * inbytesleft,char **outbuf,size_t * outbytesleft); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_iconv_close SDL_iconv_close(SDL_iconv_t cd); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_iconv_open SDL_iconv_open(const char *tocode,const char *fromcode); /* SDL_iconv_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_iconv_string SDL_iconv_string(const char *tocode,const char *fromcode,const char *inbuf,size_t inbytesleft); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_isdigit SDL_isdigit(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_islower SDL_islower(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_isspace SDL_isspace(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_isupper SDL_isupper(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_itoa SDL_itoa(int value,char *str,int radix); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_lltoa SDL_lltoa(Sint64 value,char *str,int radix); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_log SDL_log(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_log SDL_log10(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_log SDL_log10f(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_logf SDL_logf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_ltoa SDL_ltoa(long value,char *str,int radix); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_malloc SDL_malloc(size_t size); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_memcmp SDL_memcmp(const void *s1,const void *s2,size_t len); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_memcpy SDL_memcpy(SDL_OUT_BYTECAP(len) void *dst,SDL_IN_BYTECAP(len) const void *src,size_t len); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_memmove SDL_memmove(SDL_OUT_BYTECAP(len) void *dst,SDL_IN_BYTECAP(len) const void *src,size_t len); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_memset SDL_memset(SDL_OUT_BYTECAP(len) void *dst,int c,size_t len); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_pow SDL_pow(double x,double y); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_powf SDL_powf(float x,float y); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_qsort SDL_qsort(void *base,size_t nmemb,size_t size,int (*compare) (const void *,const void *)); /* void  */<ESC>?(<CR>
iabbrev <buffer> SDL_realloc SDL_realloc(void *mem,size_t size); /* void * */<ESC>?(<CR>
iabbrev <buffer> SDL_scalbn SDL_scalbn(double x,int n); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_scalbnf SDL_scalbnf(float x,int n); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_setenv SDL_setenv(const char *name,const char *value,int overwrite); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_sin SDL_sin(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_sinf SDL_sinf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_snprintf SDL_snprintf(SDL_OUT_Z_CAP(maxlen) char *text,size_t maxlen,SDL_PRINTF_FORMAT_STRING const char *fmt,... ) SDL_PRINTF_VARARG_FUNC(3); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_sqrt SDL_sqrt(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_sqrtf SDL_sqrtf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_sscanf SDL_sscanf(const char *text,SDL_SCANF_FORMAT_STRING const char *fmt,...) SDL_SCANF_VARARG_FUNC(2); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_strcasecmp SDL_strcasecmp(const char *str1,const char *str2); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_strchr SDL_strchr(const char *str,int c); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strcmp SDL_strcmp(const char *str1,const char *str2); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_strdup SDL_strdup(const char *str); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strlcat SDL_strlcat(SDL_INOUT_Z_CAP(maxlen) char *dst,const char *src,size_t maxlen); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_strlcpy SDL_strlcpy(SDL_OUT_Z_CAP(maxlen) char *dst,const char *src,size_t maxlen); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_strlen SDL_strlen(const char *str); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_strlwr SDL_strlwr(char *str); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strncasecmp SDL_strncasecmp(const char *str1,const char *str2,size_t len); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_strncmp SDL_strncmp(const char *str1,const char *str2,size_t maxlen); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_strrchr SDL_strrchr(const char *str,int c); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strrev SDL_strrev(char *str); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strstr SDL_strstr(const char *haystack,const char *needle); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strtod SDL_strtod(const char *str,char **endp); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_strtokr SDL_strtokr(char *s1,const char *s2,char **saveptr); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_strtol SDL_strtol(const char *str,char **endp,int base); /* long  */<ESC>?(<CR>
iabbrev <buffer> SDL_strtoll SDL_strtoll(const char *str,char **endp,int base); /* Sint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_strtoul SDL_strtoul(const char *str,char **endp,int base); /* unsigned long  */<ESC>?(<CR>
iabbrev <buffer> SDL_strtoull SDL_strtoull(const char *str,char **endp,int base); /* Uint64  */<ESC>?(<CR>
iabbrev <buffer> SDL_strupr SDL_strupr(char *str); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_tan SDL_tan(double x); /* double  */<ESC>?(<CR>
iabbrev <buffer> SDL_tanf SDL_tanf(float x); /* float  */<ESC>?(<CR>
iabbrev <buffer> SDL_tolower SDL_tolower(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_toupper SDL_toupper(int x); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_uitoa SDL_uitoa(unsigned int value,char *str,int radix); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_ulltoa SDL_ulltoa(Uint64 value,char *str,int radix); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_ultoa SDL_ultoa(unsigned long value,char *str,int radix); /* char * */<ESC>?(<CR>
iabbrev <buffer> SDL_utf SDL_utf8strlcpy(SDL_OUT_Z_CAP(dst_bytes) char *dst,const char *src,size_t dst_bytes); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_utf SDL_utf8strlen(const char *str); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_vsnprintf SDL_vsnprintf(SDL_OUT_Z_CAP(maxlen) char *text,size_t maxlen,const char *fmt,va_list ap); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_vsscanf SDL_vsscanf(const char *text,const char *fmt,va_list ap); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_wcscmp SDL_wcscmp(const wchar_t *str1,const wchar_t *str2); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_wcsdup SDL_wcsdup(const wchar_t *wstr); /* wchar_t * */<ESC>?(<CR>
iabbrev <buffer> SDL_wcslcat SDL_wcslcat(SDL_INOUT_Z_CAP(maxlen) wchar_t *dst,const wchar_t *src,size_t maxlen); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_wcslcpy SDL_wcslcpy(SDL_OUT_Z_CAP(maxlen) wchar_t *dst,const wchar_t *src,size_t maxlen); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_wcslen SDL_wcslen(const wchar_t *wstr); /* size_t  */<ESC>?(<CR>
iabbrev <buffer> SDL_wcsncmp SDL_wcsncmp(const wchar_t *str1,const wchar_t *str2,size_t maxlen); /* int  */<ESC>?(<CR>
iabbrev <buffer> SDL_wcsstr SDL_wcsstr(const wchar_t *haystack,const wchar_t *needle); /* wchar_t * */<ESC>?(<CR>

" TTF SDL_TTF sdl_ttf sdlttf
iabbrev <buffer> TTF_ByteSwappedUNICODE TTF_ByteSwappedUNICODE(int swapped); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_CloseFont TTF_CloseFont(TTF_Font *font); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontAscent TTF_FontAscent(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontDescent TTF_FontDescent(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontFaceFamilyName TTF_FontFaceFamilyName(const TTF_Font *font); /* char *  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontFaceIsFixedWidth TTF_FontFaceIsFixedWidth(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontFaceStyleName TTF_FontFaceStyleName(const TTF_Font *font); /* char *  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontFaces TTF_FontFaces(const TTF_Font *font); /* long  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontHeight TTF_FontHeight(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_FontLineSkip TTF_FontLineSkip(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_GetFontHinting TTF_GetFontHinting(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_GetFontKerning TTF_GetFontKerning(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_GetFontKerningSize TTF_GetFontKerningSize(TTF_Font *font,int prev_index,int index) SDL_DEPRECATED;<ESC>?(<CR>
iabbrev <buffer> TTF_GetFontKerningSizeGlyphs TTF_GetFontKerningSizeGlyphs(TTF_Font *font,Uint16 previous_ch,Uint16 ch);<ESC>?(<CR>
iabbrev <buffer> TTF_GetFontOutline TTF_GetFontOutline(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_GetFontStyle TTF_GetFontStyle(const TTF_Font *font); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_GlyphIsProvided TTF_GlyphIsProvided(const TTF_Font *font,Uint16 ch); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_GlyphMetrics TTF_GlyphMetrics(TTF_Font *font,Uint16 ch,int *minx,int *maxx,int *miny,int *maxy,int *advance); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_Init TTF_Init(); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_Linked_Version TTF_Linked_Version(); /* const SDL_version *  */<ESC>?(<CR>
iabbrev <buffer> TTF_OpenFont TTF_OpenFont(const char *file,int ptsize); /* TTF_Font *  */<ESC>?(<CR>
iabbrev <buffer> TTF_OpenFontIndex TTF_OpenFontIndex(const char *file,int ptsize,long index); /* TTF_Font *  */<ESC>?(<CR>
iabbrev <buffer> TTF_OpenFontIndexRW TTF_OpenFontIndexRW(SDL_RWops *src,int freesrc,int ptsize,long index); /* TTF_Font *  */<ESC>?(<CR>
iabbrev <buffer> TTF_OpenFontRW TTF_OpenFontRW(SDL_RWops *src,int freesrc,int ptsize); /* TTF_Font *  */<ESC>?(<CR>
iabbrev <buffer> TTF_Quit TTF_Quit(); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderGlyph_Blended TTF_RenderGlyph_Blended(TTF_Font *font,Uint16 ch,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderGlyph_Shaded TTF_RenderGlyph_Shaded(TTF_Font *font,Uint16 ch,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderGlyph_Solid TTF_RenderGlyph_Solid(TTF_Font *font,Uint16 ch,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderText_Blended TTF_RenderText_Blended(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderText_Blended_Wrapped TTF_RenderText_Blended_Wrapped(TTF_Font *font,const char *text,SDL_Color fg,Uint32 wrapLength); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderText_Shaded TTF_RenderText_Shaded(TTF_Font *font,const char *text,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderText_Solid TTF_RenderText_Solid(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUNICODE_Blended TTF_RenderUNICODE_Blended(TTF_Font *font,const Uint16 *text,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUNICODE_Blended_Wrapped TTF_RenderUNICODE_Blended_Wrapped(TTF_Font *font,const Uint16 *text,SDL_Color fg,Uint32 wrapLength); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUNICODE_Shaded TTF_RenderUNICODE_Shaded(TTF_Font *font,const Uint16 *text,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUNICODE_Solid TTF_RenderUNICODE_Solid(TTF_Font *font,const Uint16 *text,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUTF TTF_RenderUTF8_Blended(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUTF TTF_RenderUTF8_Blended_Wrapped(TTF_Font *font,const char *text,SDL_Color fg,Uint32 wrapLength); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUTF TTF_RenderUTF8_Shaded(TTF_Font *font,const char *text,SDL_Color fg,SDL_Color bg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_RenderUTF TTF_RenderUTF8_Solid(TTF_Font *font,const char *text,SDL_Color fg); /* SDL_Surface *  */<ESC>?(<CR>
iabbrev <buffer> TTF_SetFontHinting TTF_SetFontHinting(TTF_Font *font,int hinting); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_SetFontKerning TTF_SetFontKerning(TTF_Font *font,int allowed); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_SetFontOutline TTF_SetFontOutline(TTF_Font *font,int outline); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_SetFontStyle TTF_SetFontStyle(TTF_Font *font,int style); /* void  */<ESC>?(<CR>
iabbrev <buffer> TTF_SizeText TTF_SizeText(TTF_Font *font,const char *text,int *w,int *h); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_SizeUNICODE TTF_SizeUNICODE(TTF_Font *font,const Uint16 *text,int *w,int *h); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_SizeUTF TTF_SizeUTF8(TTF_Font *font,const char *text,int *w,int *h); /* int  */<ESC>?(<CR>
iabbrev <buffer> TTF_WasInit TTF_WasInit(); /* int  */<ESC>?(<CR>

let b:did_ftplugin = 1
