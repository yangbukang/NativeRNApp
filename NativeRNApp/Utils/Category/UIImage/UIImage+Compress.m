//
//  UIImage+Compress.m
//  souyue
//
//  Created by Jiang on 17-1-1.
//  Copyright (c) 2017年 apple. All rights reserved.
//

#import "UIImage+Compress.h"
#import <Accelerate/Accelerate.h>

#define MIN_IMAGEPIX 640.0          // max pix 200.0px
#define MAX_IMAGEPIX 860.0          // max pix 200.0px
//#define MIN_IMAGEPIX 1280.0          // max pix 200.0px
//#define MAX_IMAGEPIX 1720.0          // max pix 200.0px
#define MAX_IMAGEDATA_LEN 10000.0   // max data length 50K

CGFloat DegreeToRadian(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadianToDegree(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (Compress)
- (UIImage *)compressedImage {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return [UIImage imageWithData:[self compressedData]];
    }
    
    if (width == 0 || height == 0) {
        // void zero exception
        return self;
    }
    
    UIImage *newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (scaledWidth < MIN_IMAGEPIX) {
        scaleFactor = MIN_IMAGEPIX / width;
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
    }else if (scaledHeight < MIN_IMAGEPIX) {
        scaleFactor = MIN_IMAGEPIX / height;
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
    }
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:[newImage compressedData]];
    
}

- (UIImage *)compressedToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = size.width;
    thumbnailRect.size.height = size.height;
    
    [self drawInRect:thumbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)compressedImageBySize
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return self;
    }

    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (scaledWidth < MIN_IMAGEPIX) {
        scaleFactor = MIN_IMAGEPIX / width;
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
    }else if (scaledHeight < MIN_IMAGEPIX) {
        scaleFactor = MIN_IMAGEPIX / height;
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
    }
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [self drawInRect:thumbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize
{
    CGFloat scale;
    CGSize newsize = image.size;
    if (newsize.height && (newsize.height > viewsize.height)) {
        scale = viewsize.height/newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    if (newsize.width && (newsize.width >= viewsize.width)) {
        scale = viewsize.width /newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    UIGraphicsBeginImageContext(viewsize);
    
    float dwidth = (viewsize.width - newsize.width) / 2.0f;
    float dheight = (viewsize.height - newsize.height) / 2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, newsize.width, newsize.height);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSData *)compressedData:(CGFloat)compressionQuality {
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);
    CGImageRef sourceImage = self.CGImage;
    CGImageAlphaInfo info = CGImageGetAlphaInfo(sourceImage);
    if (info != kCGImageAlphaNone) {
        NSData *buffer = UIImageJPEGRepresentation(self, 1.0);
        UIImage *newImage = [UIImage imageWithData:buffer];
        return UIImageJPEGRepresentation(newImage, compressionQuality);
    }
    return UIImageJPEGRepresentation(self, [self compressionQuality]);
}

- (CGFloat)compressionQuality {
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    if(dataLength > MAX_IMAGEDATA_LEN) {
        CGFloat quality = MAX_IMAGEDATA_LEN / dataLength;
        return quality;
    } else {
        return 1.0;
    }
}

- (NSData *)compressedData {
    CGFloat quality = [self compressionQuality];
    
    return [self compressedData:quality];
}


+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize
{
    CGFloat scale;
    CGSize newsize = image.size;
    if (newsize.height && (newsize.height > viewsize.height)) {
        scale = viewsize.height/newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    if (newsize.width && (newsize.width >= viewsize.width)) {
        scale = viewsize.width /newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    UIGraphicsBeginImageContext(viewsize);
    
    float dwidth = (viewsize.width - newsize.width) / 2.0f;
    float dheight = (viewsize.height - newsize.height) / 2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, newsize.width, newsize.height);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//通过缩放系数进行缩放
- (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(size); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.01f;
    NSData *orginalData = UIImageJPEGRepresentation(image, 1.0);
    float dataLength = orginalData.length / (1024.0*1024.0);
    float firstComPress = 0.25/dataLength-0.01;
    NSData *comImageData = UIImageJPEGRepresentation(image, firstComPress);
    while ([comImageData length] > maxFileSize && compression > maxCompression) {
        if (compression > 0.00&&compression < 0.1) {
            compression -=0.01;
        }
        if (compression > 0.1) {
            compression -= 0.1;
        }
        comImageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return comImageData;
    
}
@end
