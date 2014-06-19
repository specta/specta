#import <XCTest/XCTest.h>
#import "XCTestPrivate.h"

#ifdef _SPT_XCODE6
  #define SPTXCTestObserverClass _XCTestDriverTestObserver
#else
  #define SPTXCTestObserverClass XCTestObserver
#endif

@interface SPTXCTestObserverClass (Specta)

- (void)spt_pauseObservationInBlock:(void (^)(void))block;

@end
