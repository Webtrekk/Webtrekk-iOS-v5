//
//  SessionProperties.h
//  MappIntelligenceSDK
//
//  Created by Miroljub Stoilkovic on 11/09/2020.
//  Copyright © 2020 Mapp Digital US, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackerRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface SessionProperties : NSObject
@property (nullable) NSDictionary<NSNumber* ,NSArray<NSString*>*>* properties;
-(instancetype)initWithProperties: (NSDictionary<NSNumber* ,NSArray<NSString*>*>* _Nullable) properties;
-(NSMutableArray<NSURLQueryItem*>*)asQueryItemsFor: (TrackerRequest*)request;
@end

NS_ASSUME_NONNULL_END