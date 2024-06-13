//
//  Car.h
//  OcDemo
//
//  Created by 马壮 on 2024/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject<NSCoding>
@property (nonatomic, assign) int driveHours;
+(instancetype)car;
@end

NS_ASSUME_NONNULL_END
