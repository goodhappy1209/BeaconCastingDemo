//
//  FindBeaconViewController.m
//  BeaconCastingDemo
//
//  Created by windymobile on 5/5/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#import "FindBeaconViewController.h"

@interface FindBeaconViewController ()<INBeaconServiceDelegate, UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, weak) IBOutlet UITableView * beaconTableView;
@property (nonatomic, retain) NSMutableArray * foundedBeacons;

@end

@implementation FindBeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _foundedBeacons = [[NSMutableArray alloc] init];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [[INBeaconService singleton] addDelegate:self];
    [[INBeaconService singleton] startDetecting];
    [[INBeaconService singleton] startBroadcasting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - INBeaconServiceDelegate
- (void)service:(INBeaconService *)service foundDeviceUUID:(NSString *)uuid withRange:(INDetectorRange)range
{
    //NSLog(@"Found UUID : %@", uuid);
    
    [UIView animateWithDuration:0.3f animations:^{
        switch (range) {
            case INDetectorRangeFar:
//                [EasyLayout topCenterView:targetCircle inParentView:self.view offset:CGSizeMake(0.0f, 50.0f)];
//                targetCircle.alpha = 1.0f;
//                
//                distanceLabel.text = @"Within 60ft";
//                [EasyLayout sizeLabel:distanceLabel mode:ELLineModeMulti maxWidth:100.0f];
//                [EasyLayout positionView:distanceLabel toRightAndVerticalCenterOfView:targetCircle offset:CGSizeMake(15.0f, 0.0f)];
                break;
                
            case INDetectorRangeNear:
//                [EasyLayout sizeLabel:distanceLabel mode:ELLineModeMulti maxWidth:100.0f];
//                [EasyLayout topCenterView:targetCircle inParentView:self.view offset:CGSizeMake(0.0f, 150.0f)];
//                targetCircle.alpha = 1.0f;
//                
//                distanceLabel.text = @"Within 5ft";
//                [EasyLayout sizeLabel:distanceLabel mode:ELLineModeMulti maxWidth:100.0f];
//                [EasyLayout positionView:distanceLabel toRightAndVerticalCenterOfView:targetCircle offset:CGSizeMake(15.0f, 0.0f)];
                break;
                
            case INDetectorRangeImmediate:
//                [EasyLayout positionView:targetCircle aboveView:baseCircle
//              horizontallyCenterWithView:self.view offset:CGSizeMake(0.0f, 10.0f)];
//                targetCircle.alpha = 1.0f;
//                
//                distanceLabel.text = @"Within 1 foot";
//                [EasyLayout sizeLabel:distanceLabel mode:ELLineModeMulti maxWidth:100.0f];
//                [EasyLayout positionView:distanceLabel toRightAndVerticalCenterOfView:targetCircle offset:CGSizeMake(15.0f, 0.0f)];
                break;
                
            case INDetectorRangeUnknown:
//                [EasyLayout topCenterView:targetCircle inParentView:self.view offset:CGSizeMake(0.0f, 50.0f)];
//                targetCircle.alpha = 0.5f;
//                
//                distanceLabel.text = @"Out of range";
//                [EasyLayout sizeLabel:distanceLabel mode:ELLineModeMulti maxWidth:100.0f];
//                [EasyLayout positionView:distanceLabel toRightAndVerticalCenterOfView:targetCircle offset:CGSizeMake(15.0f, 0.0f)];
                break;
        }
    }];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI Range : (INDetectorRange) _range
{
//    NSLog(@"Peripheral Data : %@", peripheral);
//    BOOL addable = YES;
//    for (NSObject * _dictObj in _foundedBeacons) {
//        CBPeripheral * _cbPeripheral = (CBPeripheral *) _dictObj;
//        if ([_cbPeripheral.identifier isEqual:peripheral.identifier]) {
//            addable = NO;
//            break;
//        }
//    }
//
//    if (addable) {
//        [_foundedBeacons addObject:peripheral];
//        [_beaconTableView reloadData];
//    }
//    [_foundedBeacons removeAllObjects];
    
    
}

- (void)didDiscoverPeripheral:(CBPeripheral *) peripheral  RSSI:(NSNumber *) RSSI  Range : (INDetectorRange) _range
{
//    NSLog(@"Peripheral Data : %@: %@ : %u", peripheral, RSSI, _range);
    if (peripheral == nil) return;
    else
    {
     
        BOOL refreshAble = NO;
        
        for (NSObject * _dictObj in _foundedBeacons) {
           NSDictionary * _cbPeripheral = (NSDictionary *) _dictObj;
           if ([[_cbPeripheral valueForKey:key_beacon_name] isEqual:peripheral.name]) {
               refreshAble = YES;
           }
        }
        
        if (refreshAble) {
            [_foundedBeacons removeAllObjects];
        }
        
        NSDictionary * BeaconInfo = @{
                                      key_beacon_name : peripheral.name,
                                      key_beacon_proximity : [NSString stringWithFormat:@"%u", _range],
                                      key_beacon_rssi : [RSSI stringValue]
                                      };
        
        [_foundedBeacons addObject:BeaconInfo];
        [_beaconTableView reloadData];
    }
}


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return _foundedBeacons.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BeaconTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BeaconTableViewCell"];
    NSDictionary * beacon = (NSDictionary *) [_foundedBeacons objectAtIndex:indexPath.row];
    [cell setBeaconData:beacon];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static BeaconTableViewCell * cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"BeaconTableViewCell"];
    });
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}


- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
