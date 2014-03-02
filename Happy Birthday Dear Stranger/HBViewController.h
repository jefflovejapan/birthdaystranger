//
//  HBViewController.h
//  Happy Birthday Dear Stranger
//
//  Created by Blagdon Jeffrey on 3/1/14.
//  Copyright (c) 2014 Jeffrey Blagdon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface HBViewController : UIViewController <CBPeripheralManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *counterOutlet;


-(BOOL)isBirthday;
-(void)startBroadcasting;
-(CBPeripheralManager *)getPeripheralManager;

@end
