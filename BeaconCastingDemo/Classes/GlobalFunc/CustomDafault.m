//
//  CustomDafault.m
//  BeaconCastingDemo
//
//  Created by windymobile on 4/25/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#import "CustomDafault.h"

@implementation CustomDafault

/******
 ******
 ******/

+ (UIAlertView *) OKCancelDefaultAlertView : (NSString *) _title Message : (NSString * ) _message Delegate : (id) _delegate Tag : (NSInteger) _tag Buttons : (NSArray *) _buttons
{
    UIAlertView * _alertView = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:_delegate cancelButtonTitle:[_buttons objectAtIndex:0] otherButtonTitles:[_buttons objectAtIndex:1], nil];
    [_alertView setTag:_tag];
    return _alertView;
}


@end
