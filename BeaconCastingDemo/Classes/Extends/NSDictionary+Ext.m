//
//  NSDictionary+Ext.m
//  
//
//  Created by Ben Ford on 2/23/12.
//  Copyright (c) 2012 Ben Ford All rights reserved.
//

#import "NSDictionary+Ext.h"

@implementation NSDictionary(Ext)
- (NSNumber *)extNumberForKeyOrZero:(NSString *)theKey {
	id number = self[theKey];
    
	if ( [number isKindOfClass:[NSNumber class]] )
		return number;
	
	if ( [number isKindOfClass:[NSString class]] ) 
		return @([number floatValue]);
	
	return @0;
}

@end
