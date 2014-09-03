#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import "SpectaShorthands.h"

@interface XCTestObservationCenter

+ (id)sharedObservationCenter;
- (void)_suspendObservationForBlock:(void (^)(void))block;

@end

#define RunSpec(TestClass) RunSpecClass([TestClass class])

XCTestSuiteRun *RunSpecClass(Class testClass);

#define assertTrue(expr)            SPTAssertTrue((expr), @"expected %@ to be true", @(expr))
#define assertFalse(expr)           SPTAssertFalse((expr), @"expected %@ to be false", @(expr))
#define assertNil(a)                SPTAssertNil((a), @"expected %@ to be nil", a)
#define assertNotNil(a)             SPTAssertNil((a), @"expected %@ not to be nil", a)
#define assertEqual(a, b)           SPTAssert((a) == (b), @"expected %@ to equal %@", @(a), @(b))
#define assertEqualObjects(a, b)    SPTAssertEqualObjects((a), (b), @"expected %@ to equal %@", (a), (b))
#define assertNotEqual(a, b)        SPTAssert((a) != (b), @"expected %@ not to equal %@", @(a), @(b))
#define assertNotEqualObjects(a, b) SPTAssertNotEqualObjects((a), (b), @"expected %@ not to equal %@", (a), (b))