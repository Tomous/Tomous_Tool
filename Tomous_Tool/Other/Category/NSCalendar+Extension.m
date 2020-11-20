//
//  NSCalendar+Extension.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/20.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)
+ (instancetype)calendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
        return [NSCalendar currentCalendar];
    }
}
@end
