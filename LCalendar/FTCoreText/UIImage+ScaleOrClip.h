//
//  UIImage+ScaleOrClip.h
//  號闻天下
//
//  Created by haowenliang on 13-12-8.
//  Copyright (c) 2013年 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScaleOrClip)

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

+ (UIImage *)fitSmallImage:(UIImage *)image;

@end
