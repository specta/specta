#import <XCTest/XCTest.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"

#define RunSpec(TestClass) RunSpecClass([TestClass class])

XCTestSuiteRun *RunSpecClass(Class testClass);

#define SPTAssert(expression)            XCTAssert((expression), @"")
#define SPTAssertTrue(expression)        XCTAssertTrue((expression), @"")
#define SPTAssertFalse(expression)       XCTAssertFalse((expression), @"")
#define SPTAssertNil(a1)                 XCTAssertNil((a1), @"")
#define SPTAssertNotNil(a1)              XCTAssertNil((a1), @"")
#define SPTAssertEqual(a1, a2)           XCTAssert((a1) == (a2), @"")
#define SPTAssertEqualObjects(a1, a2)    XCTAssertEqualObjects((a1), (a2), @"")
#define SPTAssertNotEqual(a1, a2)        XCTAssert((a1) != (a2), @"")
#define SPTAssertNotEqualObjects(a1, a2) XCTAssertNotEqualObjects((a1), (a2), @"")
