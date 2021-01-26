//
//  MIMediaParameters.m
//  MappIntelligenceSDK
//
//  Created by Miroljub Stoilkovic on 27/12/2020.
//  Copyright © 2020 Mapp Digital US, LLC. All rights reserved.
//

#import "MIMediaParameters.h"

@implementation MIMediaParameters

- (instancetype)initWith: (NSString *) name action: (NSString *)action position: (NSNumber *) position duration: (NSNumber *) duration {
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
    
    if (_customCategories) {
        _customCategories = [self filterCustomDict:_customCategories];
        for(NSNumber* key in _customCategories) {
            [items addObject:[[NSURLQueryItem alloc] initWithName:[NSString stringWithFormat:@"mg%@",key] value: _customCategories[key]]];
        }
    }
    
    if (_name) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mi" value:_name]];
    }
    if (_action) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mk" value:_action]];
    }
    if (_position) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mt1" value: [NSString stringWithFormat:@"%ld", (long)_position.doubleValue]]];
    }
    if (_duration) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mt2" value: [NSString stringWithFormat:@"%ld",(long)_duration.doubleValue]]];
    }
    if (_soundIsMuted) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"mut" value: _soundIsMuted.stringValue]];
    }
    if (_soundVolume.doubleValue > 0) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"vol" value: _soundVolume.stringValue]];
    }
    if (_bandwith) {
        [items addObject:[[NSURLQueryItem alloc] initWithName:@"bw" value: _bandwith.stringValue]];
    }
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
