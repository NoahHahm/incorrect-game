//
//  httpaddress.h
//  FirstView
//
//  Created by Administrator on 12. 6. 9..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol httpaddressDelegate
- (void)downComplete:(NSString*)_downString;
@end

@interface httpaddress : NSObject
{
    NSMutableData * receivedData;
}
@property (nonatomic, weak) id delegate;
- (void) getHtmlCode: (NSString *)_URL;
@end
