//
//  ImageDownCore.h
//  SeoulXmlCore
//
//  Created by administrator on 13. 8. 27..
//  Copyright (c) 2013년 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownCore : NSObject
- (UIImage *) imageDataToUIImage : (NSMutableData *)data;
- (void) saveData : (NSData *) data : (NSString *) fileName;
- (UIImage *) getImage : (NSString *) fileName : (BOOL) isFault;
- (NSString *) getFilePath : (NSString *) fileName : (BOOL) isFault;
@end
