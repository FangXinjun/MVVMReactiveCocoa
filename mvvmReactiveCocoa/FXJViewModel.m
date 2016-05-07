//
//  FXJViewModel.m
//  mvvmReactiveCocoa
//
//  Created by myApplePro01 on 16/4/23.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "FXJViewModel.h"
#import "FXJDataModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FXJViewModel ()

@property (nonatomic, strong) RACSignal *userNameSignal;

@property (nonatomic, strong) RACSignal *passwordSignal;

@property (nonatomic, strong) NSArray *requestData;
@end

@implementation FXJViewModel



- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self initialize];
    }
    
    return self;
    
}

- (void)initialize
{
    //监听属性  返回信号(监听userName值得变化) 用于合并信号
    _userNameSignal = RACObserve(self, userName);
    
    _passwordSignal = RACObserve(self, password);
    
    // 创建信号  用于VM发送订阅消息  VC接受接受订阅消息
    _successObject = [RACSubject subject];
    
    _failureObject = [RACSubject subject];
    
    _errorObject = [RACSubject subject];
    
}

//合并两个输入框信号，并返回按钮bool类型的值
- (id) buttonIsValid {
    
    RACSignal *isValid = [RACSignal
                          
                          combineLatest:@[_userNameSignal, _passwordSignal]
                          
                          reduce:^id(NSString *userName, NSString *password){
                              
                              NSLog(@"%@ - %@",userName,password);
                              return @(userName.length >= 3 && password.length >= 3);
                              
                          }];
    return isValid;
}

- (void)login{
    
    //网络请求进行登录
    _requestData = @[_userName, _password];
    //成功发送成功的信号
    
    [_successObject sendNext:_requestData];
    
//    [_failureObject sendNext:@"失败"];
//    [_errorObject sendNext:@"错误"];

    //业务逻辑失败和网络请求失败发送fail或者error信号并传参
}


@end
