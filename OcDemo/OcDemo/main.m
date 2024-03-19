//
//  main.m
//  OcDemo
//
//  Created by 马壮 on 2024/3/19.
//

#import <Foundation/Foundation.h>
#import "Animal.h"

@interface Student : NSObject
@property NSString *name;
@property int age;
@property float score;
-(void)display;
@end

@implementation Student
-(void)display {
    NSLog(@"%@ 的年龄是 %d, 成绩是 %f", self.name, self.age, self.score);
}
@end

int main(int argc, const char * argv[]) {
    Student *stu1 = [[Student alloc] init];
    stu1.name = @"小明";
    stu1.age = 15;
    stu1.score = 92.5;
    [stu1 display];
    
    Animal *ani1 = [[Animal alloc] init];
    [ani1 show];
    return 0;
}
