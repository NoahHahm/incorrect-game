//
//  CCInfoLayer.m
//  incorrect
//
//  Created by administrator on 13. 9. 14..
//
//

#import "CCInfoLayer.h"
#import "GameScreenLayer.h"

static id delegate;

static NSString *Manage_id;
static NSString *Cultural_Name;
static NSString *Cultural_EngName;
static NSString *App_reason;
static NSString *App_Board;
static NSString *Stand_addr;

@implementation CCInfoLayer


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	CCInfoLayer *layer = [CCInfoLayer node];
	[scene addChild: layer];
	
    return scene;
}

+ (void) setDelegate : (id) data {
    delegate = data;
}

+ (void) setCulturalAssetsInfo : (CulturalAssetsInfo *) info {
    Manage_id = info.Manage_id;
    Cultural_Name = info.Cultural_Name;
    Cultural_EngName = info.Cultural_EngName;
    App_reason = info.App_reason;
    App_Board = info.App_Board;
    Stand_addr = info.Stand_addr;
}

-(id) init
{
	if((self=[super init])) {
        [self board];
    }
    return self;
}

-(void) board {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *wallPaper = [CCSprite spriteWithFile:@"info.png" rect:CGRectMake(0, 0, 480, 320)];
    wallPaper.anchorPoint = ccp(0,0);
    [self addChild:wallPaper];
    
    CCMenuItemImage *gameStart = [CCMenuItemImage itemFromNormalImage:@"btnnext.png" selectedImage:@"btnnext.png" target:self selector:@selector(popSceneMove)];    
    CCMenu *menu = [CCMenu menuWithItems:gameStart, nil];
        
    CCMenuItemImage *facebook = [CCMenuItemImage itemFromNormalImage:@"btnfacebook.png" selectedImage:@"btnfacebook.png" target:self selector:@selector(facePost)];
    CCMenu *menu_facebook = [CCMenu menuWithItems:facebook, nil];
        
    menu.position = ccp(size.width-80,size.height/8);
    menu_facebook.position = ccp(size.width-280,size.height-85);
    
    CCLabelTTF *lbl_korName = [CCLabelTTF labelWithString:Cultural_Name dimensions:CGSizeMake(160, 30) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:15];
    lbl_korName.color = ccc3(255, 0, 0);
    lbl_korName.anchorPoint = CGPointMake(0, 1);
    lbl_korName.position = ccp(size.width-210,size.height-105);
    
    
    CCLabelTTF *lbl_engName = [CCLabelTTF labelWithString:Cultural_EngName dimensions:CGSizeMake(160, 20) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:9];
    lbl_engName.color = ccc3(255, 0, 0);
    lbl_engName.anchorPoint = CGPointMake(0, 1);
    lbl_engName.position = ccp(size.width-210,size.height-120);
        
    CCLabelTTF *lbl_reason = [CCLabelTTF labelWithString:App_reason dimensions:CGSizeMake(160, 300) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:10];
    lbl_reason.color = ccc3(222, 0, 0);
    lbl_reason.anchorPoint = CGPointMake(0, 1);
    lbl_reason.position = ccp(size.width-210,size.height-145);
    
    
    CCLabelTTF *lbl_addr = [CCLabelTTF labelWithString:Stand_addr dimensions:CGSizeMake(160, 50) alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:9];
    lbl_addr.color = ccc3(222, 0, 0);
    lbl_addr.anchorPoint = CGPointMake(0, 1);
    lbl_addr.position = ccp(size.width-210,size.height-250);
        
    [self addChild:menu];
    [self addChild:menu_facebook];
    [self addChild:lbl_korName];
    [self addChild:lbl_engName];
    [self addChild:lbl_reason];
    [self addChild:lbl_addr];
}

- (void) popSceneMove {
    [[CCDirector sharedDirector] popScene];
    [delegate InfoLayerDelegate];
}

- (void) facePost {
    NSString *str = [NSString stringWithFormat:@"http://search.cha.go.kr/srch_new/search/search_top.jsp?searchCnd=&searchWrd=&mn=&gubun=search&query=%@", Cultural_Name, nil];
   
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"592171217488837", @"app_id",
     Cultural_Name, @"name",
     @"우리나라 문화재 정보!", @"caption",
     App_reason, @"description",
     str, @"link",
     @"http://img.naver.net/static/www/u/2013/0819/nmms_111143893.gif", @"picture",
     @"NULL", @"message",
     nil];
    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {}
     ];
}

@end
