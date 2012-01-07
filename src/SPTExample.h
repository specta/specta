#import <Foundation/Foundation.h>
#import "SPTSupport.h"

@interface SPTExample : NSObject {
  NSString *_name;
  SPTVoidBlock _block;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) SPTVoidBlock block;

- (id)initWithName:(NSString *)name block:(SPTVoidBlock)block;

@end

