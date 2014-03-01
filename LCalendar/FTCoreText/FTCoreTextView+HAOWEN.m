//
//  FTCoreTextView+HAOWEN.m
//  號闻天下
//
//  Created by haowenliang on 13-11-28.
//  Copyright (c) 2013年 Maximilian Mackh. All rights reserved.
//

#import "FTCoreTextView+HAOWEN.h"

#import "CTMarkUpParser.h"

@implementation FTCoreTextView (HAOWEN)

- (NSMutableString*)appendLicenseOfDPSOFT:(NSMutableString*)nativeString
{
    [nativeString appendString:@"\n\n<_link>http://en.wikipedia.org/wiki/Giraffe|©2013 - D-P-Soft</_link>"];
    return nativeString;
}

- (NSMutableString*)removeHTMLTagInsideString:(NSMutableString*)nativeString
{
    CTMarkUpParser* p = [[[CTMarkUpParser alloc] init] autorelease];
    NSAttributedString* attString = [p attrStringFromMarkup:nativeString];
    NSMutableString* content = [[NSMutableString alloc] initWithString:[attString string]];
    return [content autorelease];
}

@end


@implementation NSMutableString(HAOWEN)

- (void)stringByAppendingLicenseOfDPSOFT:(NSMutableString *)companyName  withDate:(NSString*)dateStr
{
    [self appendString:[NSString stringWithFormat:@"\n\n<_link>http://en.wikipedia.org/wiki/Giraffe|©%@ - %@</_link>",dateStr,companyName]];
}

@end