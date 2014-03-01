//
//  FTCoreTextView+HAOWEN.h
//  號闻天下
//
//  Created by haowenliang on 13-11-28.
//  Copyright (c) 2013年 Maximilian Mackh. All rights reserved.
//

#import "FTCoreTextView.h"

@interface FTCoreTextView (HAOWEN)
/**
 * 追加自定義的標籤
 * ©2013 - D-P-Soft
 */
- (NSMutableString*)appendLicenseOfDPSOFT:(NSMutableString*)nativeString;

/**
 *  清除HTML的标签
 */
- (NSMutableString*)removeHTMLTagInsideString:(NSMutableString*)nativeString;



@end

@interface NSMutableString (HAOWEN)
- (void)stringByAppendingLicenseOfDPSOFT:(NSMutableString *)companyName withDate:(NSString*)date;
@end