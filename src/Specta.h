#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

//! Project version number for Specta.
FOUNDATION_EXPORT double SpectaVersionNumber;

//! Project version string for Specta.
FOUNDATION_EXPORT const unsigned char SpectaVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Specta/PublicHeader.h>

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 1100 || __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
  #define _SPT_XCODE6
#endif

#import <Specta/SpectaDSL.h>
#import <Specta/SPTTestCase.h>
#import <Specta/SPTSharedExampleGroups.h>
#import <Specta/SPTAssertions.h>
