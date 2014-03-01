//
//  LMonthViewController.m
//  LCalendar
//
//  Created by haowenliang on 14-2-25.
//  Copyright (c) 2014年 dpsoft. All rights reserved.
//
#import "AppDelegate.h"
#import "LMonthViewController.h"
#import "Datetime.h"

#define Week_Label_Start_X (13)
#define Week_Label_Start_Y (30)
#define Week_Label_Width (42)
#define Week_Label_Height (42)


#define Month_Layout_Start_X (13)
#define Month_Layout_Start_Y (54)
#define Month_Item_Width (42)
#define Month_Item_Height (70)

@interface LMonthViewController ()

@end

@implementation LMonthViewController
{
    NSArray * dayArray;
    NSArray * lunarDayArray;
    int strMonth;
    int strYear;
}

- (void)activate
{
    
}

- (id)init
{
    self = [super init];
    if (self) {
        strYear = [[Datetime GetYear] intValue];
        strMonth = [[Datetime GetMonth] intValue];
        dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
        lunarDayArray = [Datetime GetLunarDayArrayByYear:strYear andMonth:strMonth];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self AddWeekLableToCalendarWatch];
    [self AddDaybuttenToCalendarWatch];
    [self AddHandleSwipe];
    [self OtherTouchEvent];
}

//向日历中添加星期标号（周日到周六）
-(void)AddWeekLableToCalendarWatch{
    NSArray* array = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    CGFloat startY = Week_Label_Start_Y;
    
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:array[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(Week_Label_Start_X + i*Week_Label_Width, startY, Week_Label_Width, Week_Label_Height);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lable];
        lable = nil;
    }
    array = nil;
}


//向日历中添加指定月份的日历butten
-(void)AddDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++) {
        UIButton * butten = [[UIButton alloc]init];
        butten.frame = CGRectMake(Month_Layout_Start_X + (i%7)*Month_Item_Width, Month_Layout_Start_Y + (i/7)*Month_Item_Height, Month_Item_Width, Month_Item_Height);
        
        if (([[Datetime GetDay] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth] intValue])&&(strYear == [[Datetime GetYear] intValue])) {
            butten.backgroundColor = [UIColor yellowColor];
        }
        
        //        UIImage *bgImg1 = [UIImage imageNamed:@"Selected.png"];
        //        UIImage *bgImg2 = [UIImage imageNamed:@"Unselected.png"];
        //        [butten setImage:bgImg2 forState:UIControlStateNormal];
        //        [butten setImage:bgImg1 forState:UIControlStateSelected];
        [butten setTag:i+301];
        //        [butten addTarget:self action:@selector(buttenTouchDownAction:) forControlEvents:UIControlEventTouchDown];
        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        butten.showsTouchWhenHighlighted = YES;
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:dayArray[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(0, 0, 47, 60);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        UILabel* lurLable = [[UILabel alloc]init];
        lurLable.text = [NSString stringWithString:lunarDayArray[i]];
        lurLable.textColor = [UIColor blackColor];
        lurLable.backgroundColor = [UIColor clearColor];
        lurLable.frame = CGRectMake(0, 40, 47, 20);
        lurLable.adjustsFontSizeToFitWidth = YES;
        lurLable.textAlignment = NSTextAlignmentCenter;
        
        [butten addSubview:lable];
        [butten addSubview:lurLable];
        [self.view addSubview:butten];
    }
}

-(void)buttenTouchUpInsideAction:(id)sender{
    NSInteger t = [sender tag]-301;
    dayArray = nil,lunarDayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    lunarDayArray =
    [Datetime GetLunarDayArrayByYear:strYear andMonth:strMonth];
    NSLog(@"%d年%d月%@日",strYear,strMonth,dayArray[t]);
    NSLog(@"%@",lunarDayArray[t]);
    [[AppDelegate getInstance] showDayViewOfYear:strYear Month:strMonth Day:[dayArray[t] intValue]];
}

#pragma mark -
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
    strMonth = strMonth+1;
    if(strMonth == 13){
        strYear++;strMonth = 1;
    }
    //NSLog(@"%d,%d",strYear,strMonth);
    [self reloadDateForCalendarWatch];
}

//右滑事件
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    //NSLog(@"%u",gestureRecognizer.direction);
    strMonth = strMonth-1;
    if(strMonth == 0){
        strYear--;strMonth = 12;
    }
    //NSLog(@"%d,%d",strYear,strMonth);
    [self reloadDateForCalendarWatch];
}

//上滑事件
- (void)upHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [[AppDelegate getInstance] showBottomView];
}

//下滑事件
- (void)downHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [[AppDelegate getInstance] dismissBottomView];
}

//在CalendarWatch中重新部署数据
-(void)reloadDateForCalendarWatch{
    dayArray = nil,lunarDayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    lunarDayArray =
    [Datetime GetLunarDayArrayByYear:strYear andMonth:strMonth];
    [self reloadDaybuttenToCalendarWatch];
}

-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++)
        [[self.view viewWithTag:301+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
}

#pragma mark -
//识别其他手势，预留接口
-(void)OtherTouchEvent{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    //UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    /* step2：对手势识别器进行属性设定 */
    [doubleTap setNumberOfTapsRequired:2];
    // 坑：twoFingerTap在模拟器上不灵敏，有时候会识别成singleTap
    [twoFingerTap setNumberOfTouchesRequired:2];
    /* step3：把手势识别器加到view中去 */
    [self.view addGestureRecognizer:singleTap];
    [self.view addGestureRecognizer:doubleTap];
    [self.view addGestureRecognizer:twoFingerTap];
    [self.view addGestureRecognizer:rotation];
    //[self.view addGestureRecognizer:pan];
    [self.view addGestureRecognizer:pinch];
    [self.view addGestureRecognizer:longPress];
    /* step4：出现冲突时，要设定优先识别顺序，目前只是doubleTap、swipe */
    //    [singleTap requireGestureRecognizerToFail:doubleTap];
    //    [singleTap requireGestureRecognizerToFail:twoFingerTap];
    //    [pan requireGestureRecognizerToFail:swipeRight];
    //    [pan requireGestureRecognizerToFail:swipeLeft];
}

//实现处理扑捉到手势之后的动作
/* 识别单击 */
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
}

/* 识别双击 */
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
}

/* 识别两个手指击 */
- (void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecognizer {
}

/* 识别翻转 */
- (void)handleRotation:(UIRotationGestureRecognizer *)gestureRecognizer {
}

/* 识别拖动 */
- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
}

/* 识别放大缩小 */
- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer {
}

/* 识别长按 */
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
