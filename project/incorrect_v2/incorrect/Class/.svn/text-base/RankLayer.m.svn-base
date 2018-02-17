//
//  RankLayer.m
//  incorrect
//
//  Created by Administrator on 13. 2. 11..
//
//

#import "RankLayer.h"
#import "SimpleAudioEngine.h"
#import "MainLayer.h"

@implementation RankLayer
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	RankLayer *layer = [RankLayer node];
	[scene addChild: layer];
	
    return scene;
}
-(id) init
{
	if((self=[super init])) {
        
        CCSprite *wallpaper = [CCSprite spriteWithFile:@"gameover.png" rect:CGRectMake(0, 0, 480, 320)];
        wallpaper.anchorPoint = ccp(0,0);
        [self addChild:wallpaper];
        
        
        CCMenuItemImage *home = [CCMenuItemImage itemFromNormalImage:@"homekey.png" selectedImage:@"homekey.png" target:self selector:@selector(BackHome)];
        CCMenu *menu = [CCMenu menuWithItems:home, nil];
        [menu alignItemsHorizontally];
        menu.position = ccp(425, 270);
        [self addChild: menu];
        
        int value = [[NSUserDefaults standardUserDefaults] integerForKey:@"Score"];
        NSString *Score = [NSString stringWithFormat:@"%d", value];
        CCLabelTTF *label = [CCLabelTTF labelWithString:Score  fontName:@"Marker Felt" fontSize:60.0f];
        label.position = ccp(250, 105);
        label.color = ccc3(255,255,255);
        [self addChild:label];
        
    }
    return self;
}

- (void) BackHome  {
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[MainLayer scene]]];
}
@end
