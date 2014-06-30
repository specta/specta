#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

#ifdef _SPT_XCODE6
@class _XCTestCaseImplementation;
#endif

@class SPTExampleGroup;

@interface SPTSharedExampleGroups : NSObject

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(SPTDictionaryBlock)block exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (SPTDictionaryBlock)sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (void)defineSharedExampleGroups;

+ (void)spt_handleException:(NSException *)exception;
+ (void)recordFailureWithDescription:(NSString *)description inFile:(NSString *)filename atLine:(NSUInteger)lineNumber expected:(BOOL)expected;
+ (void)_recordUnexpectedFailureWithDescription:(NSString *)description exception:(NSException *)exception;

#ifdef _SPT_XCODE6
+ (_XCTestCaseImplementation *)internalImplementation;
#endif

@end

