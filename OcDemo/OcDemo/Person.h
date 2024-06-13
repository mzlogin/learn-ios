//
//  Person.h
//  OcDemo
//
//  Created by 马壮 on 2024/3/19.
//

#import <Foundation/Foundation.h>
#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCoding>
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) int age;
@property(nonatomic,strong) Car * car;
-(void)run;
-(void)show;
-(void)displayWithDriveHours:(int)hours;

+(instancetype)personWithName:(NSString *)name age:(int)age;

@end

NS_ASSUME_NONNULL_END
