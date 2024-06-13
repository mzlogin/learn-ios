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
-(instancetype)init {
//    if (self = [super init]) {
//        self.car = [Car car];
//        self.name = nil;
//    }
    self.car = [Car car];
    return self;
}

+(instancetype)personWithName:(NSString *)name age:(int)age {
    Person * person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    return person;
}

-(void)display {
    NSLog(@"Person %@ display", self.name);
}
-(void)show {
    NSLog(@"Person %@ show", self.name);
}
-(void)run {
    NSLog(@"the person is running");
}
-(void)displayWithDriveHours:(int)hours {
    self.car.driveHours += hours;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ changed: %@", keyPath, change);
}
- (void)encodeWithCoder:(nonnull NSCoder *)coder { 
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInt:self.age forKey:@"age"];
    [coder encodeObject:self.car forKey:@"car"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder { 
    self.name = [coder decodeObjectForKey:@"name"];
    self.age = [coder decodeIntForKey:@"age"];
    self.car = [coder decodeObjectForKey:@"car"];
    
    return self;
}

@end
