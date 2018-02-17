
#import "MCApiQuery.h"
#import "imgupload.h"
#import "httpaddress.h"

#define NS_EUC_KR_Encoding

@implementation MCApiQuery
@synthesize delegate = _delegate;


-(void)query_uploadPicture:(NSData*)pictureData _section:(NSInteger)_section _title:(NSString *)_title _uploader:(NSString *)_uploader {

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSLog(@"사진 크기:  %d",[pictureData length]);
    NSString * urlString = [NSString stringWithFormat: @"http://noantech.cafe24.com/app/upload.php?title=%@&uploader=%@&section=%d", _title, _uploader, _section] ;
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    NSLog(@"%@",urlString);
    
    _responseData = [NSMutableData data];	
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
	[request setTimeoutInterval:60.0f];
	[request setURL:[NSURL URLWithString:urlString]];
	
	[request setHTTPMethod:@"POST"];
	NSString *boundary = [NSString stringWithString:@"Aa12334485778888"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data, boundary=%@",boundary];
	
	[request addValue:contentType forHTTPHeaderField:@"Content-type"];
    
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
	[body appendData:[[NSString stringWithString:@"content-disposition: form-data; name=\"username\"\r\n\r\nmcbugi"] dataUsingEncoding:NSUTF8StringEncoding] ];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data;name=\"imgfile\";filename=\"%@\"\r\n",@"bubbleicon.png" ] dataUsingEncoding:NSUTF8StringEncoding] ];
	[body appendData:[[NSString stringWithFormat:@"Content-Type:applicatio/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding] ];
	[body appendData:pictureData];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
	
	[request setHTTPBody:body];
	[_delegate apiQueryBegin:self];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
     
    
        
    
//self.session [_delegate getSection]
    
}

- (NSURLRequest*)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest*)request
		   redirectResponse:(NSURLResponse*)redirectResponse
{	
	return request;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
	[_responseData setLength:0];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
	[_responseData appendData:data];
}
-(void)connection:(NSURLConnection*)connection	
 didFailWithError:(NSError *)error
{
	//에러처리
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"ERROR: %@",[error localizedDescription]);
    [_delegate apiQueryFailed:self];
    [_delegate apiQueryEnd:self];
	
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        //	if ([trustedHosts containsObject:challenge.protectionSpace.host])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSString *content = [[NSString alloc] initWithBytes:[_responseData bytes]
												 length:[_responseData length]
											   encoding:NSUTF8StringEncoding];
	
    NSLog(@"수신:[%@]",content);
    [_delegate apiQuerySucceeded:self content:content];
    [_delegate apiQueryEnd:self];
}
@end
