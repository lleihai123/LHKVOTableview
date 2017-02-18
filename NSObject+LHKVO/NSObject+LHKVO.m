//
//  NSObject+LHKVO.m
//  LHKVO
//
//  Copyright © 2016年 雷海. All rights reserved.]
//
#import "NSObject+LHKVO.h"
#import <objc/runtime.h>
#define objectAdress  ([NSString stringWithFormat:@"%ld",(long)((NSInteger)self)])
@interface NSObjectLHKVOManage:NSObject
@property (nonatomic, strong) NSMutableDictionary *kvoMumdict;
+ (instancetype)sharedManager;
@end

@implementation NSObjectLHKVOManage
+ (instancetype)sharedManager
{
    static NSObjectLHKVOManage *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
        _sharedManager.kvoMumdict = [NSMutableDictionary dictionary];
    });
    return _sharedManager;
}
@end

@implementation NSObject (LHKVO)
+ (void)load{
    NSLog(@"load:%@",[self class]);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"dealloc"];
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"sd_" stringByAppendingString:selString];
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

-(void)LHaddObserver: (NSString *)key withBlock: (LHHandler)observedHandler{
    @synchronized(self){
        NSMutableDictionary*dict =  [[NSObjectLHKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
        if (!dict) {
            dict = [NSMutableDictionary new];
        }else{
            if ([dict objectForKey:key]) {
                [self LHRemoveObserver:key];
            }
        }
        [dict setObject:observedHandler forKey:key];
        [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [[NSObjectLHKVOManage sharedManager].kvoMumdict setObject:dict forKey:objectAdress];
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSMutableDictionary*dict =  [[NSObjectLHKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
    if (dict) {
        LHHandler hander = [dict objectForKey:keyPath];
        if(hander){
            hander();
        }
    }
}

- (void)LHRemoveObserver: (NSString *)key{
    @try {
        
        NSMutableDictionary*dict =  [[NSObjectLHKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
        [dict removeObjectForKey:key];
        [self removeObserver:self forKeyPath:key];
    }
    @catch (NSException *exception) {
        NSLog(@"多次删除了");
    }
    
}

- (void)LHRemoveAllObserver{
    NSMutableDictionary*dict =  [[NSObjectLHKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
    if (dict) {
        NSArray*keys = [dict allKeys];
        for (NSString*key in keys) {
            [self LHRemoveObserver:key];
            NSLog(@"dealloc_key:%@",key);
        }
    }
    [[NSObjectLHKVOManage sharedManager].kvoMumdict  removeObjectForKey:objectAdress];
}
-(void)sd_dealloc{
    NSMutableDictionary*dict =  [[NSObjectLHKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
    if (dict) {
        [[NSObjectLHKVOManage sharedManager].kvoMumdict  removeObjectForKey:objectAdress];
        @synchronized(self){
            NSArray*keys = [dict allKeys];
            for (NSString*key in keys) {
                [self LHRemoveObserver:key];
                NSLog(@"dealloc_key:%@",key);
            }
        }
    }
    [self sd_dealloc];
}
@end
