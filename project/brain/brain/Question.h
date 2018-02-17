//
//  Question.h
//  brain
//
//  Created by Administrator on 12. 9. 25..
//
//

#import <Foundation/Foundation.h>
#import "GameLayer.h"

@interface Question : NSObject
{
    NSInteger _Count1;
    NSInteger _Count2;
    NSInteger _Count3;
}

@property (nonatomic, assign) NSString *_Question_str;
@property (nonatomic) NSInteger _Result;
- (void) _Stage1;
- (void) _Stage2;
- (void) _Stage3;
- (void) _Stage4;
@end
