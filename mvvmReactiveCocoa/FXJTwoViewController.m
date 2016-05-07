//
//  FXJTwoViewController.m
//  mvvmReactiveCocoa
//
//  Created by myApplePro01 on 16/4/23.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "FXJTwoViewController.h"
#import "TwoCellTableViewCell.h"
#import "TwoViewModel.h"

@interface FXJTwoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray        *dataArr;
@end

@implementation FXJTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    TwoViewModel *publicViewModel = [[TwoViewModel alloc] init];
    [publicViewModel getDataRequestWithCallback:^(NSArray *array) {
        _dataArr = array;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TwoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicCell" forIndexPath:indexPath];
    [cell setValueWithModel:_dataArr[indexPath.row]];
    
    return cell;
}

@end
