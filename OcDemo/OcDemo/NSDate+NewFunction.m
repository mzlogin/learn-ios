//
//  NSDate+NewFunction.m
//  OcDemo
//
//  Created by 马壮 on 2024/6/29.
//

#import "NSDate+NewFunction.h"

@implementation NSDate (NewFunction)

+(NSDate*)dateFromStr:(NSString *)dateStr {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    return [dateFormatter dateFromString:dateStr];
}

@end
