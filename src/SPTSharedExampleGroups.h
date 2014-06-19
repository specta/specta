#import <Foundation/Foundation.h>
#import "SpectaTypes.h"
#import "XCTestPrivate.h"

@class
  SPTExampleGroup
;

@interface SPTSharedExampleGroups : NSObject

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(SPTDictionaryBlock)block exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (SPTDictionaryBlock)sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (void)defineSharedExampleGroups;

+ (void)recordFailureWithDescription:(NSString *)description inFile:(NSString *)filename atLine:(NSUInteger)lineNumber expected:(BOOL)expected;

+ (void)_recordUnexpectedFailureWithDescription:(NSString *)description exception:(NSException *)exception;

#ifdef _SPT_XCODE6
+ (_XCTestCaseImplementation *)internalImplementation;
#endif

@end

