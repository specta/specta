#import <XCTest/XCTest.h>
#import <Specta/Specta.h>

@interface XCTestObservationCenter

+ (id)sharedObservationCenter;
- (void)_suspendObservationForBlock:(void (^)(void))block;

@end

#define RunSpec(TestClass) RunSpecClass([TestClass class])

XCTestSuiteRun *RunSpecClass(Class testClass);

#define assertTrue(expression)        SPTAssertTrue((expression), @"")
#define assertFalse(expression)       SPTAssertFalse((expression), @"")
#define assertNil(a1)                 SPTAssertNil((a1), @"")
#define assertNotNil(a1)              SPTAssertNil((a1), @"")
#define assertEqual(a1, a2)           SPTAssert((a1) == (a2), @"")
#define assertEqualObjects(a1, a2)    SPTAssertEqualObjects((a1), (a2), @"")
#define assertNotEqual(a1, a2)        SPTAssert((a1) != (a2), @"")
#define assertNotEqualObjects(a1, a2) SPTAssertNotEqualObjects((a1), (a2), @"")