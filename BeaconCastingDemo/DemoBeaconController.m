//
//  ViewController.m
//  BeaconCastingDemo
//
//  Created by windymobile on 4/25/16.
//  Copyright © 2016 windymobile. All rights reserved.
//

#import "DemoBeaconController.h"

@interface DemoBeaconController()<UIAlertViewDelegate, CBPeripheralManagerDelegate, CLLocationManagerDelegate, CoreBluetoothDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic *transferCharacteristic;
@property (nonatomic, strong) NSMutableArray *centrals;

@property (nonatomic, strong) CoreBluetoothController *bluetoothController;

@property (nonatomic, weak) IBOutlet UITableView * beaconTableView;
@property (nonatomic, retain) NSMutableArray * foundedBeacons;

@end

@implementation DemoBeaconController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // init the peripheral manager and array for connected centrals
    
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    _centrals = [NSMutableArray array];
    
    
    _bluetoothController = [CoreBluetoothController sharedInstance];
    _bluetoothController.delegate = self;
    /*if (!_bluetoothController.isConnected)
     [_bluetoothController findPeripherals];*/
    
    [_bluetoothController startReadingRSSI];
    
    _foundedBeacons = [[NSMutableArray alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // stop advertising when view will disappear
    
    [self.peripheralManager stopAdvertising];
    self.peripheralManager = nil;
    
    [super viewWillDisappear:animated];
}

#pragma mark - CoreBluetooth Delegate.
- (void)didUpdateRSSI:(int)RSSI Peripheral:(CBPeripheral *)_peripheral
{
    
    if (RSSI < 0 && RSSI > -50) {
        NSLog(@"Immediate");
    }
    else if (RSSI <= -50 && RSSI >= -80) {
        NSLog(@"Near");
    }
    else if (RSSI < -80) {
        NSLog(@"Far");
    }
    else {
        NSLog(@"Unknown");
    }
    
}

- (void) addPeripheralBeacon:(CBPeripheral *)_peripheral
{
    for (NSObject * beaconItem in _foundedBeacons) {
        CBPeripheral * _lPeripheralBeacon = (CBPeripheral *)beaconItem;
        if ([_peripheral.identifier isEqual:_lPeripheralBeacon.identifier]  ) {
            return;
        }
    }
    
    [_foundedBeacons addObject:_peripheral];
    [_beaconTableView reloadData];
}

- (void) removePeripheralBeacon:(CBPeripheral *)_perpheral
{
    for (NSObject * beaconItem in _foundedBeacons) {
        CBPeripheral * _lPeripheralBeacon = (CBPeripheral *)beaconItem;
        if ([_perpheral.identifier isEqual:_lPeripheralBeacon.identifier]  ) {
            [_foundedBeacons removeObject:beaconItem];
            [_beaconTableView reloadData];
            return;
        }
    }
}

#pragma mark - CBPeripheral delegate methods
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        [[CustomDafault OKCancelDefaultAlertView:@"Bluetooth off" Message:@"Active to Bluetooth Service on Settings " Delegate:self Tag:1000 Buttons:@[@"Cancel", @"Setting"]] show];
        return;
    }
    
    NSLog(@"PeripheralManager powered on.");
    
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString: CHARACTERISTIC_UUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:SERVICE_UUID] primary:YES];
    
    transferService.characteristics = @[self.transferCharacteristic];
    
    [self.peripheralManager addService:transferService];
    
    [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:SERVICE_UUID]], CBAdvertisementDataLocalNameKey : @"com.wonderfulmobileworld.development" }];
    
    NSLog(@"PeripheralManager is broadcasting (%@).", SERVICE_UUID);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    [_centrals addObject:central];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    // Set the data for this cell:
    
    CBPeripheral * _perpheralItem = (CBPeripheral *) [_foundedBeacons objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _perpheralItem.identifier];
    
//    cell.detailTextLabel.text = @"More text";
//    cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
//    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - UIAlertViewDelegate.
- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1000:
        {
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
