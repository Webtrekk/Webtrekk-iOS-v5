//
//  TrackerRequest.m
//  MappIntelligenceSDK
//
//  Created by Stefan Stevanovic on 2/12/20.
//  Copyright © 2020 Stefan Stevanovic. All rights reserved.
//

#import "TrackerRequest.h"
#import "MappIntelligenceLogger.h"

@interface TrackerRequest ()

@property MappIntelligenceLogger *loger;
@property NSURLSession *urlSession;

@end

@implementation TrackerRequest

- (instancetype)init {
  self = [super init];
  if (self) {
    _loger = [MappIntelligenceLogger shared];
#if !TARGET_OS_WATCH
    _urlSession = [[NSURLSession alloc] init];
#endif
  }
  return self;
}

- (instancetype)initWithEvent:(TrackingEvent *)event
            andWithProperties:(Properties *)properties {
  self = [self init];
  [self setEvent:event];
  [self setProperties:properties];
  return self;
}

- (void)sendRequestWith:(NSURL *)url andCompletition:(nonnull void (^)(NSError * _Nonnull))handler {
  [_loger logObj:[[NSString alloc]
                     initWithFormat:@"Tracking Request: %@", [url absoluteURL]]
      forDescription:kMappIntelligenceLogLevelDescriptionInfo];

  [self createUrlSession];

  [[_urlSession
        dataTaskWithURL:url
      completionHandler:^(NSData *_Nullable data,
                          NSURLResponse *_Nullable response,
                          NSError *_Nullable error) {
        if (error) {
          [self->_loger logObj:[[NSString alloc]
                                   initWithFormat:
                                       @"Error while executing request: %@",
                                       [error description]]
                forDescription:kMappIntelligenceLogLevelDescriptionError];
          return;
        }
        [self->_loger logObj:[[NSString alloc]
                                 initWithFormat:
                                     @"Response from tacking server: %@",
                                     [response description]]
              forDescription:kMappIntelligenceLogLevelDescriptionDebug];
        handler(error);
      }] resume];
}

- (void)createUrlSession {
  NSURLSessionConfiguration *urlSessionConfiguration =
      [NSURLSessionConfiguration ephemeralSessionConfiguration];
  [urlSessionConfiguration
      setHTTPCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];
  [urlSessionConfiguration setHTTPShouldSetCookies:YES];
  [urlSessionConfiguration setURLCache:NULL];
  [urlSessionConfiguration setURLCredentialStorage:NULL];
  [urlSessionConfiguration
      setRequestCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

  _urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfiguration];
  [_urlSession setSessionDescription:@"Mapp Intelligence Tracking"];
}
@end
