//
//  DCMeViewController.m
//  Tomous_Tool
//
//  Created by Tomous on 2020/11/19.
//

#import "DCMeViewController.h"
#import "DCMeCell.h"
#import "DCMeFooterView.h"
#import "DCSettingViewController.h"

@interface DCMeViewController ()

@end

@implementation DCMeViewController

-(instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupNav];
}
- (void)setupTable {
    self.tableView.backgroundColor = DCCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = DCMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(DCMargin - 35, 0, 0, 0);
    
    // 设置footer
    self.tableView.tableFooterView = [[DCMeFooterView alloc]init];
}

- (void)setupNav {
    
    self.navigationItem.title = @"我的";
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *seetingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(seetingClick)];
    self.navigationItem.rightBarButtonItems = @[seetingItem, moonItem];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    DCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DCMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    }else {
        cell.textLabel.text = @"离线下载";
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    return cell;
}
-(void)moonClick
{
    DCLogFunc;
}
-(void)seetingClick
{
    DCLogFunc;
    DCSettingViewController *setVC = [[DCSettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
