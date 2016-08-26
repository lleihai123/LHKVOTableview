//
//  CellModel.m
//  LHKVO
//
//  Created by leihai on 16/8/25.
//  Copyright © 2016年 雷海. All rights reserved.
//

#import "CellModel.h"
#import "LHUITableViewCell.h"
@implementation CellModel
-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}
-(void)updateUi{
    if (self.cell) {
        self.cell.model = self;
    }
}
-(void)updateHeight{
    self.height -= 10 ;
}
@end
