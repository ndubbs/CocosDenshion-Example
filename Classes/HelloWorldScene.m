//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//
/*
 Copyright (c) 2010 Nicholas Waynik Jr.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
*/ 


// Import the interfaces
#import "HelloWorldScene.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize a Label
		//CCLabel* label = [CCLabel labelWithString:@"Sound Tutorial" fontName:@"Marker Felt" fontSize:64];
		// ask director the the window size
		//CGSize size = [[CCDirector sharedDirector] winSize];
		// position the label on the center of the screen
		//label.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
		//[self addChild: label];
	
		// Preload the background audio
		SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
		if (sae != nil) {
			[sae preloadBackgroundMusic:@"mario-theme.mp3"];
			if (sae.willPlayBackgroundMusic) {
				
				// The background Music Volume can be set from 0.0f to 1.0f
				sae.backgroundMusicVolume = 0.5f;
			}
		}		
		
		// Create a menu to store actions for the CocosDenshion
		[CCMenuItemFont setFontSize:25];
        [CCMenuItemFont setFontName:@"Marker Felt"];
		
		CCMenuItem *toggleBGSound = [CCMenuItemFont itemFromString:@"Toggle Background Sound"
													  target:self
													selector:@selector(toggleBGSound:)];
		
		CCMenuItem *toggleMute = [CCMenuItemFont itemFromString:@"Toggle Mute"
														 target:self
													   selector:@selector(toggleMute:)];
		
		CCMenuItem *pauseResumeBGSound = [CCMenuItemFont itemFromString:@"Pause/Resume Background Sound"
															 target:self
														   selector:@selector(pauseResumeBGSound:)];
		
		CCMenuItem *playSoundEffect = [CCMenuItemFont itemFromString:@"Play Sound Effect"
														  target:self
														selector:@selector(playSoundEffect:)];
		
		CCMenu *menu = [CCMenu menuWithItems:toggleBGSound, toggleMute, pauseResumeBGSound, playSoundEffect, nil];
		
        [menu alignItemsVertically];
        [self addChild:menu];
		
	}
	return self;
}

- (void) toggleBGSound:(id) sender {
	if ([[CDAudioManager sharedManager]isBackgroundMusicPlaying] == YES){
		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	} else {
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mario-theme.mp3"];
	}
}

- (void) toggleMute:(id) sender {
	if ([CDAudioManager sharedManager].mute == TRUE) {
		[CDAudioManager sharedManager].mute = FALSE;
	}else {
		[CDAudioManager sharedManager].mute = TRUE;
	}

}

- (void) pauseResumeBGSound:(id) sender {	
	if ([[CDAudioManager sharedManager]isBackgroundMusicPlaying] == YES){
		[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	} else {
		[[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
	}
}

- (void) playSoundEffect:(id) sender {
	[[SimpleAudioEngine sharedEngine] playEffect:@"mario_04.wav"];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
