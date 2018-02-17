//
//  GlobalVar.h
//  paaser
//
//  Created by Administrator on 12. 7. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVar : NSObject
+ (GlobalVar *)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;
- (id)init;
@property (nonatomic) NSInteger Correct_Count;
@property (nonatomic) NSString *Correct_Str;
@end
