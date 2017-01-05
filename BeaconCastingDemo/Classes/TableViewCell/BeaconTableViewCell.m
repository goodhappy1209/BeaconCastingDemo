//
//  BeaconTableViewCell.m
//  BeaconCastingDemo
//
//  Created by windymobile on 5/5/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#import "BeaconTableViewCell.h"

@implementation BeaconTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setBeaconData : (id) __foundBeacon;
{
    NSDictionary * _foundBeacon = (NSDictionary *) __foundBeacon;
    
    [__lblIdentifier setText:[_foundBeacon objectForKey:key_beacon_name]];
    [__lblBeaconRssi setText:[_foundBeacon objectForKey:key_beacon_rssi]];
    
    if ([[_foundBeacon objectForKey:key_beacon_proximity] integerValue] == INDetectorRangeUnknown) {
        [__lblBeaconProximity setText:@"Out of Range"];
    }
    else if ([[_foundBeacon objectForKey:key_beacon_proximity] integerValue] == INDetectorRangeImmediate)
    {
        [__lblBeaconProximity setText:@"Within 1 foot"];
    }
    else if ([[_foundBeacon objectForKey:key_beacon_proximity] integerValue] == INDetectorRangeNear)
    {
        [__lblBeaconProximity setText:@"Within 5ft"];
    }
    else if([[_foundBeacon objectForKey:key_beacon_proximity] integerValue] == INDetectorRangeFar)
    {
        [__lblBeaconProximity setText:@"Within 60ft"];
    }
    
}

@end
