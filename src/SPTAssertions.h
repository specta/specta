// XCTest assertion macros are mirrored here in order to provide a patched _XCTFailureHandler macro (_SPTFailureHandler) without causing "ambiguous expansion of macro" warnings when modules are enabled.

//
// Copyright (c) 2013 Apple Inc. All rights reserved.
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

#import <Specta/SPTAssertionsImpl.h>

/*!
 * @function SPTFail(format...)
 * Generates a failure unconditionally.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTFail(format...) \
    _SPTPrimitiveFail(self, format)

/*!
 * @define SPTAssertNil(expression, format...)
 * Generates a failure when ((\a expression) != nil).
 * @param expression An expression of id type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNil(expression, format...) \
    _SPTPrimitiveAssertNil(self, expression, @#expression, format)

/*!
 * @define SPTAssertNotNil(expression, format...)
 * Generates a failure when ((\a expression) == nil).
 * @param expression An expression of id type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNotNil(expression, format...) \
    _SPTPrimitiveAssertNotNil(self, expression, @#expression, format)

/*!
 * @define SPTAssert(expression, format...)
 * Generates a failure when ((\a expression) == false).
 * @param expression An expression of boolean type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssert(expression, format...) \
    _SPTPrimitiveAssertTrue(self, expression, @#expression, format)

/*!
 * @define SPTAssertTrue(expression, format...)
 * Generates a failure when ((\a expression) == false).
 * @param expression An expression of boolean type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertTrue(expression, format...) \
    _SPTPrimitiveAssertTrue(self, expression, @#expression, format)

/*!
 * @define SPTAssertFalse(expression, format...)
 * Generates a failure when ((\a expression) != false).
 * @param expression An expression of boolean type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertFalse(expression, format...) \
    _SPTPrimitiveAssertFalse(self, expression, @#expression, format)

/*!
 * @define SPTAssertEqualObjects(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) not equal to (\a expression2)).
 * @param expression1 An expression of id type.
 * @param expression2 An expression of id type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertEqualObjects(expression1, expression2, format...) \
    _SPTPrimitiveAssertEqualObjects(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertNotEqualObjects(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) equal to (\a expression2)).
 * @param expression1 An expression of id type.
 * @param expression2 An expression of id type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNotEqualObjects(expression1, expression2, format...) \
    _SPTPrimitiveAssertNotEqualObjects(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertEqual(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) != (\a expression2)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertEqual(expression1, expression2, format...) \
    _SPTPrimitiveAssertEqual(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertNotEqual(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) == (\a expression2)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNotEqual(expression1, expression2, format...) \
    _SPTPrimitiveAssertNotEqual(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertEqualWithAccuracy(expression1, expression2, accuracy, format...)
 * Generates a failure when (difference between (\a expression1) and (\a expression2) is > (\a accuracy))).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param accuracy An expression of C scalar type describing the maximum difference between \a expression1 and \a expression2 for these values to be considered equal.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertEqualWithAccuracy(expression1, expression2, accuracy, format...) \
    _SPTPrimitiveAssertEqualWithAccuracy(self, expression1, @#expression1, expression2, @#expression2, accuracy, @#accuracy, format)

/*!
 * @define SPTAssertNotEqualWithAccuracy(expression1, expression2, accuracy, format...)
 * Generates a failure when (difference between (\a expression1) and (\a expression2) is <= (\a accuracy)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param accuracy An expression of C scalar type describing the maximum difference between \a expression1 and \a expression2 for these values to be considered equal.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNotEqualWithAccuracy(expression1, expression2, accuracy, format...) \
    _SPTPrimitiveAssertNotEqualWithAccuracy(self, expression1, @#expression1, expression2, @#expression2, accuracy, @#accuracy, format)

/*!
 * @define SPTAssertGreaterThan(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) <= (\a expression2)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertGreaterThan(expression1, expression2, format...) \
    _SPTPrimitiveAssertGreaterThan(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertGreaterThanOrEqual(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) < (\a expression2)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertGreaterThanOrEqual(expression1, expression2, format...) \
    _SPTPrimitiveAssertGreaterThanOrEqual(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertLessThan(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) >= (\a expression2)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertLessThan(expression1, expression2, format...) \
    _SPTPrimitiveAssertLessThan(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertLessThanOrEqual(expression1, expression2, format...)
 * Generates a failure when ((\a expression1) > (\a expression2)).
 * @param expression1 An expression of C scalar type.
 * @param expression2 An expression of C scalar type.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertLessThanOrEqual(expression1, expression2, format...) \
    _SPTPrimitiveAssertLessThanOrEqual(self, expression1, @#expression1, expression2, @#expression2, format)

/*!
 * @define SPTAssertThrows(expression, format...)
 * Generates a failure when ((\a expression) does not throw).
 * @param expression An expression.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertThrows(expression, format...) \
    _SPTPrimitiveAssertThrows(self, expression, @#expression, format)

/*!
 * @define SPTAssertThrowsSpecific(expression, exception_class, format...)
 * Generates a failure when ((\a expression) does not throw \a exception_class).
 * @param expression An expression.
 * @param exception_class The class of the exception. Must be NSException, or a subclass of NSException.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertThrowsSpecific(expression, exception_class, format...) \
    _SPTPrimitiveAssertThrowsSpecific(self, expression, @#expression, exception_class, format)

/*!
 * @define SPTAssertThrowsSpecificNamed(expression, exception_class, exception_name, format...)
 * Generates a failure when ((\a expression) does not throw \a exception_class with \a exception_name).
 * @param expression An expression.
 * @param exception_class The class of the exception. Must be NSException, or a subclass of NSException.
 * @param exception_name The name of the exception.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertThrowsSpecificNamed(expression, exception_class, exception_name, format...) \
    _SPTPrimitiveAssertThrowsSpecificNamed(self, expression, @#expression, exception_class, exception_name, format)

/*!
 * @define SPTAssertNoThrow(expression, format...)
 * Generates a failure when ((\a expression) throws).
 * @param expression An expression.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNoThrow(expression, format...) \
    _SPTPrimitiveAssertNoThrow(self, expression, @#expression, format)

/*!
 * @define SPTAssertNoThrowSpecific(expression, exception_class, format...)
 * Generates a failure when ((\a expression) throws \a exception_class).
 * @param expression An expression.
 * @param exception_class The class of the exception. Must be NSException, or a subclass of NSException.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNoThrowSpecific(expression, exception_class, format...) \
    _SPTPrimitiveAssertNoThrowSpecific(self, expression, @#expression, exception_class, format)

/*!
 * @define SPTAssertNoThrowSpecificNamed(expression, exception_class, exception_name, format...)
 * Generates a failure when ((\a expression) throws \a exception_class with \a exception_name).
 * @param expression An expression.
 * @param exception_class The class of the exception. Must be NSException, or a subclass of NSException.
 * @param exception_name The name of the exception.
 * @param format An optional supplementary description of the failure, with printf-style placeholders for additional arguments.
*/
#define SPTAssertNoThrowSpecificNamed(expression, exception_class, exception_name, format...) \
    _SPTPrimitiveAssertNoThrowSpecificNamed(self, expression, @#expression, exception_class, exception_name, format)
