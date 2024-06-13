//
//  Car.m
//  OcDemo
//
//  Created by 马壮 on 2024/4/16.
//

#import "Car.h"
static Car * car = nil;
@implementation Car
+(instancetype) car {
    if (car == nil) {
        car = [[Car alloc] init];
    }
    return car;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeInt:self.driveHours forKey:@"driveHours"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self.driveHours = [coder decodeIntForKey:@"driveHours"];
    return self;
}

@end
