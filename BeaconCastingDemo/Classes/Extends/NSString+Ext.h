//
//  NSString+Ext.h
//
//  Created by Ben Ford on 10/27/11.
//  Copyright (c) 2011 Ben Ford All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(unsigned int, NSStringExtElipseType) {
    NSStringExtElipseTypeNone = 0,
    NSStringExtElipseTypeEnd,
    NSStringExtElipseTypeMiddle,
    NSStringExtElipseTypeFront,
};

@interface NSString(Ext)

+ (NSString *)extEmptyStringIfNilOrBlank:(NSString *)inputString;

+ (BOOL)extContainsText:(NSString *)inputString;

@property (NS_NONATOMIC_IOSONLY, readonly) CGRect extToCGRect;

- (BOOL)extBeginsWithString:(NSString *)beginsWith;
- (BOOL)extEndsWithString:(NSString *)endsWith;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *extExtensionWithDot;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *extLastPathComponentWithoutExtension;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *extPathWithoutExtension;

- (NSString *)extStringWithMaxLength:(NSUInteger)maxLength withElipses:(NSStringExtElipseType)elipseType;
- (NSString *)extStringThatFitsWidth:(CGFloat)maxWidth font:(UIFont *)font withElipses:(NSStringExtElipseType)elipseType;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *extTrimmedString;
@end
