//
//  ViewController.m
//  asdkjasdj
//
//  Created by zhangjian on 2018/7/5.
//  Copyright © 2018年 Roadoor. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "WXHeader.h"
#import "RDLoadingView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *name;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RDLoadingView *Loadview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.Loadview = [[RDLoadingView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.Loadview.progress = 0.3;
//    [self.view addSubview:self.Loadview];

    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.header = [WXHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
        });
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableView.footer.state = MJRefreshStateNoMoreData;
            [self.tableView.footer endRefreshing];
            
        });
    }];
    
    [self.view addSubview:self.tableView];
     
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.Loadview.progress = 0.5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

-(UIImage*)getImageFromView:(UIView*)theView{
    
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, 0.0);
    
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
