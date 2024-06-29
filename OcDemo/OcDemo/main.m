//
//  main.m
//  OcDemo
//
//  Created by 马壮 on 2024/3/19.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+NewFunction.h"
#import "Children.h"
#import "Nanny.h"
#import "Worker.h"
#import "NSDate+NewFunction.h"

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
    
    Children *child = [[Children alloc] init];
    Nanny *nanny = [[Nanny alloc] init];
    child.delegete = nanny;
    if ([child.delegete respondsToSelector:@selector(eat)]) {
        [child.delegete eat];
    }
    
    Person * ZhangSan = [[Person alloc] init];
    Person * LiSi = [[Person alloc] init];
    
    [LiSi displayWithDriveHours:5];
    [ZhangSan displayWithDriveHours:10];
    [LiSi displayWithDriveHours:3];
    
    Car * car = [Car car];
    
    NSLog(@"The allHours are %d", car.driveHours);
    
    NSArray * arr1 = [NSArray arrayWithObjects:@"0", @"1", nil];
    NSLog(@"arr1 are : %@", arr1);
    
    NSDictionary * dic1 = [NSDictionary dictionaryWithObject:@"obj1" forKey:@"key1"];
    NSLog(@"dic1 has : %@", dic1);
    
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    NSString * str = @"https://mazhuang.org";
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"the data is : %@", data);
    NSString * strCopy = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"the new string is : %@", strCopy);
    
    int number = 5;
    NSNumber * intNum = [[NSNumber alloc] initWithInt:number];
    int getNum = [intNum intValue];
    NSLog(@"intNum is %@, getNum is %d", intNum, getNum);
    
    NSRange range;
    range.length = 2;
    range.location = 1;
    NSValue * value = [NSValue valueWithRange:range];
    NSRange theRange = [value rangeValue];
    NSLog(@"value is %@, theRange is %lu,%lu", value, theRange.length, theRange.location);
    
    Worker * worker = [[Worker alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"canMake" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weMake" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:worker name:@"canMake" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"canMake" object:nil];
    
    // KVC
    Person * pKvc = [[Person alloc] init];
    [pKvc setValue:@"Lily" forKey:@"name"];
    [pKvc show];
    NSLog(@"pKvc's name is %@", [pKvc valueForKey:@"name"]);
    
    // KVO
    [pKvc addObserver:pKvc forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [pKvc setValue:@"Hanmei" forKey:@"name"];
    [pKvc removeObserver:pKvc forKeyPath:@"name" context:nil];
    
    // Predicate
    NSArray * array = [NSArray arrayWithObjects:
                       [Person personWithName:@"ZhangSan" age:10],
                       [Person personWithName:@"LiSi" age:15],
                       [Person personWithName:@"WangWu" age:20],
                       [Person personWithName:@"ZhaoLiu" age:25], nil];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"age >= 20"];
    NSArray* myArray = [array filteredArrayUsingPredicate:predicate];
    for (Person * p in myArray) {
        NSLog(@"age >= 20: %@", p.name);
    }
    
    // block
    int localVar1 = 10;
    __block int localVar2 = 20;
    void (^blockTest)(void) = ^(void) {
        NSLog(@"Block Test, localVar1: %d, localVar2: %d", localVar1, localVar2);
        // error: Variable is not assignable (missing __block type specifier)
        // localVar1 = 11;
        localVar2 = 21;
    };
    blockTest();
    
    // write to file
    NSString * path = @"/Users/mazhuang/Downloads/test.txt";
    NSString * content = @"hello, world";
    NSError * error = nil;
    [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@", error);
    
    // read from file
    NSString * contentFromFile = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@", contentFromFile);
    
    // archive
    Person * pArchive = [[Person alloc] init];
    pArchive.name = @"ZhangSan";
    pArchive.age = 10;
    pArchive.car = [[Car alloc] init];
    [NSKeyedArchiver archiveRootObject:pArchive toFile:path];

    // unarchive
    Person * pUnarchived = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"pUnarchived person's name is: %@, age is: %d", pUnarchived.name, pUnarchived.age);
    
    // archive and unarchive multi objects
    Person * pA1 = [Person personWithName:@"ZhangSan" age:10];
    Person * pA2 = [Person personWithName:@"LiSi" age:20];
    NSMutableData * dataToArchive = [NSMutableData data];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataToArchive];
    [archiver encodeObject:pA1 forKey:@"person1"];
    [archiver encodeObject:pA2 forKey:@"person2"];
    [archiver finishEncoding];
    [dataToArchive writeToFile:path atomically:YES];
    
    NSData * dataUnarchived = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dataUnarchived];
    Person * pUa1 = [unarchiver decodeObjectForKey:@"person1"];
    NSLog(@"pUa1's name: %@, age: %d", pUa1.name, pUa1.age);
    Person * pUa2 = [unarchiver decodeObjectForKey:@"person2"];
    NSLog(@"pUa2's name: %@, age: %d", pUa2.name, pUa2.age);
    
    // UserDefaults
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"everRunned"] isEqualToString:@"OK"]) {
        NSLog(@"非首次运行");
    } else {
        NSLog(@"首次运行");
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"OK" forKey:@"everRunned"];
    }
    
    // find library folder path
    NSString * libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"libraryPath: %@", libraryPath);
    
    // date test
    NSDate* date1 = [NSDate dateFromStr:@"2024-06-29 11:36:01"];
    NSDate* date2 = [NSDate dateFromStr:@"2024-06-29 13:36:01"];
    NSLog(@"date1: %@, date2: %@", date1, date2);

    return 0;
}
