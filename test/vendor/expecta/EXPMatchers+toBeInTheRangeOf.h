#import "Expecta.h"

EXPMatcherInterface(_toBeInTheRangeOf, (id expectedLowerBound, id expectedUpperBound));
EXPMatcherInterface(toBeInTheRangeOf, (id expectedLowerBound, id expectedUpperBound));

#define toBeInTheRangeOf(expectedLowerBound, expectedUpperBound) _toBeInTheRangeOf(EXPObjectify((expectedLowerBound)), EXPObjectify((expectedUpperBound)))