#import <Foundation/Foundation.h>
#import <Specta/SpectaTypes.h>

@class _XCTestCaseImplementation;

@class SPTExampleGroup;

@interface SPTSharedExampleGroups : NSObject

+ (void)addSharedExampleGroupWithName:(NSString *)name block:(SPTDictionaryBlock)block exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (SPTDictionaryBlock)sharedExampleGroupWithName:(NSString *)name exampleGroup:(SPTExampleGroup *)exampleGroup;
+ (void)defineSharedExampleGroups;

+ (void)spt_handleException:(NSException *)exception;
+ (void)recordFailureWithDescription:(NSString *)description inFile:(NSString *)filename atLine:(NSUInteger)lineNumber expected:(BOOL)expected;
+ (void)_recordUnexpectedFailureWithDescription:(NSString *)description exception:(NSException *)exception;

+ (_XCTestCaseImplementation *)internalImplementation;

@end

