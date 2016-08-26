//
//  LHUITableViewCell.m
//  LHKVO
//
//  Created by leihai on 16/8/25.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import "LHUITableViewCell.h"
#import "NSObject+LHKVO.h"
@implementation LHUITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         __weak __typeof(&*self)weakSelf = self;
        [self LHaddObserver:@"model" withBlock:^{
            [weakSelf updateView];
        }];
    }
    return self;
}

-(void)setModel:(CellModel *)model{
    if (!model) {
        return;
    }
    [model LHRemoveAllObserver];//model是公用的所以需要清除kvo
    [_model LHRemoveAllObserver];//清理现在的kvo
    _model = model;
    _model.cell = self;
    //重新注入kvo
    __weak __typeof(&*_model)tmp_model = _model;
    [_model LHaddObserver:@"height" withBlock:^{
        if (tmp_model && tmp_model.indexPath) {
            [tmp_model.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:tmp_model.indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];

}

-(void)clearKvoAndRegisterKvo{
    
}
-(void)updateView{
    self.textLabel.text = self.model.cellModelID;
    NSLog(@"updateView");
}
-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}
@end
