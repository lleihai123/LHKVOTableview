//
//  ViewController.m
//  LHKVO
//
//  Created by leihai on 16/7/7.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import "LHTest3View.h"
#import "CellModel.h"
#import "NSObject+LHKVO.h"
#import "LHUITableViewCell.h"
@implementation LHTest3View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, self.model.height)];
    self.btn.backgroundColor = [UIColor brownColor];
    
    [self.btn setTitle:self.model.cellModelID forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    [self addKVO];
}
-(void)change{
    //会清理mode的kvo,但不会影响cell与model的kvo
    CellModel*model = self.model;
    if (arc4random()%2) {
        model.cellModelID = [NSString stringWithFormat:@"%ld",(long)([model.cellModelID integerValue]%1000+(arc4random()%9 +1 )*1000)];
        [model updateUi];//更新cell的ui
    }else{
        [model updateHeight];//重新loadcell
    }
    [self addKVO];
}

-(void)addKVO{
    __weak __typeof(self)weakself= self;
    [self.model LHaddObserver:@"cellModelID" withBlock:^{
        [weakself.btn setTitle:weakself.model.cellModelID forState:UIControlStateNormal];
    }];
//    [self.model LHaddObserver:@"height" withBlock:^{//会覆盖cel高度的重新载入
        if (weakself) {
            CGRect frame = weakself.btn.frame;
            frame.size.height = weakself.model.height;
            weakself.btn.frame = frame;
        }
//    }];
}


-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}



@end
