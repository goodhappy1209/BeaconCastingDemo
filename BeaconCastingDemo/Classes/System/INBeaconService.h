//
//  INBlueToothService.h
//  Vicinity
//
//  Created by Ben Ford on 10/28/13.
//  
//  The MIT License (MIT)
// 
//  Copyright (c) 2013 Instrument Marketing Inc
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CLBeacon+Ext.h"
#import "CBPeripheralManager+Ext.h"
#import "CBCentralManager+Ext.h"
#import "CBUUID+Ext.h"

#import "GCDSingleton.h"
#import "ConsoleView.h"
#import "EasedValue.h"

typedef NS_ENUM(unsigned int, INDetectorRange) {
    INDetectorRangeUnknown = 0,
    INDetectorRangeFar,
    INDetectorRangeNear,
    INDetectorRangeImmediate,
};

//#define SINGLETON_IDENTIFIER @"CB284D88-5317-4FB4-9621-C5A3A49E6155"
#define SINGLETON_IDENTIFIER @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"

@class INBeaconService;
@protocol INBeaconServiceDelegate <NSObject>
@optional
- (void)service:(INBeaconService *)service foundDeviceUUID:(NSString *)uuid withRange:(INDetectorRange)range;
- (void)service:(INBeaconService *)service bluetoothAvailable:(BOOL)enabled;
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI Range : (INDetectorRange) _range;
- (void)didDiscoverPeripheral:(CBPeripheral *) peripheral  RSSI:(NSNumber *) RSSI  Range : (INDetectorRange) _range;


@end

@interface INBeaconService : NSObject

- (instancetype)initWithIdentifier:(NSString *)theIdentifier NS_DESIGNATED_INITIALIZER;

- (void)addDelegate:(id<INBeaconServiceDelegate>)delegate;
- (void)removeDelegate:(id<INBeaconServiceDelegate>)delegate;

+ (INBeaconService *)singleton;

@property (nonatomic, readonly) BOOL isDetecting;
@property (nonatomic, readonly) BOOL isBroadcasting;

- (void)startDetecting;
- (void)stopDetecting;

- (void)startBroadcasting;
- (void)stopBroadcasting;

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL hasBluetooth;
@end
