//
//  HelloWorldLayer.h
//  incorrect
//
//  Created by Administrator on 12. 12. 27..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "ImageTouchCore.h"
#import "ServiceApi.h"
#import "ImageDrawing.h"
#import "Gameinfo.h"
#import "SqlLiteCore.h"
#import "PauseLayer.h"
#import "ImageDownCore.h"
#import "CCInfoLayer.h"

static CCSprite *GoodCursor[5];

// HelloWorldLayer
@interface GameScreenLayer : CCLayer <CCStandardTouchDelegate, CCInfoLayerProtocol>
{
    
@private
    CCInfoLayer *CCinfoLayer;
    ImageDownCore *Imagedown;
    ImageTouchCore *posserach;
    ServiceApi *Api;
    ImageDrawing *ImgDraw;
    SqlLiteCore *DbCore;
    Gameinfo *Game_info;
    PauseLayer *PauseViewLayer;
    
    NSMutableArray *IndexArray;
    
    NSDictionary *Technologyinfo;
    
    UIImage *Original_Uiimg;
    CCSprite *Original_Image;
    CCSprite *Fault_Image;
    
    NSInteger RandomValue;

    bool IsLock;
    bool IsBadCursor;
    bool IsGoodCursor;
    bool IsHintItem;
    bool IsStopItem;
    bool IsPause;
    
    NSInteger index;
    NSInteger Arrindex;
    //NSMutableArray *IndexArray;
    
    NSInteger AnswerCount;
    NSInteger GoodCount;
    NSInteger ComboCount;
    NSInteger ResultScore;
    NSInteger OCount;
    
    CCSprite *answer;
    
    NSMutableArray *Position;
    
    
    CCSprite *BadCursor;
    
    CCSprite *HeartLife[5];
    CCSprite *Correct[5];
    CCSprite *Combo;
    NSInteger HeartCount;
    
    float GameTime;
    float CorrectPositionX;
    CCMoveTo *TimeAlarmMoveAction;
    CCSprite *TimeAlarm;
    NSInteger GameStopItemCount;
    NSInteger GameHintItemCount;
    float resumeTime;
    
    CCSprite *GameStopItem;
    CCSprite *GameHintItem;
    CCSprite *GameHintItem_Sub;
    CCSprite *stopItemAnimaion;
    
}
+(CCScene *) scene;

- (void) RefreshComboCountScreen : (NSInteger) Count;
- (void) GameState;
- (void) RefreshGameStopScreen : (NSInteger) Count;
- (void) GoodCursorClear;
- (void) InfoViewMove;
- (bool) IsCheckPosition : (NSInteger) CGPointX CGPointY : (NSInteger) CGPointY;
- (void) CorrectCounted : (NSInteger) Count;
- (void) BadCursorAnimation : (NSInteger) PointX  PointY : (NSInteger) PointY;
- (void) RemoveBadCursor;
- (void) GoodCursorAnimation : (NSInteger) PointX  PointY : (NSInteger) PointY Count : (NSInteger) Count;
- (void) GameScoreCount : (BOOL) result;
- (void) GameItemCrement;
- (void) PosResultScore : (BOOL) result y : (NSInteger) y  x : (NSInteger) x;
- (void) ComboCounted : (NSInteger) Count;
- (void) GameStopItemCounted : (NSInteger) Count;
- (void) GameOverSceneMove;
- (void) gameLogic:(ccTime)dt;
- (void) update:(ccTime)dt;
- (void) imageChanged;
- (bool) GetPositon : (NSInteger) idx Change : (bool) Change;
- (void) OriginalBoard : (NSInteger) idx info : (NSDictionary *) info Look : (bool) Lock;
- (void) FaultBoard : (NSInteger) idx;
- (void) imageBoard;
- (void) GameStopItem;
- (void) GameResume;
- (void) GameTime;
- (void) InfoLayerDelegate;
+(void) setIndexArray : (NSMutableArray *) data;

@property (nonatomic, assign) id delegate;
@end
