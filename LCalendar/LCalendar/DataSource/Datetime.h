//  LunarCalendar
//
//  Created by cocrash on 14-2-17.
//  Copyright (c) 2013年 D-P-Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LunarCalendar;

@interface Datetime : NSObject

//获取某年某月某日的农历对象
+ (LunarCalendar* )GetLunarCalendarByYear:(int)year
                                 andMonth:(int)month
                                   andDay:(int)day;
//獲取某天的節氣,農曆,星期等信息   
+ (NSDictionary*)GetFestivalDayByYear:(int)year
                         andMonth:(int)month
                           andDay:(int)day;

//所有年列表
+(NSArray *)GetAllYearArray;

//所有月列表
+(NSArray *)GetAllMonthArray;


//获取指定年份指定月份的星期排列表
+(NSArray *)GetDayArrayByYear:(int) year
                     andMonth:(int) month;

//获取指定年份指定月份的星期排列表(农历)
+(NSArray *)GetLunarDayArrayByYear:(int) year
                          andMonth:(int) month;

//获取某年某月某日的对应农历
+(NSString *)GetLunarDayByYear:(int) year
                      andMonth:(int) month
                        andDay:(int) day;


//以YYYY.MM.dd格式输出年月日
+(NSString*)getDateTime;

//以YYYY年MM月dd日格式输出年月日
+(NSString*)GetDateTime;

//以YYYY年MMdd格式输出此时的农历年月日
+(NSString*)GetLunarDateTime;

+(NSString *)GetYear;

+(NSString *)GetMonth;

+(NSString *)GetDay;

+(NSString *)GetHour;

+(NSString *)GetMinute;

+(NSString *)GetSecond;

/////////////////////////
+ (NSDictionary*)GetNextDateByYear:(int)year
                          andMonth:(int)month
                            andDay:(int)day;
+ (NSDictionary*)getPreviousDateByYear:(int)year
                              andMonth:(int)month
                                andDay:(int)day;

@end
