#import "TestHelper.h"
#import <TargetConditionals.h>

SpecBegin(_CheckDealloc)

describe(@"group", ^{
  it(@"example 1", ^{
    NSObject *obj = [NSObject new];
    spt_check_dealloc_(obj);
  });
});

SpecEnd


