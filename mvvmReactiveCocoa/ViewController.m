//
//  ViewController.m
//  mvvmReactiveCocoa
//
//  Created by myApplePro01 on 16/4/23.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "ViewController.h"
#import "FXJViewModel.h"
#import "FXJTwoViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *testLable;

@property (nonatomic, strong) FXJViewModel        *viewModel;

@end

@implementation ViewController


//关联ViewModel

- (void)bindModel {
    
    _viewModel = [[FXJViewModel alloc] init];
    
    // 只要文本框文字改变，就会修改userName的值(accountFiled的文本变化就会修改viewModel的userName属性值)
    RAC(self.viewModel, userName) = self.accountFiled.rac_textSignal;
    
    RAC(self.viewModel, password) = self.passwordFiled.rac_textSignal;
    
    RAC(self.loginBtn, enabled) = [_viewModel buttonIsValid];
    
    
    
    @weakify(self);
    
    //设置登录成功要处理的方法
    [self.viewModel.successObject subscribeNext:^(NSArray * x) {
        
        @strongify(self);
        
        FXJTwoViewController *vc = [[FXJTwoViewController alloc] init];
        vc.userName = x[0];
        
        vc.password = x[1];
        
        [self presentViewController:vc animated:YES completion:^{
                        
        }];
        
    }];
    
    //fail
    
    [self.viewModel.failureObject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //error
    
    [self.viewModel.errorObject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
        
}

- (void)onClick {
    
    //监听按钮点击事件
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [_viewModel login];
     }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self bindModel];
    [self onClick];
    
    // 只要文本框文字改变，就会修改label的文字(accountFiled的文本变化就会修改_testLable的text的值)
    RAC(_testLable,text) = self.accountFiled.rac_textSignal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
