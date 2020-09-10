//
//  MappIntelligenceWatchOS.h
//  MappIntelligenceWatchOS
//
//  Created by Stefan Stevanovic on 3/24/20.
//  Copyright © 2020 Mapp Digital US, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageProperties.h"

typedef NS_ENUM(NSInteger, logWatchOSLevel) {
  allWatchOSLogs = 1,     // All logs of the above.
  debugWatchOSLogs = 2,   // The lowest priority that you would normally log, and purely
               // informational in nature.
  warningWatchOSLogs = 3, // Something is missing and might fail if not corrected
  errorWatchOSLogs = 4,   // Something has failed.
  faultWatchOSLogs = 5,   // A failure in a key system.
  infoWatchOSLogs = 6, // Informational logs for updating configuration or migrating from
            // older versions of the library.
  noneOfWatchOSLogs = 7  // None of the logs.
};
@interface MappIntelligenceWatchOS : NSObject

@property (nonatomic, readwrite) NSTimeInterval requestTimeout;
@property (nonatomic, readwrite) logWatchOSLevel logLevelWatchOS;
/**
 MappIntelignece instance
 @brief Method to get a singleton instance of MappIntelligence
 <pre><code>
 MappIntelligenceWatchOS *mappIntelligenceWatchOS = [MappIntelligenceWatchOS shared];
 </code></pre>
 @return MappIntelligence an Instance Type of MappIntelligence.
 */
+ (nullable instancetype)shared;

/**
@brief Method to initialize tracking. Please specify your track domain and trackID.
@param trackIDs - Array of your trackIDs. The information can be provided by your account manager.
@param trackDomain - String value of your track domain. The information can be provided by your account manager.
<pre><code>
MappIntelligenceWatchOS.shared()?.initWithConfiguration([12345678, 8783291721], onTrackdomain: "www.mappIntelligence-trackDomain.com")
</code></pre>
*/
- (void)initWithConfiguration:(NSArray *_Nonnull)trackIDs
                    onTrackdomain:(NSString *_Nonnull)trackDomain;

/**
@brief Method to track additional page information.
@param name - custom page name.
@param properties - properties can contain details, groups and seach term.
<pre><code>
 let customName = "the custom name of page"
 let params:NSMutableDictionary = [20: ["cp20Override", "cp21Override", "cp22Override"]]
 let categories:NSMutableDictionary = [10: ["test"]]
 let searchTerm = "testSearchTerm"
 
 MappIntelligenceWatchOS.shared()?.trackPage(withName: customName, andWith: PageProperties(pageParams: params, andWithPageCategory: categories, andWithSearch: searchTerm))
</code></pre>
@return Error that can happen while tracking. Returns nil if no error was detected.
*/
- (NSError *_Nullable)trackPageWithName: (NSString *_Nonnull) name andWithPageProperties:(PageProperties  *_Nullable)properties;

- (void)reset;

@end
