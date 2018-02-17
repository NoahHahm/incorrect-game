//
//  GlobalVar.m
//  paaser
//
//  Created by Administrator on 12. 7. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "GlobalVar.h"

static GlobalVar *sharedInstance = nil;
@implementation GlobalVar
@synthesize _image;
- (id)init
{
    self = [super init];
    if (self)
    {
        //초기화
        //_image = [[UIImage alloc] init];
    }
    return self;
}
+ (GlobalVar *)sharedInstance
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[super alloc] init];
        }
    }
    return sharedInstance;
}
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}
@end



