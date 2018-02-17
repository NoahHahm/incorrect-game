//
//  IconDownloader.h
//  TableViewCellCustomizeIconDownload
//
//  Created by Kishikawa Katsumi on 10/05/05.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIScreen(ZBScreenRetinaAdditions)

// Returns YES if this is a Retina display.
- (BOOL)zb_isRetina;

@end
@interface Downloader : NSObject {
    NSIndexPath *indexPathInTableView;
    NSURL *imageURL;    
	NSString *idxString;
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
	NSInteger type;
    UIImage *resultImage;
}

@property (nonatomic, readwrite) NSInteger type;

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, strong) NSURL *imageURL;

@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;
@property (nonatomic, strong) NSString *idxString;
@property (nonatomic, strong) UIImage *resultImage;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol DownloaderDelegate 
- (void)Downloader:(Downloader *)downloader didFinished:(UIImage *)image;
@end