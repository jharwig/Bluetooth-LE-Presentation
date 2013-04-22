//
//  NICAppDelegate.h
//  BluetoothPresentation
//
//  Created by Jason Harwig on 4/18/13.
//  Copyright (c) 2013 Jason Harwig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <QuartzCore/QuartzCore.h>

@interface NICAppDelegate : UIResponder <UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralDelegate> {
    CBCentralManager *manager;
    CBPeripheral *peripheral;
}

@property (strong, nonatomic) UIWindow *window;

@property (assign) uint16_t heartRate;
@property (retain) NSTimer *pulseTimer;
@property (retain) NSMutableArray *heartRateMonitors;
@property (copy) NSString *manufacturer;
@property (copy) NSString *connected;


- (void) startScan;
- (void) stopScan;
- (BOOL) isLECapableHardware;

- (void) pulse;
- (void) updateWithHRMData:(NSData *)data;

@end
