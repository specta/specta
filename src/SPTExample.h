#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@class SPTSenTestCase;

@interface SPTExample : NSObject {
  NSString *_name;
  id _block;
  BOOL _pending;
  SPTSenTestCase *_testCase;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) id block;
@property (nonatomic) BOOL pending;
@property (nonatomic, assign) SPTSenTestCase *testCase;

- (id)initWithName:(NSString *)name block:(id)block;

@end

