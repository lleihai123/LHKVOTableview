//
//  CellModel.h
//  LHKVO
//
//  Created by leihai on 16/8/25.
//  Copyright © 2016年 雷海. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class LHUITableViewCell;
@interface CellModel : NSObject
@property (nonatomic,weak) UITableView* tableView;
@property (nonatomic,strong) NSIndexPath* indexPath;
@property (nonatomic,weak) LHUITableViewCell *cell;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) NSString *cellModelID;

-(void)updateUi;
-(void)updateHeight;
@end
