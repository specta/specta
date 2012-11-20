#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@class
  SPTExampleGroup
;

@interface SPTSharedExampleGroups : NSObject

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(id)block exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (id)sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (void)defineSharedExampleGroups;

@end

