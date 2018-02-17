//
//  httpaddress.m
//  FirstView
//
//  Created by Administrator on 12. 6. 9..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "httpaddress.h"
#import "SBJSON.h"

@implementation httpaddress
@synthesize delegate;

- (void) getHtmlCode: (NSString *)_URL {
    
    /*
     0 - 메인
     1 - 자연
     2 - 연예인/인물
     3 - 동물
     4 - 만화/애니
     5 - 패션/스타일
     6 - 섹시
     7 - 기타
     */
    
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
    NSString *text = [[NSString alloc] initWithData: receivedData encoding: NSUTF8StringEncoding];
    [delegate downComplete:text];
}

@end