//
//  UIImage+Ext.h
//  
//
//  Created by Ben Ford on 1/16/13.
//  Copyright (c) 2013 Ben Ford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Ext)
@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIImage *extStretchableImageByWidth;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIImage *extStretchableImageByHeight;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) UIImage *extStretchableImage;

- (UIImage *)extRotateImageToOrientation:(UIImageOrientation)orientation;
@end
