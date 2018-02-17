//
//  GameEnd.h
//  brain
//
//  Created by Administrator on 12. 9. 28..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GADBannerView.h"

@interface GameEnd : CCLayer {
    GADBannerView *bannerView;
    CCSprite *WallPaper;
    NSInteger Correct_Count;
    NSString *Correct_Str;
}
+(CCScene *) scene;
@end
