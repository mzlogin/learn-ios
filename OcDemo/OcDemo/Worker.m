//
//  Worker.m
//  OcDemo
//
//  Created by 马壮 on 2024/4/17.
//

#import "Worker.h"

@implementation Worker
-(instancetype) init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(makeCar) name:@"canMake" object:nil];
    }
    return self;
}
-(void) makeCar {
    NSLog(@"Let's begin to make car, gogogo");
}
@end
