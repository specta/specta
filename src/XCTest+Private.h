#import <XCTest/XCTest.h>

#ifdef _SPT_XCODE6

@protocol XCTestObservation <NSObject>
@end

@interface _XCTestDriverTestObserver : NSObject <XCTestObservation>

- (void)stopObserving;
- (void)startObserving;

@end

@interface _XCTestCaseImplementation : NSObject
@end

@interface XCTestCase ()

- (_XCTestCaseImplementation *)internalImplementation;

@end

#endif

@interface XCTestCase ()

- (void)_recordUnexpectedFailureWithDescription:(NSString *)description exception:(NSException *)exception;

@end