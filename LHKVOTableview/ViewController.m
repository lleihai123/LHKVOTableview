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
#import "LHTest3ViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray*muarray;
@property (nonatomic,strong) UITableView *lhtableView;
@end

@implementation LHObservedObject
-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.muarray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 3 ; i++) {
        [self.muarray addObject:[NSString stringWithFormat:@"test_%ld",(long)i]];
    }
    
    self.lhtableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.lhtableView.delegate = self;
    self.lhtableView.dataSource = self;
    [self.view addSubview:self.lhtableView];
    [self.lhtableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LHUITableViewCell"];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"LHUITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.muarray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark- tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *function = [self.muarray objectAtIndex:indexPath.row];
    
    SEL action =  NSSelectorFromString(function);
    if ([self respondsToSelector:action]) {
        [self performSelector:action];
    }
}

-(void)test_1{
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

-(void)test_2{
    LHUITableViewViewController*viewController = [[LHUITableViewViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)test_3{
    LHTest3ViewController*viewController = [[LHTest3ViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];

}

@end
