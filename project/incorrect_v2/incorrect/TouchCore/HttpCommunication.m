//
//  ImageDownCore.m
//  SeoulXmlCore
//
//  Created by administrator on 13. 8. 25..
//  Copyright (c) 2013년 administrator. All rights reserved.
//

#import "HttpCommunication.h"

@implementation HttpCommunication
@synthesize delegate;

- (void) getHtmlCode: (NSString *)_URL : (BOOL) isCultural {
    
    IsCultural = isCultural;
    
    /* (1) NSURLRequest 인스턴스에 URL 정보 저장 */
    _URL = [_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * htmlURL = [NSURL URLWithString: _URL];
    
	receivedData = [NSMutableData data];
	
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
	[request setTimeoutInterval:15.0f];
	[request setURL:htmlURL];
	
	
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
	[conn scheduleInRunLoop:[NSRunLoop currentRunLoop]
                    forMode:NSRunLoopCommonModes];
	[conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {    
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection {
    
    [delegate downComplete:receivedData:IsCultural];
    
    //NSLog(@"%@", [NSByteCountFormatter stringFromByteCount:receivedData.length countStyle:NSByteCountFormatterCountStyleFile]);
}
@end
