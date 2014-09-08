#import <XCTest/XCTest.h>
#import <Specta/Specta.h>

@interface XCTestObservationCenter

+ (id)sharedObservationCenter;
- (void)_suspendObservationForBlock:(void (^)(void))block;

@end

#define RunSpec(TestClass) RunSpecClass([TestClass class])

XCTestSuiteRun *RunSpecClass(Class testClass);

#define assertTrue(expression)        XCTAssertTrue((expression), @"")
#define assertFalse(expression)       XCTAssertFalse((expression), @"")
#define assertNil(a1)                 XCTAssertNil((a1), @"")
#define assertNotNil(a1)              XCTAssertNil((a1), @"")
#define assertEqual(a1, a2)           XCTAssert((a1) == (a2), @"")
#define assertEqualObjects(a1, a2)    XCTAssertEqualObjects((a1), (a2), @"")
#define assertNotEqual(a1, a2)        XCTAssert((a1) != (a2), @"")
#define assertNotEqualObjects(a1, a2) XCTAssertNotEqualObjects((a1), (a2), @"")