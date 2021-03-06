//
//  ActionPropertiesTests.m
//  MappIntelligenceTests
//
//  Created by Miroljub Stoilkovic on 09/09/2020.
//  Copyright © 2020 Mapp Digital US, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MITrackerRequest.h"
#import "MIDefaultTracker.h"
#import "MIEventParameters.h"


@interface ActionPropertiesTests : XCTestCase
@property MIEventParameters* actionProperties;
@property NSMutableDictionary* properties;
@property NSString *actionname;
@end

@implementation ActionPropertiesTests

- (void)setUp {
    _properties = [@{@20: @"1 element"} copy];
    _actionname = @"TestAction";
    _actionProperties = [[MIEventParameters alloc] initWithParameters:_properties];
}

- (void)tearDown {
    _properties = nil;
    _actionProperties = nil;
}

- (void)testInitWithNameAndDetails {
    XCTAssertTrue([_actionProperties.parameters isEqualToDictionary:_properties], @"The details from action properties is not same as it is used for creation!");
}

- (void)testAsQueryItemsForRequest {
    //1. create expected query items
    NSMutableArray<NSURLQueryItem*>* expectedItems = [[NSMutableArray alloc] init];
    if (_properties) {
        for(NSString* key in _properties) {
            [expectedItems addObject:[[NSURLQueryItem alloc] initWithName:[NSString stringWithFormat:@"ck%@",key] value: _properties[key]]];
        }
    }

     //3.get resulted list of query items
     NSMutableArray<NSURLQueryItem*>* result = [_actionProperties asQueryItems];
     
     XCTAssertTrue([expectedItems isEqualToArray:result], @"The expected query is not the same as ones from result!");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
