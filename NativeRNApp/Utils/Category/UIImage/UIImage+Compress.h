//
//  UIImage+Compress.h
//  souyue
//
//  Created by Jiang on 17-1-1.
//  Copyright (c) 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)
- (UIImage *)compressedImage;

- (CGFloat)compressionQuality;

- (NSData *)compressedData;

- (NSData *)compressedData:(CGFloat)compressionQuality;

- (UIImage *)compressedToSize:(CGSize)size;

- (UIImage *)compressedImageBySize;

- (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;

- (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize;

+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
@end
