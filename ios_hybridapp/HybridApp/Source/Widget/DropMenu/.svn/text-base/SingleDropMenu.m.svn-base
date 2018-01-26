//
//  DropMenu.m
//  SalesManager
//
//  Created by liuxueyan on 15-5-19.
//  Copyright (c) 2015年 liu xueyan. All rights reserved.
//

#import "SingleDropMenu.h"
#import "DeviceConstant.h"
#import "JSmodel.h"

@implementation SingleDropMenu


-(void)initMenu{
    
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tag = 1;
    _listView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_listView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38.f;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    NSString *title = nil;
    NSObject* obj = [_dataList objectAtIndex:indexPath.row];
    if ([obj isKindOfClass: JSmodel.class]){
        JSmodel *model = [_dataList objectAtIndex:indexPath.row];
        title = model.fieldLabel;
    }
    cell.textLabel.text = title;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *oldIndex = [tableView indexPathForSelectedRow];
    
    [tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
   
  //  [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(selectedSingleDropMenu:)]) {
        [_delegate selectedSingleDropMenu:_dataList[indexPath.row]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
