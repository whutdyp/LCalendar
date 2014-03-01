//
//  LDayViewController.m
//  LCalendar
//
//  Created by haowenliang on 14-2-25.
//  Copyright (c) 2014年 dpsoft. All rights reserved.
//

#import "LDayViewController.h"
#import "Datetime.h"
#import "AppDelegate.h"

@interface LDayViewController ()
{
    NSDictionary* dataSource;
    int strDay;
    int strMonth;
    int strYear;
    
    UILabel* festival;
    UILabel* lunarInfo;
    UILabel* weekDay;
    UILabel* solarInfo;
}

@end

@implementation LDayViewController

- (void)activate
{
    [self refleshUI:YES];
}

- (void)resetYMDByYear:(int)year Month:(int)month Day:(int)day
{
    strYear = year;
    strMonth = month;
    strDay = day;
    dataSource = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        strDay = [[Datetime GetDay] intValue];
        strYear = [[Datetime GetYear] intValue];
        strMonth = [[Datetime GetMonth] intValue];
        dataSource = nil;
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self AddHandleSwipe];
}

- (void)refleshUI:(BOOL)reloadData
{
    if (dataSource == nil || reloadData) {
        dataSource = nil;
        dataSource =[NSDictionary dictionaryWithDictionary:[Datetime GetFestivalDayByYear:strYear andMonth:strMonth andDay:strDay]];
    }
    if (lunarInfo ==  nil) {
        lunarInfo= [[UILabel alloc]initWithFrame:CGRectZero];
        lunarInfo.backgroundColor = [UIColor clearColor];
//        lunarInfo.font = [UIFont systemFontOfSize:24];
        lunarInfo.font = [UIFont fontWithName:@"DBLCDTempBlack" size:48];
        lunarInfo.textColor = [UIColor blackColor];
        lunarInfo.numberOfLines = 0;
        lunarInfo.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lunarInfo];
    }
    lunarInfo.text = [dataSource objectForKey:@"lunar"];
    CGSize lsize = [self labelDisplayVertically:lunarInfo.text withFont:lunarInfo.font];
    [lunarInfo setFrame:CGRectMake(0, 0, lsize.width, lsize.height)];
    [lunarInfo setCenter:CGPointMake(160.0, 64.0+lsize.height/2.0)];
    
    if (festival == nil) {
        festival= [[UILabel alloc]initWithFrame:CGRectZero];
        festival.backgroundColor = [UIColor clearColor];
        //        festival.font = [UIFont systemFontOfSize:16];
        festival.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:16];
        festival.textColor = [UIColor blackColor];
        festival.textAlignment = NSTextAlignmentRight;
        festival.numberOfLines = 0;
        [self.view addSubview:festival];
    }
    festival.text = [dataSource objectForKey:@"festival"];
    CGSize fsize = [self labelDisplayVertically:festival.text withFont:festival.font];
    festival.frame = CGRectMake(CGRectGetMaxX(lunarInfo.frame)+ 15.0f, 72.0, fsize.width, fsize.height);
    
    
    if (solarInfo == nil) {
        solarInfo = [[UILabel alloc]initWithFrame:CGRectZero];
        solarInfo.backgroundColor = [UIColor clearColor];
        solarInfo.font = [UIFont fontWithName:@"DBLCDTempBlack" size:14];
        solarInfo.textColor = [UIColor blackColor];
        solarInfo.textAlignment = NSTextAlignmentCenter;
        solarInfo.numberOfLines = 1;
        [self.view addSubview:solarInfo];
    }
    solarInfo.text = [NSString stringWithFormat:@"%d / %d / %d",strYear,strMonth,strDay];
    CGSize ssize = [self labelDisplayHorizontal:solarInfo.text withFont:solarInfo.font];
    solarInfo.frame = CGRectMake(0, 0, ssize.width, ssize.height);

    if (weekDay == nil) {
        weekDay = [[UILabel alloc]initWithFrame:CGRectZero];
        weekDay.backgroundColor = [UIColor clearColor];
        weekDay.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:14];
        weekDay.textColor = [UIColor blackColor];
        weekDay.textAlignment = NSTextAlignmentCenter;
        weekDay.numberOfLines = 1;
        [self.view addSubview:weekDay];
    }
    weekDay.text = [dataSource objectForKey:@"weekday"];
    CGSize wsize = [self labelDisplayHorizontal:weekDay.text withFont:weekDay.font];
    weekDay.frame = CGRectMake(0, 0, wsize.width, wsize.height);

    if ([[AppDelegate getInstance].bottomView isHidden]) {
        solarInfo.center = CGPointMake(160.0f, SCREEN_HEIGHT - CGRectGetHeight(solarInfo.frame)/2.0f - 10.0f);
    }else{
        CGFloat height = CGRectGetHeight([AppDelegate getInstance].bottomView.frame);
        solarInfo.center = CGPointMake(160.0f, SCREEN_HEIGHT - CGRectGetHeight(solarInfo.frame)/2.0f - 10.0f - height);
    }
    weekDay.center = CGPointMake(160.0f, CGRectGetMinY(solarInfo.frame) - CGRectGetHeight(weekDay.frame)/2.0f - 5.0f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)labelDisplayVertically:(NSString*)content withFont:(UIFont *)font
{
    NSString *text = @"文";
//    UIFont *font = [UIFont systemFontOfSize:12];
    
    CGFloat w = 0.0f;
    CGSize sizeStr = CGSizeZero;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        CGSize sizeWord = [text sizeWithFont:font constrainedToSize:CGSizeMake(320, 2000.0) lineBreakMode:UILineBreakModeWordWrap];
        
        w = sizeWord.width;//一个汉字的宽度
        sizeStr = [content sizeWithFont:font constrainedToSize:CGSizeMake(w, 2000.0) lineBreakMode:UILineBreakModeWordWrap];
    }
    else{
        NSDictionary* attributes = @{NSFontAttributeName:font};
        w = [text boundingRectWithSize:CGSizeMake(320.0, 2000.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        
        CGRect rect = [content boundingRectWithSize:CGSizeMake(w, 2000.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        sizeStr = rect.size;
    }
    
    CGFloat h = sizeStr.height;
    return CGSizeMake(w, h);
}

- (CGSize)labelDisplayHorizontal:(NSString*)content withFont:(UIFont *)font
{
    NSString *text = @"文";
    CGFloat h = 0.0;
    CGSize sizeStr = CGSizeZero;
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        CGSize sizeWord = [text sizeWithFont:font constrainedToSize:CGSizeMake(320, 2000.0) lineBreakMode:UILineBreakModeWordWrap];
        
        h = sizeWord.height;//一个汉字的高度
        sizeStr = [content sizeWithFont:font constrainedToSize:CGSizeMake(320, h) lineBreakMode:UILineBreakModeWordWrap];
    }
    else{
        NSDictionary* attributes = @{NSFontAttributeName:font};
        h = [text boundingRectWithSize:CGSizeMake(320.0, 2000.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
        
        CGRect rect = [content boundingRectWithSize:CGSizeMake(320.0f, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        sizeStr = rect.size;
    }
    
    return sizeStr;
}

#pragma mark -滑動手勢

//添加左右滑动手势
-(void)AddHandleSwipe{
    //声明和初始化手势识别器
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftHandleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightHandleSwipe:)];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upHandleSwipe:)];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downHandleSwipe:)];
    //对手势识别器进行属性设定
    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [swipeUp setNumberOfTouchesRequired:1];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [swipeDown setNumberOfTouchesRequired:1];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    //把手势识别器加到view中去
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    
    [self.view addGestureRecognizer:swipeUp];
    [self.view addGestureRecognizer:swipeDown];
}

//左滑事件
- (void)leftHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    //NSLog(@"%u",gestureRecognizer.direction);
    
    NSDictionary* iDate = [Datetime GetNextDateByYear:strYear andMonth:strMonth andDay:strDay];
    strYear = [[iDate objectForKey:@"year"] intValue];
    strMonth = [[iDate objectForKey:@"month"] intValue];
    strDay = [[iDate objectForKey:@"day"] intValue];
    //NSLog(@"%d,%d",strYear,strMonth);
    [self refleshUI:YES];
}

//右滑事件
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    //NSLog(@"%u",gestureRecognizer.direction);
    NSDictionary* iDate = [Datetime getPreviousDateByYear:strYear andMonth:strMonth andDay:strDay];
    strYear = [[iDate objectForKey:@"year"] intValue];
    strMonth = [[iDate objectForKey:@"month"] intValue];
    strDay = [[iDate objectForKey:@"day"] intValue];
    //NSLog(@"%d,%d",strYear,strMonth);
    [self refleshUI:YES];
}

//上滑事件
- (void)upHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [[AppDelegate getInstance] showBottomView];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         if ([[AppDelegate getInstance].bottomView isHidden]) {
                             solarInfo.center = CGPointMake(160.0f, SCREEN_HEIGHT - CGRectGetHeight(solarInfo.frame)/2.0f - 10.0f);
                         }else{
                             CGFloat height = CGRectGetHeight([AppDelegate getInstance].bottomView.frame);
                             solarInfo.center = CGPointMake(160.0f, SCREEN_HEIGHT - CGRectGetHeight(solarInfo.frame)/2.0f - 10.0f - height);
                         }
                         weekDay.center = CGPointMake(160.0f, CGRectGetMinY(solarInfo.frame) - CGRectGetHeight(weekDay.frame)/2.0f - 5.0f);
                     }
                     completion:^(BOOL finished){
                     }];
}

//下滑事件
- (void)downHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [[[AppDelegate getInstance] bottomView] dismissViewWithBloc:^(BOOL reload){
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             if ([[AppDelegate getInstance].bottomView isHidden]) {
                                 solarInfo.center = CGPointMake(160.0f, SCREEN_HEIGHT - CGRectGetHeight(solarInfo.frame)/2.0f - 10.0f);
                             }else{
                                 CGFloat height = CGRectGetHeight([AppDelegate getInstance].bottomView.frame);
                                 solarInfo.center = CGPointMake(160.0f, SCREEN_HEIGHT - CGRectGetHeight(solarInfo.frame)/2.0f - 10.0f - height);
                             }
                             weekDay.center = CGPointMake(160.0f, CGRectGetMinY(solarInfo.frame) - CGRectGetHeight(weekDay.frame)/2.0f - 5.0f);
                         }
                         completion:^(BOOL finished){
                         }];
    }];
}

@end
