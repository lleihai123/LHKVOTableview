//
//  NSObject+LHKVO.h
//  LHKVO
//
//  Copyright © 2016年 雷海. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^LHHandler) ();
@interface NSObject (LXD_KVO)
- (void)LHaddObserver: (NSString *)key withBlock: (LHHandler)observedHandler;
- (void)LHRemoveAllObserver;
@end