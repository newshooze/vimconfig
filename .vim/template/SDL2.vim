#include <stdio.h>
#include <SDL2/SDL.h>

int main(int argc,char **argv)
{
	SDL_Event e;
	SDL_Window *window = SDL_CreateWindow("SDL",100,100,800,600,SDL_WINDOW_SHOWN);
	SDL_Renderer *rend = SDL_CreateRenderer(window,-1,SDL_RENDERER_ACCELERATED);
	SDL_SetRenderDrawColor(rend,0,0,0,0xff);
	SDL_RenderClear(rend);
	SDL_RenderPresent(rend);
	while(1)
	{
		SDL_WaitEvent(&e);
		if(e.type == SDL_KEYDOWN)
		{
			if(e.key.keysym.sym == SDLK_ESCAPE)
				break;
		}
	}
}
