//
//  MIMediaProperties.m
//  MappIntelligenceSDK
//
//  Created by Miroljub Stoilkovic on 27/12/2020.
//  Copyright © 2020 Mapp Digital US, LLC. All rights reserved.
//

#import "MIMediaProperties.h"

@implementation MIMediaProperties

- (instancetype)initWith: (NSString *) name action: (NSString *)action postion: (NSTimeInterval) position duration: (NSTimeInterval) duration {
    self = [super init];
    if (self) {
        _name = name;
        _action = action;
        _position = position;
        _duration = duration;
    }
    return  self;
}


-(NSMutableArray<NSURLQueryItem*>*)asQueryItems {
    NSMutableArray<NSURLQueryItem*>* items = [[NSMutableArray alloc] init];
    
    if (_customProperties) {
        _customProperties = [self filterCustomDict:_customProperties];
        for(NSNumber* key in _customProperties) {
            [items addObject:[[NSURLQueryItem alloc] initWithName:[NSString stringWithFormat:@"mg%@",key] value: _customProperties[key]]];
        }
    }
    
    if (_name) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mi" value:_name]];
    }
    if (_action) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mk" value:_action]];
    }
    if (_position) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mt1" value: [NSString stringWithFormat:@"%f", _position]]];
    }
    if (_duration) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mt2" value: [NSString stringWithFormat:@"%f",_duration]]];
    }
    NSString *muted = (_soundIsMuted) ? @"1": @"0";
    
    return items;
}

- (NSDictionary<NSNumber* ,NSString*> *) filterCustomDict: (NSDictionary<NSNumber* ,NSString*> *) dict{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSNumber *idx in dict) {
        if (idx.intValue > 0) {
            [result setObject:dict[idx] forKey:idx];
        }
    }
    return result;
}
@end
