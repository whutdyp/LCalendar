//
//  BottomControlView.h
//  UINavigationTest
//
//  Created by haowenliang on 14-2-15.
//  Copyright (c) 2014年 D-P-Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomControlView : UIView

@property (nonatomic, retain) UIView* parentView;

+ (BottomControlView* )getInstance;

- (void)showView;
- (void)showViewAutoHide:(BOOL)autoly;

- (void)dismissView;

@end
