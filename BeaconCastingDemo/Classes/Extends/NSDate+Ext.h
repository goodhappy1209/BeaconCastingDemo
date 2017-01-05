//
//  NSDate+Ext.h
//  
//
//  Created by Ben Ford on 3/1/12.
//  Copyright (c) 2012 Ben Ford All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Ext)
- (BOOL)extEarlierThanDate:(NSDate *)date;
- (BOOL)extEarlierThanOrEqualToDate:(NSDate *)date;

- (BOOL)extLaterThanDate:(NSDate *)date;
- (BOOL)extLaterThanOrEqualToDate:(NSDate *)date;

- (BOOL)extEqualToDate:(NSDate *)date;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL extHasExpired;

@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger extMonth;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger extDay;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger extYear;

+ (NSDate *)extDateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year;

@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger extDaysInMonth;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger extWeekday;

+ (NSArray *)extGenerateMonthsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger extLastDayOfMonth;

- (NSDate *)extMakeNormalizedDateWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (NSString *)extFormatDayNumber:(NSUInteger)dayNumber;
@end
