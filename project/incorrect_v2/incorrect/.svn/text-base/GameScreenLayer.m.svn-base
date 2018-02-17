#import "GameScreenLayer.h"
#import "ImageTouchCore.h"
#import "ServiceApi.h"
#import "ImageDrawing.h"
#import "SimpleAudioEngine.h"
#import "GameOver.h"
#import "MainLayer.h"
#import "PauseLayer.h"
#import "Singleton.h"

@implementation GameScreenLayer
@synthesize delegate;

static NSMutableArray *IndexArrays;
+ (void) setIndexArray : (NSMutableArray *) data {
    IndexArrays = [[NSMutableArray alloc] init];
    for(BasicAppInfo *info in data) {
        [IndexArrays addObject:info.Manage_id];
    }
}
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameScreenLayer *layer = [GameScreenLayer node];
	[scene addChild: layer];
	
    return scene;
}

-(id) init
{
	if( (self=[super init])) {
                
        Imagedown = [[ImageDownCore alloc] init];
        
        [CCInfoLayer setDelegate:self];
                
        posserach = [[ImageTouchCore alloc] init];
        Api = [[ServiceApi alloc] init];
        ImgDraw = [[ImageDrawing alloc] init];
        Game_info = [[Gameinfo alloc] init];
        Technologyinfo = [[NSDictionary alloc] init];
        DbCore = [[SqlLiteCore alloc] init];
        Position = [[NSMutableArray alloc] init];
        IndexArray = [[NSMutableArray alloc] initWithArray:IndexArrays];
                   
        IsLock = false;
        IsBadCursor = false;
        IsHintItem = false;
        IsPause = false;
        IsStopItem = false;
        
        [MainLayer Music:false];
        
        self.isTouchEnabled = YES;
        
        [self schedule:@selector(gameLogic:)];
        [self schedule:@selector(update:)];
        [self imageBoard];
        
        ResultScore = 0;
        OCount = 0;
        AnswerCount = 0;
        HeartCount = 5;
        index = arc4random()%[IndexArray count];
        CorrectPositionX = 52.0f;
        
        if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == true) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Island_Fever.wav" loop:YES];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Island_Fever.wav" loop:YES];
        }
        
        
        
	}
	return self;
}

- (void)gameLogic:(ccTime)dt
{
    if (IndexArray == nil) {
        [self unscheduleAllSelectors];
        [self GameOverSceneMove];
    }
    
    if (HeartCount <= 0) {
        [self unscheduleAllSelectors];
        [self GameOverSceneMove];
    }
    
    
    
}

- (void)update:(ccTime)dt
{
    [self RefreshComboCountScreen:ComboCount];
    [self RefreshGameStopScreen:GameStopItemCount];
    [self RefreshGameHintScreen:GameHintItemCount];
    
    if (IsLock == false) {
        
        [TimeAlarm stopAllActions];
        [self unschedule:@selector(GameTime)];
        
        NSInteger idx = [[IndexArray objectAtIndex:index] integerValue];
        [self GetPositon:idx Change:true];
        [self OriginalBoard:idx:IsLock];
    }
    
    
}

- (void) dealloc
{
	[super dealloc];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([[CCDirector sharedDirector] isPaused] == true || IsPause == true) {
        return;
    }    
    
    if (IsStopItem == true) {
        IsStopItem = false;
    }
    
    if (IsHintItem == true ) {
        [self removeChild:GameHintItem_Sub cleanup:true];
        IsHintItem = false;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[touch view]];
    
    if ((pos.y <= 246 || pos.y >= 471) || (pos.x <= 81 || pos.x >= 309)) return;
    
    bool result = [self IsCheckPosition:(int)pos.x CGPointY:(int)pos.y];
    NSLog(@"%@", result ? @"true" : @"false");
    [self GameScoreCount:result];
    
    if (result == true) {
        [self CorrectCounted:OCount];
        [self GoodCursorClear];
    }
    if (result == false) {
        HeartCount--;
        [self removeChild:HeartLife[HeartCount] cleanup:true]; 
        [self BadCursorAnimation:(int)pos.x PointY:(int)pos.y];
    }
    NSLog(@"%d/X : %d / Y : %d", [[IndexArray objectAtIndex:index] intValue] ,(int)pos.x, (int)pos.y);
    
    [self PosResultScore:result y:(int)pos.y x:(int)pos.x];
}

- (void) RefreshComboCountScreen : (NSInteger) Count {
    
    if (Count <= 0 && Combo != nil) {
        [self removeChild:Combo cleanup:true];
    }
    
}
- (void) RefreshGameStopScreen : (NSInteger) Count {
    
    if (Count <= 0 && GameStopItem != nil) {
        [self removeChild:GameStopItem cleanup:true];
    }
    
    if (Count >= 1) [self GameStopItemCounted:Count];
    
}

- (void) RefreshGameHintScreen : (NSInteger) Count {
    
    if (Count <= 0 && GameHintItem != nil) {
        [self removeChild:GameHintItem cleanup:true];
    }
    
    if (Count >= 1) [self GameHintItemCounted:Count];
    
}
- (void) GoodCursorClear {
    
    if (OCount >= 5) {
        CorrectPositionX = 52.0f;
        [self schedule:@selector(CCInfoLayerMove) interval:0.2f];
    }
}
- (void) CCInfoLayerMove {
    if ([IndexArray count] <= 1) return;
    
    CulturalAssetsInfo *info = [ServiceApi getCulturaldata:[[IndexArray objectAtIndex:index] intValue]];
    [CCInfoLayer setCulturalAssetsInfo:info];
    
    [[CCDirector sharedDirector] pushScene:[CCInfoLayer scene]];
    
    for(int i=0;i<5;i++) {
        [self removeChild:GoodCursor[i] cleanup:true];
    }
    
    [self GameState];
    
    
    [IndexArray removeObjectAtIndex:index];
    index = arc4random()%[IndexArray count];
    
    [self unschedule:@selector(CCInfoLayerMove)];
}

- (bool) IsCheckPosition : (NSInteger) CGPointX CGPointY : (NSInteger) CGPointY  {
    BOOL result = [posserach Coordinate:index x:CGPointX y:CGPointY position:Position];
    if (result == true) {
        Position = [posserach DeletePosition:index x:CGPointX y:CGPointY position:Position];
        [self GoodCursorAnimation:CGPointX PointY:CGPointY Count:OCount];
        [self GameItemCrement];
        OCount++;
        return true;
    }
    
    return false;
}

- (void) CorrectCounted : (NSInteger) Count  {
    
    if (Count >= 5) {
        for(int i=0;i<5;i++) {
            [self removeChild:Correct[i] cleanup:true];
        }
        return;
    }
   
    Correct[Count] = [CCSprite spriteWithFile:@"No.ok.png" rect:CGRectMake(0, 0, 11, 11)];
    Correct[Count].anchorPoint = ccp(0,0);
    Correct[Count].position = ccp(CorrectPositionX, 50);
    CorrectPositionX += 13.5f;
    
    [self addChild:Correct[Count]];
}
- (void) BadCursorAnimation : (NSInteger) PointX  PointY : (NSInteger) PointY
{
    if (IsBadCursor == true) { return; }
    
    IsBadCursor = true;
    NSMutableArray *badFrames = [NSMutableArray array];
    
    for (int i = 1; i <= 2; i++) {
        NSString *file = [NSString stringWithFormat:@"no_%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [badFrames addObject:frame];
    }
    
    BadCursor = [CCSprite spriteWithSpriteFrameName:@"no_2.png"];
    BadCursor.position = ccp(PointY, PointX);
    [self addChild:BadCursor];
    
    CCAnimation *badAnimation = [CCAnimation animationWithFrames:badFrames delay:0.05f];
    [BadCursor runAction:[CCSequence actions:[CCAnimate actionWithAnimation:badAnimation restoreOriginalFrame:NO],
                          [CCCallFuncN actionWithTarget:self selector:@selector(RemoveBadCursor)], nil]];
    
    
}
- (void) RemoveBadCursor {
    [self removeChild:BadCursor cleanup:true];
    IsBadCursor = false;
}

- (void) GoodCursorAnimation : (NSInteger) PointX  PointY : (NSInteger) PointY Count : (NSInteger) Count
{
    if (IsGoodCursor == true) { return; }
    
    IsGoodCursor = true;
    NSMutableArray *goodFrames = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        NSString *file = [NSString stringWithFormat:@"Good_%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [goodFrames addObject:frame];
    }
    
    GoodCursor[Count] = [CCSprite spriteWithSpriteFrameName:@"Good_3.png"];
    GoodCursor[Count].position = ccp(PointY, PointX);
    [self addChild:GoodCursor[Count]];
    
    CCAnimation *goodAnimation = [CCAnimation animationWithFrames:goodFrames delay:0.05f];
    [GoodCursor[Count] runAction:[CCAnimate actionWithAnimation:goodAnimation restoreOriginalFrame:YES]];
    
    IsGoodCursor = false;
}
- (void) GameScoreCount : (BOOL) result {
    ComboCount++; //콤보 갯수
    if (ComboCount >= 6) {
        ComboCount = 5;
    }
    GoodCount++; //맞은 갯수
    AnswerCount++; //결과 갯수
}
- (void) GameItemCrement {
    
    if (GoodCount % 2 == 0 && GoodCount > 1) {
        
        GameHintItemCount++;
        [self GameHintItemCounted:GameHintItemCount];
    
    }
    
    if (GoodCount % 4 == 0 && GoodCount > 1) {
        
        GameStopItemCount++;
        [self GameStopItemCounted:GameStopItemCount];
        
    }
        
    if (GameHintItemCount > 3) {
        GameHintItemCount = 3;
    }
    else if (GameStopItemCount > 3) {
        GameStopItemCount = 3;
    }
}
- (void) PosResultScore : (BOOL) result y : (NSInteger) y  x : (NSInteger) x {
    
    if(result == true) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"answer.wav"];
        
        ResultScore = [Game_info GetScore:GoodCount ComboScore:ComboCount];
        
        int value = [[NSUserDefaults standardUserDefaults] integerForKey:@"Score"];
        if (value <= ResultScore) {
            [[NSUserDefaults standardUserDefaults] setInteger:ResultScore forKey:@"Score"];
        }
        [self ComboCounted:ComboCount];
        
        if (AnswerCount > 4) {
            AnswerCount = 0;
        }
        
        return;
    }
    ComboCount = 0;
    [[SimpleAudioEngine sharedEngine] playEffect:@"no_answer.wav"];
    return;
}
- (void) ComboCounted : (NSInteger) Count {
      
    if (Combo != nil) {
        [self removeChild:Combo cleanup:true];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%d.png", Count];
    Combo = [CCSprite spriteWithFile:fileName];
    Combo.anchorPoint = ccp(0,0);
    Combo.position = ccp(310, 10);
    [self addChild:Combo];
}

- (void) GameStopItemCounted : (NSInteger) Count {

    if (Count > 3) return;
    
    if (GameStopItem != nil) {
        [self removeChild:GameStopItem cleanup:true];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"hin-%d.png", Count];
    GameStopItem = [CCSprite spriteWithFile:fileName];
    GameStopItem.anchorPoint = ccp(0,0);
    GameStopItem.position = ccp(430, 10);
    [self addChild:GameStopItem];
}

- (void) GameHintItemCounted : (NSInteger) Count {
    if (Count > 3) return;
    
    if (GameHintItem != nil) {
        [self removeChild:GameHintItem cleanup:true];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"hin-%d.png", Count];
    GameHintItem = [CCSprite spriteWithFile:fileName];
    GameHintItem.anchorPoint = ccp(0,0);
    GameHintItem.position = ccp(370, 10);
    [self addChild:GameHintItem];
}
- (void)GameOverSceneMove {
    [GameOver SetGameScore:ResultScore];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[GameOver scene]]];
}
- (void) imageChanged {
    
    if(Original_Image != nil) {
      IsLock = false;
    }
    
    [self unschedule:@selector(imageChanged)];
    
}

- (bool) GetPositon : (NSInteger) idx Change : (bool) Change
{
    if (Change == true) {
        Position = [DbCore GetSafetyMark:idx];
        return true;
    }
    return false;
}

- (void) OriginalBoard : (NSInteger) idx : (bool) Lock {
    
    if (Original_Uiimg == nil) {
        NSLog(@"Original_Uiimg Data Loading...");
        Original_Uiimg = [Imagedown getImage:[NSString stringWithFormat:@"%d", idx]:false];
        return;
    }
    
    if (Lock == true) return;
    
    if (Original_Image != nil) {
        [self removeChild:Original_Image cleanup:true];
    }
    
    NSString *str = [Imagedown getFilePath:[NSString stringWithFormat:@"%d", idx]:false];
    Original_Image = [CCSprite spriteWithTexture:[[CCTexture2D alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:str]] resolutionType:kCCResolutioniPhoneFourInchDisplay]];

    
    Original_Image.anchorPoint = ccp(0.5,0.5);
    Original_Image.position = ccp(123, 194);

    
    IsLock = true;
    Original_Uiimg = nil;
    
    NSLog(@"Original_Uiimg Data Loaded");
    [self schedule:@selector(GameTime) interval:1.0f];
    
    [self FaultBoard:idx];
    [self addChild:Original_Image];
    
}

- (void) FaultBoard : (NSInteger) idx {
    
    NSString *str = [Imagedown getFilePath:[NSString stringWithFormat:@"%d", idx]:true];
    
    Fault_Image = [CCSprite spriteWithTexture:[[CCTexture2D alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:str]] resolutionType:kCCResolutioniPhoneFourInchDisplay]];
    
    if (Fault_Image != nil) {
        [self removeChild:Fault_Image cleanup:true];
    }
    
    Fault_Image.anchorPoint = ccp(0.5,0.5);
    Fault_Image.position = ccp(355, 194);
    
    [self addChild:Fault_Image];
     
}
- (void) imageBoard {

    CCSprite *wallpaper = [CCSprite spriteWithFile:@"WallPaper.png" rect:CGRectMake(0, 0, 480, 320)];
    wallpaper.anchorPoint = ccp(0,0);
    [self addChild:wallpaper];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Good_Cursor.plist"];
    CCSpriteBatchNode *good_Cursor = [CCSpriteBatchNode batchNodeWithFile:@"Good_Cursor.png"];
    [self addChild:good_Cursor];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"No_Cursor.plist"];
    CCSpriteBatchNode *bad_Cursor = [CCSpriteBatchNode batchNodeWithFile:@"No_Cursor.png"];
    [self addChild:bad_Cursor];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hint.plist"];
    CCSpriteBatchNode *hintitem = [CCSpriteBatchNode batchNodeWithFile:@"hint.png"];
    [self addChild:hintitem];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stop1.plist"];
    CCSpriteBatchNode *stopitem = [CCSpriteBatchNode batchNodeWithFile:@"stop1.png"];
    [self addChild:stopitem];
    
    CCMenuItemImage *pause = [CCMenuItemImage itemFromNormalImage:@"btn.png" selectedImage:@"btn-2.png" target:self selector:@selector(GamePause)];
    CCMenu *menu = [CCMenu menuWithItems:pause, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(16,16);
    [self addChild: menu];
    
    float positionX = 52.0f;
    for(int i=0;i<5;i++) {
        HeartLife[i] = [CCSprite spriteWithFile:@"heart.png" rect:CGRectMake(0, 0, 25, 21)];
        HeartLife[i].anchorPoint = ccp(0,0);
        HeartLife[i].position = ccp(positionX, 10);
        positionX += 26.5f;
        [self addChild:HeartLife[i]];
    }

    CCSprite *gameTimeBar = [CCSprite spriteWithFile:@"timebar.png" rect:CGRectMake(0, 0, 190, 7)];
    gameTimeBar.anchorPoint = ccp(0,0);
    gameTimeBar.position = ccp(250,50);
    [self addChild:gameTimeBar];

    
    GameTime = 30.0f;
    TimeAlarm = [CCSprite spriteWithFile:@"time.png" rect:CGRectMake(0, 0, 35, 38)];
    TimeAlarm.anchorPoint = ccp(0,0);
    TimeAlarm.position = ccp(240,45);
    [self addChild:TimeAlarm];
    
    
    CCMenuItemImage *hintItem = [CCMenuItemImage itemFromNormalImage:@"hint-1.png" selectedImage:@"hint-1.png" target:self selector:@selector(GameHintItem)];
    CCMenuItemImage *timeStopItem = [CCMenuItemImage itemFromNormalImage:@"hint-2.png" selectedImage:@"hint-2.png" target:self selector:@selector(GameStopItem)];
    
    CCMenu *ItemMenu = [CCMenu menuWithItems:hintItem, timeStopItem, nil];
    [ItemMenu alignItemsHorizontally];
    ItemMenu.position = ccp(390, 20);
    [self addChild:ItemMenu];
    resumeTime = 3.0f;
    
}
- (void) GameHintItem {
    if (GameHintItemCount <= 0) return;
    if (IsHintItem == true) return;
    IsHintItem = true;
    GameHintItemCount--;
    [[SimpleAudioEngine sharedEngine] playEffect:@"magic.wav"];
    [self GameHintPosition];
}
- (void) GameHintPosition {
    
    
    NSMutableArray *hintFrames = [NSMutableArray array];
    for (int i = 1; i <= 6; i++) {
        NSString *file = [NSString stringWithFormat:@"hint-1-%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [hintFrames addObject:frame];
    }
    
    
    GameHintItem_Sub = [CCSprite spriteWithSpriteFrameName:@"hint-1-6.png"];
    for(List *temp in Position) {
        if ([Position count] <= 0) return;
        GameHintItem_Sub.position = ccp(temp.Y, temp.X);
    }
    GameHintItem_Sub.anchorPoint = ccp(0.5,0.5);
    [self addChild:GameHintItem_Sub];
    
    
    CCAnimation *hintAnimation = [CCAnimation animationWithFrames:hintFrames delay:0.10f];
    [GameHintItem_Sub runAction:[CCSequence actions:[CCAnimate actionWithAnimation:hintAnimation restoreOriginalFrame:YES], nil]];
}
- (void) GameStopItem {
    if (GameStopItemCount <= 0) return;
    if (IsStopItem == true) return;
    IsStopItem = true;
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"ticktock.wav"];
    GameStopItemCount--;
    [TimeAlarm stopAllActions];
    [self GameStopAnimation];
    
    [self unschedule:@selector(GameTime)];
    [self schedule:@selector(GameResume) interval:1.0f];
}
- (void) GameStopAnimation {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSMutableArray *hintFrames = [NSMutableArray array];
    for (int i = 1; i <= 2; i++) {
        NSString *file = [NSString stringWithFormat:@"stop-2-%d.png", i];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [hintFrames addObject:frame];
    }    
    
    stopItemAnimaion = [CCSprite spriteWithSpriteFrameName:@"stop-2-2.png"];
    stopItemAnimaion.position = ccp(size.width/2, size.height/2);
    stopItemAnimaion.anchorPoint = ccp(0.5,0.5);
    [self addChild:stopItemAnimaion];
    
    CCAnimation *stopAnimation = [CCAnimation animationWithFrames:hintFrames delay:0.2f];
    CCSequence *seq = [CCSequence actions:[CCAnimate actionWithAnimation:stopAnimation restoreOriginalFrame:NO], nil];
    CCRepeat *rep = [CCRepeat actionWithAction:seq times:6];
    [stopItemAnimaion runAction:[CCSequence actions:rep,[CCCallFuncN actionWithTarget:self selector:@selector(GameStopItemRemove)], nil]];
}
- (void) GameStopItemRemove {
    [self removeChild:stopItemAnimaion cleanup:true];
}
- (void) GameResume {
    resumeTime--;
    if (resumeTime <= 1.0f) {
        resumeTime = 3.0f;
        [self schedule:@selector(GameTime) interval:1.0f];
        [self unschedule:@selector(GameResume)];
    }
}
- (void) GameTime {
    if (GameTime <= 0.0f) {
        GameTime = 0.0f;
        [self unscheduleAllSelectors];
    }
    TimeAlarmMoveAction = [CCMoveTo actionWithDuration:GameTime-- position:ccp(410,45)];
    [TimeAlarm runAction:[CCSequence actions:TimeAlarmMoveAction, [CCCallFuncN actionWithTarget:self selector:@selector(GameOverSceneMove)], nil]];
}
- (void) GameState {    
    if ([[CCDirector sharedDirector] isPaused] == true) {
        [[CCDirector sharedDirector] resume];
    }
    else if ([[CCDirector sharedDirector] isPaused] == false) {
        [[CCDirector sharedDirector] pause];
    }

}

- (void) InfoLayerDelegate {
    NSLog(@"델리게이트");
    OCount=0;
    [self schedule:@selector(imageChanged) interval:0.2f];
    [TimeAlarm stopAllActions];
    [self GameState];
    [self unschedule:@selector(GameTime)];
}

-(void) GamePause {
    [self GameState];
    
    PauseViewLayer = [[PauseLayer alloc] init];
    PauseViewLayer.Delegate = self;
    [[[CCDirector sharedDirector] openGLView] insertSubview:PauseViewLayer.view atIndex:0];
}

- (void) ContinueDelegate {
    [self GameState];
}

- (void) HomeDelegate {
    [self GameState];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInR transitionWithDuration:1.0f scene:[MainLayer scene]]];
}

@end
