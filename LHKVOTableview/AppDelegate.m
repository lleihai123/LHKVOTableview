//
//  AppDelegate.m
//  StickFigureSecond
//
//  Created by dev_lei on 13-4-15.
//  Copyright (c) 2013年 dev_lei. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "LHUITableViewViewController.h"
#import "ViewController.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
