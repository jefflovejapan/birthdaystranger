//
//  HBViewControllerSpec.m
//  Happy Birthday Dear Stranger
//
//  Created by Blagdon Jeffrey on 3/1/14.
//  Copyright (c) 2014 Jeffrey Blagdon. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMockito/OCMockito.h>
#import "HBViewController.h"
#import "Constants.h"
#import "HBBdayInputController.h"
#import "HBAppDelegate.h"

SpecBegin(HBViewController)

describe(@"Fresh HBViewController", ^{
    __block HBViewController *_vc;
    __block NSUserDefaults *defaults;
    beforeEach(^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _vc = [sb instantiateViewControllerWithIdentifier:@"Main View Controller"];
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"Birthday"];
        UIView *view = _vc.view;
        expect(view).toNot.beNil();
    });
    
    it(@"should exist", ^{
        expect(_vc).toNot.beNil();
    });
    
    it(@"should not have a birthday in NSUserDefaults", ^{
        expect([defaults objectForKey:BIRTHDAY_KEY]).to.beNil();
    });  
    
});

describe(@"User has entered birthdate", ^{
    __block HBViewController *_vc;
    __block NSUserDefaults *defaults;
    __block NSCalendar *cal;
    beforeEach(^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _vc = [sb instantiateViewControllerWithIdentifier:@"Main View Controller"];
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:BIRTHDAY_KEY];
        UIView *view = _vc.view;
        cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        expect(view).toNot.beNil();
    });
    it(@"should return YES for isBirthday if we set birthday to today", ^{
        [defaults setObject:[[NSDate alloc]init] forKey:BIRTHDAY_KEY];
        expect([_vc isBirthday]).to.equal(YES);
    });
    it(@"should return NO for isBirthday if we set birthday to yesterday", ^{
        NSDate *now = [[NSDate alloc]init];
        NSDateComponents *nowComponents = [cal components:(NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:now];
        NSDateComponents *yesterdayComponents = [[NSDateComponents alloc]init];
        [yesterdayComponents setDay:nowComponents.day - 1];
        [yesterdayComponents setYear:nowComponents.year];
        [yesterdayComponents setMonth:nowComponents.month];
        NSDate *yesterday = [cal dateFromComponents:yesterdayComponents];
        [defaults setObject:yesterday forKey:BIRTHDAY_KEY];
        expect([_vc isBirthday]).to.equal(NO);
    });
    it(@"should broadcast if we tell it to broadcast", ^{
        [_vc startBroadcasting];
        CBPeripheralManager *manager = [_vc getPeripheralManager];
        expect([manager isAdvertising]).to.equal(YES);
    });
    
});

SpecEnd

