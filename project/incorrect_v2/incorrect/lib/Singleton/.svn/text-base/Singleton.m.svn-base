//
//  GlobalVar.m
//  paaser
//
//  Created by Administrator on 12. 7. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"

static Singleton *sharedInstance = nil;
@implementation Singleton
@synthesize RankDataInfo, IndexArrays;

- (id)init
{
    self = [super init];
    if (self)
    {
        IndexArrays = [[NSMutableArray alloc] init];
        RankDataInfo = [[NSDictionary alloc] init];
    }
    return self;
}
+ (Singleton *)sharedInstance
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



