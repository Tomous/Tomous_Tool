//
//  NSDate+Extension.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
-(BOOL)isThisYear {
    // 判断self这个日期是否为今年
    NSCalendar *calendar = [NSCalendar calendar];
    NSInteger selfYear =  [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return selfYear == nowYear;
}
-(BOOL)isToday {
    // 判断self这个日期是否为今天
    NSCalendar *calendar = [NSCalendar calendar];
    // 获得年月日元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    return selfCmps.year == nowCmps.year
    && selfCmps.month == nowCmps.month
    && selfCmps.day == nowCmps.day;
}
-(BOOL)isYesterday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];// 20151031
    NSString *nowString = [fmt stringFromDate:[NSDate date]];// 20151101
    
    NSDate *selfDate = [fmt dateFromString:selfString];// 2015-10-31 00:00:00
    NSDate *nowDate = [fmt dateFromString:nowString];// 2015-11-01 00:00:00
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

- (BOOL)isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self]; // 20151031
    NSString *nowString = [fmt stringFromDate:[NSDate date]]; // 20151101
    
    NSDate *selfDate = [fmt dateFromString:selfString]; // 2015-10-31 00:00:00
    NSDate *nowDate = [fmt dateFromString:nowString]; // 2015-11-01 00:00:00
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}
@end
