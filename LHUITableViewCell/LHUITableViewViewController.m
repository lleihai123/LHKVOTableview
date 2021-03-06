//
//  ViewController.m
//  LHKVO
//
//  Created by leihai on 16/7/7.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import "LHUITableViewViewController.h"
#import "CellModel.h"
#import "NSObject+LHKVO.h"
#import "LHUITableViewCell.h"


@interface LHUITableViewViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}
@property (nonatomic,strong) UITableView *lhtableView;
@property (nonatomic,strong) NSMutableArray*muarray;
@end
static NSString*LHUITableViewCells = @"LHUITableViewCells";
@implementation LHUITableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.muarray = [NSMutableArray array];
    for (NSInteger i = 0; i <= 50 ; i++) {
        CellModel*model = [[CellModel alloc]init];
        model.cellModelID = [NSString stringWithFormat:@"%ld",(long)i];
        model.height = 100;
        [self.muarray addObject:model];
    }
    self.lhtableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.lhtableView.delegate = self;
    self.lhtableView.dataSource = self;
    [self.view addSubview:self.lhtableView];
    [self.lhtableView registerClass:[LHUITableViewCell class] forCellReuseIdentifier:LHUITableViewCells];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.muarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHUITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:LHUITableViewCells forIndexPath:indexPath];
    cell.model = self.muarray[indexPath.row];
    cell.model.tableView = tableView;
    cell.model.indexPath = indexPath;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel*model = self.muarray[indexPath.row];
    return model.height;
}

#pragma mark- tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellModel*model = self.muarray[indexPath.row];
    if (arc4random()%3) {
        model.cellModelID = [NSString stringWithFormat:@"%ld",(long)([model.cellModelID integerValue]%1000+(arc4random()%9 +1 )*1000)];
        [model updateUi];//更新cell的ui
    }else{
        [model updateHeight];//重新loadcell
    }
    
}
-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}



@end
