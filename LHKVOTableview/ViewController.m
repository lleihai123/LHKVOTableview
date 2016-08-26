//
//  ViewController.m
//  LHKVO
//
//  Created by leihai on 16/7/7.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+LHKVO.h"
#import "LHUITableViewViewController.h"
@interface ViewController ()

@end

@implementation LHObservedObject
-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)push{
    LHUITableViewViewController*viewController = [[LHUITableViewViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LHObservedObject*object = [[LHObservedObject alloc]init];
    
    __weak __typeof(LHObservedObject*)weakobject= object;
    
    [object LHaddObserver:@"num" withBlock:^{
        NSLog(@"num");
        weakobject.observedNum = @(1);
    }];
    [object LHaddObserver:@"observedNum" withBlock:^{
        NSLog(@"observedNum");
    }];
    [object LHaddObserver:@"printBlock" withBlock:^{
        NSLog(@"printBlock");
    }];
    object.num = 0;
    object.observedNum = @(1);
    object.printBlock = ^(){};
}
@end
