//
//  MainLayer.h
//  incorrect
//
//  Created by Administrator on 13. 1. 20..
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface MainLayer : CCLayer
{
    NSDictionary *dic;
    //RankViewController *rankViewController;
}
+(CCScene *) scene;
+ (void) Music : (bool) isMusicState;
+ (void) setUserDictionary : (NSDictionary *) data;
@end
