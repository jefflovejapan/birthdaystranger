//
//  HBBdayInputController.m
//  Happy Birthday Dear Stranger
//
//  Created by Blagdon Jeffrey on 3/1/14.
//  Copyright (c) 2014 Jeffrey Blagdon. All rights reserved.
//

#import "HBBdayInputController.h"
#import "Constants.h"

@interface HBBdayInputController ()
@end

@implementation HBBdayInputController

-(void)viewDidLoad{
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

- (IBAction)doneButtonPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.datePicker.date forKey:BIRTHDAY_KEY];
}




@end
