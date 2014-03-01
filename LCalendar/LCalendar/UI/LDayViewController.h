//
//  LDayViewController.h
//  LCalendar
//
//  Created by haowenliang on 14-2-25.
//  Copyright (c) 2014年 dpsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDayViewController : UIViewController

- (void)activate;
- (void)resetYMDByYear:(int)year Month:(int)month Day:(int)day;
@end
