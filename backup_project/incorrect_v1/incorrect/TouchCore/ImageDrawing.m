//
//  ImageDrawing.m
//  incorrect
//
//  Created by Administrator on 12. 12. 31..
//
//

#import "ImageDrawing.h"

@implementation ImageDrawing

-(id) init
{
	if( (self=[super init])) {
        
	}
	return self;
}

-(UIImage *)AutoResizeImage:(UIImage *)image
{
    
    float resizeWidth = 0.0f;
    float resizeHeight = 0.0f;
    
    if ([[UIScreen mainScreen] scale] == 1.0f) {
        resizeWidth = 234.0f;
        resizeHeight = 234.0f;
    }
    else if ([[UIScreen mainScreen] scale] == 2.0f) {
        resizeWidth = 467.0f;
        resizeHeight = 467.0f;
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 1136) {
        
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, resizeHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, resizeWidth, resizeHeight), [image CGImage]);
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIImage *)resizeImage:(UIImage *)image width:(float)resizeWidth height:(float)resizeHeight
{
    
    UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, resizeHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, resizeWidth, resizeHeight), [image CGImage]);
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
