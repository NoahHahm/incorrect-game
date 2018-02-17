//
//  ImageDownCore.m
//  SeoulXmlCore
//
//  Created by administrator on 13. 8. 27..
//  Copyright (c) 2013년 administrator. All rights reserved.
//

#import "ImageDownCore.h"

@implementation ImageDownCore

- (UIImage *) imageDataToUIImage : (NSMutableData *)data {
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

- (void) saveData : (NSData *) data : (NSString *) fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    
    NSError *error;
    
    BOOL isDir;
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"tmp"];
    if([[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir){
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    filePath = [filePath stringByAppendingFormat:@"/%@.png", fileName];
    [data writeToFile:filePath atomically:YES];
}

- (UIImage *) getImage : (NSString *) fileName : (BOOL) isFault {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    NSString *filePath;
    
    if ([[UIScreen mainScreen] scale] == 1.0f) {
        if (isFault == false) {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@.png", fileName];
        }
        else {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@_f.png", fileName];            
        }
    }
    else if ([[UIScreen mainScreen] scale] == 2.0f) {
        if (isFault == false) {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@-hd.png", fileName];
        }
        else {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@_f-hd.png", fileName];
        }
    }
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    
    return image;    
}

- (NSString *) getFilePath : (NSString *) fileName  : (BOOL) isFault {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    NSString *filePath;
    
    if ([[UIScreen mainScreen] scale] == 1.0f) {
        if (isFault == false) {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@.png", fileName];
        }
        else {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@_f.png", fileName];
        }
    }
    else if ([[UIScreen mainScreen] scale] == 2.0f) {
        if (isFault == false) {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@-hd.png", fileName];
        }
        else {
            filePath = [cachePath stringByAppendingFormat:@"/tmp/%@_f-hd.png", fileName];
        }
    }
    
    return filePath;
}

@end
