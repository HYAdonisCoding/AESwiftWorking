//
//  AEPerson.m
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/8/11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

#import "AEPerson.h"
#import "AESwiftWorking_Example-Swift.h"

@implementation AEPerson
- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
    }
    return self;
}
+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name {
    return [[self alloc] initWithAge:age name:name];
}

+ (void)run { NSLog(@"Person +run"); }
- (void)run { NSLog(@"Person -run"); }

+ (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"Person +eat %@ %@", food, other); }
- (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"Person %zd %@ -eat %@ %@", (long)_age, _name, food, other); }

- (void)testSwift {
    AECar *car = [[AECar alloc] initWithPrice:10.5 band:@"Bently"];
    car.name = @"BMW";
    car.price = 109;
    [car drive];
    
    [AECar run];
}
@end
int sum(int a, int b) { return a + b; }
