//
//  BeaconTableViewCell.h
//  BeaconCastingDemo
//
//  Created by windymobile on 5/5/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel * _lblIdentifier;
@property (nonatomic, weak) IBOutlet UILabel * _lblBeaconRssi;
@property (nonatomic, weak) IBOutlet UILabel * _lblBeaconProximity;

- (void) setBeaconData : (id) __foundBeacon;

@end
