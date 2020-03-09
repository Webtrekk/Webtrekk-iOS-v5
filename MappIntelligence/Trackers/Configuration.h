//
//  Configuration.h
//  MappIntelligenceSDK
//
//  Created by Stefan Stevanovic on 3/7/20.
//  Copyright © 2020 Stefan Stevanovic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Configuration : NSObject

/// url for remote tracking server
@property NSURL *serverUrl;

/// Id which identify customer
@property NSString *MappIntelligenceId;

@end

NS_ASSUME_NONNULL_END
