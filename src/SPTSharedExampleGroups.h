#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@class
  SPTExampleGroup
;

@interface SPTSharedExampleGroups : NSObject

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(void (^)(NSDictionary * (^data)(void)))block exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (void (^)(NSDictionary * (^data)(void)))sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (void)defineSharedExampleGroups;

@end

