//
//  GameOver.m
//  incorrect
//
//  Created by Administrator on 13. 1. 19..
//
//

#import "GameOver.h"
#import "MainLayer.h"
#import "SimpleAudioEngine.h"
#import "ServiceApi.h"

static NSInteger GameScore = 0;
@implementation GameOver

+(CCScene *) scene
{
    
	CCScene *scene = [CCScene node];
	GameOver *layer = [GameOver node];
	[scene addChild: layer];
	
    return scene;
}

+ (void) SetGameScore : (NSInteger) score {
    GameScore = score;
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
        
        NSString *Score = [NSString stringWithFormat:@"%d", GameScore];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:Score  fontName:@"Marker Felt" fontSize:60.0f];
        label.position = ccp(250, 105);
        label.color = ccc3(255,255,255);
        [self addChild:label];
        
        
        NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        NSDictionary *userdic = [ServiceApi GetUserinfo:username];
        
        if (GameScore > [[userdic valueForKey:@"score"] integerValue]) {
            [ServiceApi SetUserScore:username :GameScore];
        }
        
        
    }
    return self;
}

- (void) BackHome  {
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeUp transitionWithDuration:1.0f scene:[MainLayer scene]]];
}

@end
