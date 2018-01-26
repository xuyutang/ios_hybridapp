//
//  NSDate+Util.m
//  JSLite
//
//  Created by ZhangLi on 8/4/13.
//  Copyright (c) 2013 ZhangLi. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (ExDate)

- (NSString *)getFormatYearMonthDay
{
    NSString *string = [NSString stringWithFormat:@"%d%d%d",[self getYear],[self getMonth],[self getDay]];
    return string;
}
//返回当前月一共有几周(可能为4,5,6)
- (int )getWeekNumOfMonth
{
    return [[self endOfMonth] getWeekOfYear] - [[self beginningOfMonth] getWeekOfYear] + 1;
}


//该日期是该年的第几周
- (int )getWeekOfYear
{
    int i;
    int year = [self getYear];
    NSDate *date = [self endOfWeek];
    for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year;i++)
    {
    }
    return i;
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterDay;
}
//month个月后的日期
- (NSDate *)dateafterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterMonth;
}
//获取日
- (NSUInteger)getDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
    return [dayComponents day];
}
//获取月
- (NSUInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
    return [dayComponents month];
}
//获取年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
    return [dayComponents year];
}
//获取小时
- (int )getHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return (int)hour;
}
//获取分钟
- (int)getMinute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components minute];
    return (int)minute;
}
- (int )getHour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [components hour];
    return (int)hour;
}
- (int)getMinute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger minute = [components minute];
    return (int)minute;
}
//在当前日期前几天
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}
//午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%d days ago", daysAgo];
    }
    return text;
}
//返回一周的第几天(周末为第一天)
- (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
    return [weekdayComponents weekday];
}
//转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
    
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    NSString *displayString = nil;
    
    // comparing against midnight
    if ([date compare:midnight] == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        if ([date compare:lastweek] == NSOrderedDescending) {
            [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                [displayFormatter setDateFormat:@"MMM d"];
            } else {
                [displayFormatter setDateFormat:@"MMM d, yyyy"];
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
    return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}
//返回周日的的开始时间
- (NSDate *)beginningOfWeek {
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}
//返回当前天的年月日.
- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:self]; 
    return [calendar dateFromComponents:components]; 
} 
//返回该月的第一天 
- (NSDate *)beginningOfMonth 
{ 
    return [self dateAfterDay:-[self getDay] + 1]; 
} 
//该月的最后一天 
- (NSDate *)endOfMonth 
{ 
    return [[[self beginningOfMonth] dateafterMonth:1] dateAfterDay:-1]; 
} 
//返回当前周的周末 
- (NSDate *)endOfWeek { 
    NSCalendar *calendar = [NSCalendar currentCalendar]; 
    // Get the weekday component of the current date 
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self]; 
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init]; 
    // to get the end of week for a particular date, add (7 - weekday) days 
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])]; 
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0]; 
    
    return endOfWeek; 
} 

+ (NSString *)dateFormatString { 
    return @"yyyy-MM-dd"; 
} 

+ (NSString *)timeFormatString { 
    return @"HH:mm:ss"; 
} 

+ (NSString *)timestampFormatString { 
    return @"yyyy-MM-dd HH:mm:ss"; 
} 

// preserving for compatibility 
+ (NSString *)dbFormatString { 
    return [NSDate timestampFormatString]; 
}

+ (NSString *)getCurrentTime{
    NSDate *senddate=[NSDate date];
    return [self stringFromDate:senddate withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)getTomorrowTime{
    NSDate *senddate=[NSDate dateWithTimeIntervalSinceNow:+86400];
    return [self stringFromDate:senddate withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)getCurrentDateTime{
    NSDate *senddate=[NSDate date];
    return [self stringFromDate:senddate withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)getYesterdayTime{
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-86400];
    return [self stringFromDate:senddate withFormat:@"yyyy-MM-dd HH:mm"];
}
+ (NSString *)getYesterdayDate{
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-86400];
    return [self stringFromDate:senddate withFormat:@"yyyy-MM-dd"];;
}

+ (NSString*) getCurrentDate {
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    
    return date;
}

+ (NSString *)dateWithFormatTodayOrYesterday:(NSString *)date{
    /*NSDate * today = [NSDate date];
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];*/
    //NSDate * refDate = [self dateFromString:date];
    NSString* today = [self getCurrentDate];
    NSString* yesterday = [self getYesterdayDate];
    
    // 10 first characters of description is the calendar date:
    //NSString * todayString = [[today description] substringToIndex:10];
    //NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * refDateString = [date substringWithRange:NSMakeRange(0,10)];
    NSString* refTimeString = [date substringWithRange:NSMakeRange(11,8)];
    
    if ([refDateString isEqualToString:today]){
        return [NSString stringWithFormat:@"今天 %@",refTimeString];
    } else if ([refDateString isEqualToString:yesterday]){
        return [NSString stringWithFormat:@"昨天 %@",refTimeString];
    }
    else{
        return date;
    }
}

+ (BOOL) compareDate:(NSString*) date otherDate:(NSString*)otherDate{
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date1 = [dateFromatter dateFromString:date];
    NSDate *date2 = [dateFromatter dateFromString:otherDate];
    
    if([date1 compare:date2] == NSOrderedAscending){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)stringMonthAndDayFromDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];

    return [NSString stringWithFormat:@"%d月%d日",[dateComponent month],[dateComponent day]];
}

+ (NSString *)weekDayWithIndex:(NSString *)strIndex;{
    int index = [strIndex intValue];
    int nDay = index -1;
    NSString *weekDay = @"日";
    if (nDay == 1) {
        weekDay = @"一";
    }else if (nDay == 2){
        weekDay = @"二";
    }else if (nDay == 3){
        weekDay = @"三";
    }else if (nDay == 4){
        weekDay = @"四";
    }else if (nDay == 5){
        weekDay = @"五";
    }else if (nDay == 6){
        weekDay = @"六";
    }
    return weekDay;
}

@end