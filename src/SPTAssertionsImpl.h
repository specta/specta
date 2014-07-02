//
// Copyright (c) 2013-2014 Apple Inc. All rights reserved.
//
// Copyright (c) 1997-2005, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the following license:
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// (1) Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// (2) Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS''
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL Sente SA OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
// OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Note: this license is equivalent to the FreeBSD license.
//
// This notice may not be removed from this file.

#import <XCTest/XCTestAssertionsImpl.h>

// added @try/@catch block to make sure failures get handled by Specta even if exception raised is uncatchable (e.g. in gcd block)
#define _SPTRegisterFailure(test, condition, format...) \
({ \
    @try { \
        _XCTFailureHandler((id)test, YES, __FILE__, __LINE__, condition, @"" format); \
    } @catch(NSException *e) { \
        [test spt_handleException:e];\
    } \
})

#pragma mark -

#define _SPTPrimitiveFail(test, format...) \
({ \
    _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Fail, 0), format); \
})

#define _SPTPrimitiveAssertNil(test, expression, expressionStr, format...) \
({ \
    @try { \
        id expressionValue = (expression); \
        if (expressionValue != nil) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Nil, 0, expressionStr, expressionValue), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Nil, 1, expressionStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Nil, 2, expressionStr), format); \
    } \
})

#define _SPTPrimitiveAssertNotNil(test, expression, expressionStr, format...) \
({ \
    @try { \
        id expressionValue = (expression); \
        if (expressionValue == nil) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotNil, 0, expressionStr), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotNil, 1, expressionStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotNil, 2, expressionStr), format); \
    } \
})

#define _SPTPrimitiveAssertTrue(test, expression, expressionStr, format...) \
({ \
    @try { \
        BOOL expressionValue = !!(expression); \
        if (!expressionValue) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_True, 0, expressionStr), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_True, 1, expressionStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_True, 2, expressionStr), format); \
    } \
})

#define _SPTPrimitiveAssertFalse(test, expression, expressionStr, format...) \
({ \
    @try { \
        BOOL expressionValue = !!(expression); \
        if (expressionValue) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_False, 0, expressionStr), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_False, 1, expressionStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_False, 2, expressionStr), format); \
    } \
})

#define _SPTPrimitiveAssertEqualObjects(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        id expressionValue1 = (expression1); \
        id expressionValue2 = (expression2); \
        if ((expressionValue1 != expressionValue2) && ![expressionValue1 isEqual:expressionValue2]) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_EqualObjects, 0, expressionStr1, expressionStr2, expressionValue1, expressionValue2), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_EqualObjects, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_EqualObjects, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertNotEqualObjects(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        id expressionValue1 = (expression1); \
        id expressionValue2 = (expression2); \
        if ((expressionValue1 == expressionValue2) || [expressionValue1 isEqual:expressionValue2]) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqualObjects, 0, expressionStr1, expressionStr2, expressionValue1, expressionValue2), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqualObjects, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqualObjects, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertEqual(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        if (expressionValue1 != expressionValue2) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Equal, 0, expressionStr1, expressionStr2, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Equal, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Equal, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertNotEqual(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        if (expressionValue1 == expressionValue2) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqual, 0, expressionStr1, expressionStr2, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqual, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqual, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertEqualWithAccuracy(test, expression1, expressionStr1, expression2, expressionStr2, accuracy, accuracyStr, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        __typeof__(accuracy) accuracyValue = (accuracy); \
        if (isnan(expressionValue1) || isnan(expressionValue2) || ((MAX(expressionValue1, expressionValue2) - MIN(expressionValue1, expressionValue2)) > accuracyValue)) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            NSValue *accuracyBox = [NSValue value:&accuracyValue withObjCType:@encode(__typeof__(accuracy))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_EqualWithAccuracy, 0, expressionStr1, expressionStr2, accuracyStr, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2), _XCTDescriptionForValue(accuracyBox)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_EqualWithAccuracy, 1, expressionStr1, expressionStr2, accuracyStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_EqualWithAccuracy, 2, expressionStr1, expressionStr2, accuracyStr), format); \
    } \
})

#define _SPTPrimitiveAssertNotEqualWithAccuracy(test, expression1, expressionStr1, expression2, expressionStr2, accuracy, accuracyStr, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        __typeof__(accuracy) accuracyValue = (accuracy); \
        if (!isnan(expressionValue1) && !isnan(expressionValue2) && ((MAX(expressionValue1, expressionValue2) - MIN(expressionValue1, expressionValue2)) <= accuracyValue)) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            NSValue *accuracyBox = [NSValue value:&accuracyValue withObjCType:@encode(__typeof__(accuracy))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqualWithAccuracy, 0, expressionStr1, expressionStr2, accuracyStr, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2), _XCTDescriptionForValue(accuracyBox)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqualWithAccuracy, 1, expressionStr1, expressionStr2, accuracyStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NotEqualWithAccuracy, 2, expressionStr1, expressionStr2, accuracyStr), format); \
    } \
})

#define _SPTPrimitiveAssertGreaterThan(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        if (expressionValue1 <= expressionValue2) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_GreaterThan, 0, expressionStr1, expressionStr2, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_GreaterThan, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_GreaterThan, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertGreaterThanOrEqual(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        if (expressionValue1 < expressionValue2) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_GreaterThanOrEqual, 0, expressionStr1, expressionStr2, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_GreaterThanOrEqual, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_GreaterThanOrEqual, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertLessThan(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        if (expressionValue1 >= expressionValue2) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_LessThan, 0, expressionStr1, expressionStr2, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_LessThan, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_LessThan, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertLessThanOrEqual(test, expression1, expressionStr1, expression2, expressionStr2, format...) \
({ \
    @try { \
        __typeof__(expression1) expressionValue1 = (expression1); \
        __typeof__(expression2) expressionValue2 = (expression2); \
        if (expressionValue1 > expressionValue2) { \
            NSValue *expressionBox1 = [NSValue value:&expressionValue1 withObjCType:@encode(__typeof__(expression1))]; \
            NSValue *expressionBox2 = [NSValue value:&expressionValue2 withObjCType:@encode(__typeof__(expression2))]; \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_LessThanOrEqual, 0, expressionStr1, expressionStr2, _XCTDescriptionForValue(expressionBox1), _XCTDescriptionForValue(expressionBox2)), format); \
        } \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_LessThanOrEqual, 1, expressionStr1, expressionStr2, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_LessThanOrEqual, 2, expressionStr1, expressionStr2), format); \
    } \
})

#define _SPTPrimitiveAssertThrows(test, expression, expressionStr, format...) \
({ \
    BOOL __didThrow = NO; \
    @try { \
        (expression); \
    } \
    @catch (...) { \
        __didThrow = YES; \
    } \
    if (!__didThrow) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_Throws, 0, expressionStr), format); \
    } \
})

#define _SPTPrimitiveAssertThrowsSpecific(test, expression, expressionStr, exception_class, format...) \
({ \
    BOOL __didThrow = NO; \
    @try { \
        (expression); \
    } \
    @catch (exception_class *exception) { \
        __didThrow = YES; \
    } \
    @catch (NSException *exception) { \
        __didThrow = YES; \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecific, 0, expressionStr, @#exception_class, [exception class], [exception reason]), format); \
    } \
    @catch (...) { \
        __didThrow = YES; \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecific, 1, expressionStr, @#exception_class), format); \
    } \
    if (!__didThrow) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecific, 2, expressionStr, @#exception_class), format); \
    } \
})

#define _SPTPrimitiveAssertThrowsSpecificNamed(test, expression, expressionStr, exception_class, exception_name, format...) \
({ \
    BOOL __didThrow = NO; \
    @try { \
        (expression); \
    } \
    @catch (exception_class *exception) { \
        __didThrow = YES; \
        if (![exception_name isEqualToString:[exception name]]) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecificNamed, 0, expressionStr, @#exception_class, exception_name, [exception class], [exception name], [exception reason]), format); \
        } \
    } \
    @catch (NSException *exception) { \
        __didThrow = YES; \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecificNamed, 1, expressionStr, @#exception_class, exception_name, [exception class], [exception name], [exception reason]), format); \
    } \
    @catch (...) { \
        __didThrow = YES; \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecificNamed, 2, expressionStr, @#exception_class, exception_name), format); \
    } \
    if (!__didThrow) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_ThrowsSpecificNamed, 3, expressionStr, @#exception_class, exception_name), format); \
    } \
})

#define _SPTPrimitiveAssertNoThrow(test, expression, expressionStr, format...) \
({ \
    @try { \
        (expression); \
    } \
    @catch (NSException *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NoThrow, 0, expressionStr, [exception reason]), format); \
    } \
    @catch (...) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NoThrow, 1, expressionStr), format); \
    } \
})

#define _SPTPrimitiveAssertNoThrowSpecific(test, expression, expressionStr, exception_class, format...) \
({ \
    @try { \
        (expression); \
    } \
    @catch (exception_class *exception) { \
        _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NoThrowSpecific, 0, expressionStr, @#exception_class, [exception class], [exception reason]), format); \
    } \
    @catch (...) { \
        ; \
    } \
})

#define _SPTPrimitiveAssertNoThrowSpecificNamed(test, expression, expressionStr, exception_class, exception_name, format...) \
({ \
    @try { \
        (expression); \
    } \
    @catch (exception_class *exception) { \
        if ([exception_name isEqualToString:[exception name]]) { \
            _SPTRegisterFailure(test, _XCTFailureDescription(_XCTAssertion_NoThrowSpecificNamed, 0, expressionStr, @#exception_class, exception_name, [exception class], [exception name], [exception reason]), format); \
        } \
    } \
    @catch (...) { \
        ; \
    } \
})
