//
//  AppDelegate.m
//  LCalendar
//
//  Created by haowenliang on 14-2-24.
//  Copyright (c) 2014年 dpsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "LDayViewController.h"
#import "LMonthViewController.h"
#import "LAboutViewController.h"
#import "BottomControlView.h"

static AppDelegate* _instance = nil;

@implementation AppDelegate

@synthesize window;
@synthesize dayViewController = _dayViewController,monthViewController = _monthViewController,aboutViewController = _aboutViewController;
@synthesize bottomView = _bottomView;
#pragma mark -delay initialize sub view controllers
+ (AppDelegate *)getInstance
{
    return _instance;
}

- (LDayViewController *)dayViewController
{
    if (nil == _dayViewController) {
        _dayViewController = [[LDayViewController alloc] init];
        [window addSubview:_dayViewController.view];

    }
    return _dayViewController;
}

- (LMonthViewController *)monthViewController
{
    if (nil == _monthViewController) {
        _monthViewController = [[LMonthViewController alloc] init];
        [window addSubview:_monthViewController.view];
    }
    return _monthViewController;
}

- (LAboutViewController *)aboutViewController
{
    if (nil == _aboutViewController) {
        _aboutViewController = [[LAboutViewController alloc] init];
        [window addSubview:_aboutViewController.view];
    }
    return _aboutViewController;
}

- (BottomControlView *)bottomView
{
    if (nil == _bottomView) {
        _bottomView = [BottomControlView getInstance];
        [_bottomView setParentView:window];
        [window addSubview:_bottomView];
    }
    
    return _bottomView;
}
#pragma mark -main methods to realize the app

- (void)showDayView
{
    [self.dayViewController activate];
    [window bringSubviewToFront:self.dayViewController.view];
}

- (void)showMonthView
{
    [self.monthViewController activate];
    [window bringSubviewToFront:self.monthViewController.view];
}

- (void)showAboutView
{
    [self.aboutViewController activate];
    [window bringSubviewToFront:self.aboutViewController.view];
}

#pragma mark -
- (void)refreshBottomView
{
    
}

- (void)showBottomView
{
    [self.bottomView showView];
}

- (void)dismissBottomView
{
    [self.bottomView dismissView];
}

#pragma mark - default methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIWindow *windowT = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    windowT.backgroundColor = [UIColor clearColor];
    window = windowT;
    
    // Allow other classes to use us
    _instance = self;
    
    //Override point for customization after app launch
    [window makeKeyAndVisible];
    
    //
    [self showMonthView];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
