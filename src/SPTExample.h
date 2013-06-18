#import <Foundation/Foundation.h>
#import "SpectaTypes.h"

@interface SPTExample : NSObject {
  NSString *_name;
  id _block;
  BOOL _pending;
  BOOL _focused;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) id block;
@property (nonatomic) BOOL pending;
@property (nonatomic, getter = isFocused) BOOL focused;

- (id)initWithName:(NSString *)name block:(id)block;

@end

