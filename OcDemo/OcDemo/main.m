//
//  main.m
//  OcDemo
//
//  Created by 马壮 on 2024/3/19.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+NewFunction.h"

int main(int argc, const char * argv[]) {
    Person *p1 = [[Person alloc] init];
    p1.name = @"Jack";
    [p1 show];
//    [p1 display];
    [p1 setName:@"Ma"];
    [p1 show];
    
    id p2 = [[Person alloc] init];
    [p2 setName:@"id"];
    [p2 show];
    [p2 eat];
    return 0;
}
