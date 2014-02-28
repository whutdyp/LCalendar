//
//  BottomControlView.m
//  UINavigationTest
//
//  Created by haowenliang on 14-2-15.
//  Copyright (c) 2014年 D-P-Soft. All rights reserved.
//

#import "BottomControlView.h"
//#import "Datetime.h"

#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define VIEWBLACKBGCOLOR [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]


#define VIEWBLACKHEIGHT (48.0)

#define SYSTEM_HEIGHT (320)
#define SYSTEM_WIDTH (320.0)


//////
//Button
#define ButtonWidth (16.0f)
#define ButtonHeigth (32.0f)
#define ButtonMargin (10.0f)

#define ButtonStartX (SYSTEM_WIDTH/2.0 - ButtonWidth- ButtonWidth/2.0 - ButtonMargin)

#define ButtonY (VIEWBLACKHEIGHT - ButtonHeigth)/2.0f
/////


static BottomControlView* pBottomControlView = nil;

@interface BottomControlView()
{
    UIButton* _dayButton;
    UIButton* _monthButton;
    UIButton* _yearButton;
    
    UIButton* _aboutButton;
}

@property (nonatomic, retain) UIButton* dayButton;
@property (nonatomic, retain) UIButton* monthButton;
@property (nonatomic, retain) UIButton* yearButton;
@property (nonatomic, retain) UIButton* aboutButton;

@end

@implementation BottomControlView
@synthesize dayButton = _dayButton,monthButton = _monthButton, yearButton = _yearButton, aboutButton = _aboutButton;

+ (BottomControlView* )getInstance
{
    if (pBottomControlView == nil) {
        pBottomControlView = [[BottomControlView alloc] initWithFrame:CGRectZero];
        [pBottomControlView setBackgroundColor:VIEWBLACKBGCOLOR];
        
        pBottomControlView.frame = CGRectMake(0, SYSTEM_HEIGHT, SYSTEM_WIDTH, VIEWBLACKHEIGHT);
    }
    return pBottomControlView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addBaseSubView];
    }
    return self;
}

- (void)addBaseSubView
{
    CGRect dayF = CGRectMake(ButtonStartX, ButtonY, ButtonWidth, ButtonHeigth);
    CGRect monthF = CGRectMake(ButtonStartX+ButtonWidth+ButtonMargin, ButtonY, ButtonWidth, ButtonHeigth);
    CGRect yearF = CGRectMake(ButtonStartX+2*(ButtonWidth+ButtonMargin), ButtonY, ButtonWidth, ButtonHeigth);
    CGRect aboutF = CGRectMake(SYSTEM_WIDTH - 2*ButtonWidth - 2*ButtonMargin, ButtonY, 2*ButtonWidth, ButtonHeigth);
    
    _dayButton = [self createBaseBarButton:@"日" frame:dayF action:@selector(dayButtonSelected)];
    _monthButton = [self createBaseBarButton:@"月" frame:monthF action:@selector(monthButtonSelected)];
    _yearButton = [self createBaseBarButton:@"年" frame:yearF action:@selector(yearButtonSelected)];
    _aboutButton = [self createBaseBarButton:@"关于" frame:aboutF action:@selector(aboutButtonSelected)];
    
    
    [self addSubview:_dayButton];
    [self addSubview:_monthButton];
    [self addSubview:_yearButton];
    [self addSubview:_aboutButton];
}

- (UIButton *)createBaseBarButton:(NSString*)title frame:(CGRect)frame action:(SEL)selector
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.userInteractionEnabled = YES;
    [btn setBackgroundColor:[UIColor clearColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(0xff, 0xff, 0xff, 1) forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(0xff, 0x00, 0xa0, 1) forState:UIControlStateHighlighted];
    [btn setTitleColor:RGBCOLOR(0xff, 0xff, 0xff, 1) forState:UIControlStateDisabled];

    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

#pragma mark -button selectors

- (void)dayButtonSelected
{
//    NSLog(@"%@",[Datetime GetLunarDayByYear:2014 andMonth:2 andDay:17]);
}

- (void)monthButtonSelected
{
//    NSLog(@"%@",[Datetime GetLunarDayByYear:2014 andMonth:2 andDay:14]);
}

- (void)yearButtonSelected
{
//    NSLog(@"%@",[Datetime GetLunarDayByYear:2014 andMonth:2 andDay:4]);
}

- (void)aboutButtonSelected
{
//    NSLog(@"%@",[Datetime GetLunarDayByYear:2014 andMonth:1 andDay:5]);
}

@end
