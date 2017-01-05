//
//  NSMutableDictionary.h
//  
//
//  Created by Ben Ford on 7/23/13.
//  Copyright (c) 2013 Ben Ford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(Ext)
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDictionary *extDictionary;
@end
