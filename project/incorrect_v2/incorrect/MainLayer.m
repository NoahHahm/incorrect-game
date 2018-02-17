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
#import "Singleton.h"

static bool IsMusicState = false;
static NSDictionary *dics;

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

+ (void) setUserDictionary : (NSDictionary *) data {
    dics = [data copy];
}

-(id) init
{
	if((self=[super init])) {
        
        dic = [[NSDictionary alloc] initWithDictionary:dics];
        
        [self MainScreenBoard];
        
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == true && IsMusicState == false) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Girl On A Scooter (Theme).mp3" loop:YES];
        }
        else {
            if (!IsMusicState) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Girl On A Scooter (Theme).mp3" loop:YES];
        }
    }
    return self;
}

- (void) MainScreenBoard {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *wallPaper = [CCSprite spriteWithFile:@"main.png" rect:CGRectMake(0, 0, 480, 320)];
    wallPaper.anchorPoint = ccp(0,0);
    [self addChild:wallPaper];
    
    CCMenuItemImage *gameStart = [CCMenuItemImage itemFromNormalImage:@"btnStrat_nor.png" selectedImage:@"btnStart_sel.png" target:self selector:@selector(GameScreenSceneMove)];
    
    //CCMenuItemImage *jumsuScore = [CCMenuItemImage itemFromNormalImage:@"jumsu1.png" selectedImage:@"jumsu2.png" target:self selector:@selector(RankScreenSceneMove)];
    
    CCMenu *menu = [CCMenu menuWithItems:gameStart, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(size.width-57,size.height/7+40);
    [self addChild: menu];
    
    NSString *user[3];
    CCLabelTTF *lbl_user[3];
    NSInteger y = 108;
    
    for (int i=0;i<[[dic objectForKey:@"count"] intValue];i++) {
        
        NSString *name = [[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"name"];
        NSString *score = [[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"score"];
        
        user[i] = [NSString stringWithFormat:@"%@ (%@점)", name, score, nil];
                
        lbl_user[i] = [CCLabelTTF labelWithString:user[i] fontName:@"Arial" fontSize:14];
        lbl_user[i].color = ccc3(0, 0, 0);
        lbl_user[i].anchorPoint = CGPointMake(0, 1);
        lbl_user[i].position = ccp(size.width-163,size.height-y);
        [self addChild:lbl_user[i]];
        
        y += 28;
    }
    
       
}

- (void) GameScreenSceneMove {
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionJumpZoom transitionWithDuration:1.0f scene:[GameScreenLayer scene]]];
}

- (void) RankScreenSceneMove {
    IsMusicState = true;
    [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[RankLayer scene]]];
}
@end
