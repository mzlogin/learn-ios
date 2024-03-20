//
//  Person.h
//  OcDemo
//
//  Created by 马壮 on 2024/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) int age;
-(void)run;
-(void)show;
@end

NS_ASSUME_NONNULL_END
