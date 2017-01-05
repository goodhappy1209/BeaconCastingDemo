//
//  DemoConstants.h
//  BeaconCastingDemo
//
//  Created by windymobile on 4/25/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#ifndef DemoConstants_h
#define DemoConstants_h

//Define Global Function
#define IOS_VERSION                            [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS_UUID_STRING                        [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define SERVICE_UUID @"00000000-0000-0000-0000-000000000000"
#define CHARACTERISTIC_UUID @"00000000-0000-0000-0000-000000000000"


#define key_beacon_name                     @"name"
#define key_beacon_proximity                @"proximity"
#define key_beacon_rssi                     @"rssi"

#endif /* DemoConstants_h */
