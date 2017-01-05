//
//  CustomDafault.h
//  BeaconCastingDemo
//
//  Created by windymobile on 4/25/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomDafault : NSObject


/*****
 *****  Define UIAlertView of the OkCancel Default style.
 *****/
+ (UIAlertView *) OKCancelDefaultAlertView : (NSString *) _title Message : (NSString * ) _message Delegate : (id) _delegate Tag : (NSInteger) _tag Buttons : (NSArray *) _buttons;

@end
