//
//  HBBdayInputControllerSpec.m
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


SpecBegin(HBBdayInputController)

describe(@"HBBdayInputController", ^{
    __block HBBdayInputController *_vc;
    __block NSUserDefaults *defaults;
    beforeEach(^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _vc = [sb instantiateViewControllerWithIdentifier:@"Bday Input Controller"];
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"Birthday"];
        UIView *view = _vc.view;
        expect(view).toNot.beNil();
    });
    
    it(@"should exist", ^{
        expect(_vc).toNot.beNil();
    });
    
    it(@"should set BIRTHDAY_KEY in user defaults to selected value", ^{
        NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:0];
        [_vc.datePicker setDate:testDate];
        [_vc performSelector:@selector(doneButtonPressed:)];
        expect([testDate isEqualToDate:[defaults valueForKey:BIRTHDAY_KEY]]).to.equal(YES);
    });
});

SpecEnd
