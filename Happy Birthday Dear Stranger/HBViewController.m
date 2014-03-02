//
//  HBViewController.m
//  Happy Birthday Dear Stranger
//
//  Created by Blagdon Jeffrey on 3/1/14.
//  Copyright (c) 2014 Jeffrey Blagdon. All rights reserved.
//

#import "HBViewController.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>
#import "HBAppDelegate.h"

@interface HBViewController ()
@property (strong, nonatomic)  NSUserDefaults *defaults;
@property (strong, nonatomic) NSCalendar *cal;
@end

@implementation HBViewController

-(void)viewWillAppear:(BOOL)animated{
    if ([self isBirthday]) {
        [self startBroadcasting];
//        [self displayBirthdayView];
    } else {
//        [self displayNormalView];
    }
}

-(BOOL)isBirthday{
    NSDate *birthdate = [self.defaults objectForKey:BIRTHDAY_KEY];
    if (birthdate) {
        NSDate *now = [[NSDate alloc]init];     // defaults to current date / time
        NSDateComponents *birthdateComponents = [self.cal components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:birthdate];
        NSDateComponents *nowComponents = [self.cal components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:now];
        if (birthdateComponents.month == nowComponents.month && birthdateComponents.day == nowComponents.day) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

-(void)startBroadcasting{
    CLBeaconRegion *region =
    [[CLBeaconRegion alloc]initWithProximityUUID:[HBAppDelegate birthdayUUID]
                                      identifier:[HBAppDelegate birthdayID]];
    NSDictionary *peripheralData = [region peripheralDataWithMeasuredPower:nil];
    [[self getPeripheralManager] startAdvertising:peripheralData];
}


-(void)viewDidAppear:(BOOL)animated{
    if (![self.defaults objectForKey:BIRTHDAY_KEY]) {
        [self performSegueWithIdentifier:@"Bday Input Segue" sender:self];
    }
}

-(NSUserDefaults *)defaults{
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

-(NSCalendar *)cal{
    if (!_cal) {
        _cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return _cal;
}

- (CBPeripheralManager *)getPeripheralManager {
    static CBPeripheralManager *_peripheralManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    });
    return _peripheralManager;
}


#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    // TODO -- do something here?
}


@end
