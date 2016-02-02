//
//  ViewController.m
//  不等高cell demo
//
//  Created by locojoy on 16/2/2.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import "ViewController.h"
#import "FCCustomCell.h"
#import "FCCellModel.h"
/*
- 非等高的cell(重点)
- 在模型中增加一个cellHeight属性，用来存放对应cell的高度
- 在cell的模型属性set方法中调用[self layoutIfNeed]方法强制布局，然后计算出模型的cellheight属性值
- 在控制器中实现tableView:estimatedHeightForRowAtIndexPath:方法，返回一个估计高度，比如200
- 在控制器中实现tableView:heightForRowAtIndexPath:方法，返回cell的真实高度（模型中的cellHeight属性）
*/

static NSString *reuse = @"reusecell";


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView            *tableView;
@property (nonatomic,strong) NSMutableArray         *dataSource;
@property (nonatomic,strong) NSMutableDictionary    *cellHeightDict;
@property (nonatomic,strong) UIView                 *headView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"不等高Cell";
    [self.view addSubview:self.tableView];
    
    //注册某个标识对应 的cell类型
    [self.tableView registerClass:[FCCustomCell class] forCellReuseIdentifier:reuse];
    self.tableView.tableHeaderView = self.headView;
    [self.tableView reloadData];

}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 100);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        // 加载plist中的字典数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
        NSArray *contentArray = [NSArray arrayWithContentsOfFile:path];
        
         // 字典数组 -> 模型数组
        for (NSDictionary *dict in contentArray) {
            FCCellModel *model = [FCCellModel modelWithDict:dict];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}
- (UIView *)headView{
    if (!_headView) {
        FCCompnayInfoModel *model = [[FCCompnayInfoModel alloc]init];
        model.compnayName = @"北京乐动卓越科技有限公司";
        model.fax = @"010-12321423";
        model.telephone = @"13911216523";
        model.networkAddress = @"http://www.sohu.com";
        
        _headView = [[FCCompanyInfoCell alloc]initCellWithModel:model];
        _headView.backgroundColor = [UIColor lightGrayColor];
        _headView.frame = CGRectMake(0, 0, kScreenW, model.cellHeight);
    }
    return _headView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellForRowAtIndexPath");
    FCCustomCell *cell = (FCCustomCell *)[tableView dequeueReusableCellWithIdentifier:reuse];
    cell.cellModel = self.dataSource[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"heightForRowAtIndexPath-- %d -- %d",indexPath.section,indexPath.row );
    FCCellModel *model = self.dataSource[indexPath.row];
    
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
