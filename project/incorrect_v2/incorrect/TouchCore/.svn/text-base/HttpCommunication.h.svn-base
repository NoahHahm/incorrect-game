//
//  ImageDownCore.h
//  SeoulXmlCore
//
//  Created by administrator on 13. 8. 25..
//  Copyright (c) 2013년 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol httpDelegate
- (void)downComplete:(NSMutableData *)responseData:(BOOL)isCultural;
- (void)ImagedownComplete:(NSMutableData *)_responseData;
@end

@interface HttpCommunication : NSObject
{
    BOOL IsCultural;
    NSMutableData *receivedData;
}

@property (nonatomic, nonatomic) id delegate;
- (void) getHtmlCode: (NSString *)_URL : (BOOL) isCultural;
@end
