//
//  IconDownloader.m
//  TableViewCellCustomizeIconDownload
//
//  Created by Kishikawa Katsumi on 10/05/05.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "Downloader.h"
#import "ImageManipulator2.h"
#import "AppDelegate.h"

@implementation UIScreen(ZBScreenRetinaAdditions)

- (BOOL)zb_isRetina {
	return [self respondsToSelector:@selector(displayLinkWithTarget:selector:)] && (self.scale == 2.0);
}

@end

@implementation Downloader

@synthesize delegate;
@synthesize indexPathInTableView;
@synthesize imageURL;
@synthesize activeDownload;
@synthesize imageConnection;
@synthesize idxString;
@synthesize type;
@synthesize resultImage;
#pragma mark

- (void)startDownload {
    self.activeDownload = [NSMutableData data];	
	
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
	[request setTimeoutInterval:15.0f];
	[request setURL:imageURL];	
	
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
	
	
    self.imageConnection = conn;
   // 
	
	[conn scheduleInRunLoop:[NSRunLoop currentRunLoop]
				   forMode:NSRunLoopCommonModes];
	[conn start];
}

- (void)cancelDownload {
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.activeDownload = nil;
    self.imageConnection = nil;
}
- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
	UIGraphicsBeginImageContext(size);
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    UIImage *returnImage, *returnImage2;
    
    if(self.type == 8) {
        returnImage = [self scale:image toSize:CGSizeMake(image.size.width, image.size.height)];
    } else {
        returnImage = [self scale:image toSize:CGSizeMake(57, 57)];
    }
    
    if(self.type != 8) 
        returnImage2 = [ImageManipulator2 makeRoundCornerImage:returnImage : 5  : 5];
    else 
        returnImage2 = [ImageManipulator2 makeRoundCornerImage:returnImage : 0  : 0];
        
    self.activeDownload = nil;
    self.imageConnection = nil;
    
    if (returnImage2) {
        if ([delegate respondsToSelector:@selector(Downloader:didFinished:)]) {
            [delegate Downloader:self didFinished:returnImage2];
        }
    }
}

@end
