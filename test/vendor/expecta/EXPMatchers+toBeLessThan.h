#import "Expecta.h"

EXPMatcherInterface(_toBeLessThan, (id expected));
EXPMatcherInterface(toBeLessThan, (id expected));

#define toBeLessThan(expected) _toBeLessThan(EXPObjectify((expected)))