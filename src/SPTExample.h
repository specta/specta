#import <Foundation/Foundation.h>
#import "SpectaTypes.h"
#import "SPTExamplegroup.h"

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
@property (nonatomic, retain) SPTExampleGroup *parentGroup;

- (id)initWithName:(NSString *)name block:(id)block parentGroup:(SPTExampleGroup *)parentGroup;

@end

