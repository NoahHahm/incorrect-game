//
//  MainLayer.m
//  incorrect
//
//  Created by Administrator on 13. 1. 20..
//
//

#import "MainLayer.h"
#import "GameScreenLayer.h"
#import "SimpleAudioEngine.h"
#import "RankLayer.h"

static bool IsMusicState = false;
@implementation MainLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	MainLayer *layer = [MainLayer node];
	[scene addChild: layer];
	
    return scene;
}

+ (void) Music : (bool) isMusicState {
    IsMusicState = isMusicState;
}

-(id) init
{
	if((self=[super init])) {
        [self MainScreenBoard];
        
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == true && IsMusicState == false) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Girl On A Scooter (Theme).mp3" loop:YES];
        }
        else {
            if (!IsMusicState) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Girl On A Scooter (Theme).mp3" loop:YES];
        }
        rankViewController.view.hidden = false;
    }
    return self;
}

- (void) MainScreenBoard {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *wallPaper = [CCSprite spriteWithFile:@"main.png" rect:CGRectMake(0, 0, 480, 320)];
    wallPaper.anchorPoint = ccp(0,0);
    [self addChild:wallPaper];
    
    CCMenuItemImage *gameStart = [CCMenuItemImage itemFromNormalImage:@"stbtn_nomal.png" selectedImage:@"stbtn_sel.png" target:self selector:@selector(GameScreenSceneMove)];
    
    CCMenuItemImage *jumsuScore = [CCMenuItemImage itemFromNormalImage:@"jumsu1.png" selectedImage:@"jumsu2.png" target:self selector:@selector(RankScreenSceneMove)];
    
    CCMenu *menu = [CCMenu menuWithItems:gameStart,jumsuScore, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(size.width/2+80,size.height/7);
    [self addChild: menu];
    
    rankViewController = [[RankViewController alloc] init];
    
    rankViewController.view.frame = CGRectMake(87, 160, rankViewController.view.frame.size.width, rankViewController.view.frame.size.height);
    
    [[[CCDirector sharedDirector] openGLView] insertSubview:rankViewController.view atIndex:0];
    
    CCSprite *rankImage = [CCSprite spriteWithFile:@"highRn.png"];
    rankImage.position = ccp(250, 270);
    [self addChild:rankImage];
    
}

- (void) GameScreenSceneMove {
    rankViewController.view.hidden = true;
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionJumpZoom transitionWithDuration:1.0f scene:[GameScreenLayer scene]]];
}

- (void) RankScreenSceneMove {
    rankViewController.view.hidden = true;
    IsMusicState = true;
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[RankLayer scene]]];
}
@end
