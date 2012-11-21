#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@class SPTSenTestCase;

@interface SPTExample : NSObject {
  NSString *_name;
  SPTVoidBlock _block;
  BOOL _pending;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^block)(SPTSenTestCase *);
@property (nonatomic) BOOL pending;

- (id)initWithName:(NSString *)name block:(void (^)(SPTSenTestCase *))block;

@end

