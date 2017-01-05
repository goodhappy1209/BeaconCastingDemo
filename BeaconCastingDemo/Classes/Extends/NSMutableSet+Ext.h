//
//  NSMutableSet+Ext.h
//  
//
//  Created by Ben Ford on 8/1/13.
//  Copyright (c) 2013 Ben Ford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet(Ext)
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSSet *extSet;
@end
