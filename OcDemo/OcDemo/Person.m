//
//  Animal.m
//  OcDemo
//
//  Created by 马壮 on 2024/3/19.
//

#import "Person.h"

@interface Person ()
-(void)display;
@end

@implementation Person
-(void)display {
    NSLog(@"Person %@ display", self.name);
}
-(void)show {
    NSLog(@"Person %@ show", self.name);
}
-(void)run {
    NSLog(@"the person is running");
}
@end
