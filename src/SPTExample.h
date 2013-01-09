#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@interface SPTExample : NSObject {
  NSString *_name;
  id _block;
  BOOL _pending;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) id block;
@property (nonatomic) BOOL pending;

- (id)initWithName:(NSString *)name block:(id)block;

@end

