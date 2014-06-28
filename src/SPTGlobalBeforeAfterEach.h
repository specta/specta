#import <Foundation/Foundation.h>

@protocol SPTGlobalBeforeAfterEach <NSObject>

@required
+ (void)beforeEach;
+ (void)afterEach;

@end
