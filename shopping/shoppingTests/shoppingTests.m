//
//  shoppingTests.m
//  shoppingTests
//
//  Created by chentao on 15/11/12.
//  Copyright © 2015年 gof. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppUser.h"
#import "UserService.h"
#import "GoodService.h"
#import "StringTool.h"

@interface shoppingTests : XCTestCase

@end

@implementation shoppingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - 用户相关服务测试

- (void)testRemoveZeroTest
{
    [StringTool removeRedundantZero:0.987000];
}

@end
