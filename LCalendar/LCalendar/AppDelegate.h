//
//  AppDelegate.h
//  LCalendar
//
//  Created by haowenliang on 14-2-24.
//  Copyright (c) 2014年 dpsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDayViewController;
@class LMonthViewController;
@class LAboutViewController;
@class BottomControlView;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    LDayViewController* _dayViewController;
    LMonthViewController* _monthViewController;
    LAboutViewController* _aboutViewController;
    BottomControlView* _bottomView;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LDayViewController* dayViewController;
@property (strong, nonatomic) LMonthViewController* monthViewController;
@property (strong, nonatomic) LAboutViewController* aboutViewController;
@property (strong, nonatomic) BottomControlView* bottomView;

// Main instance of the app delegate
+ (AppDelegate*)getInstance;

- (void)showBottomView;
- (void)dismissBottomView;
@end
