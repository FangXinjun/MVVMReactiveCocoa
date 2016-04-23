//
//  FXJViewModel.h
//  mvvmReactiveCocoa
//
//  Created by myApplePro01 on 16/4/23.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSubject;

@interface FXJViewModel : NSObject
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) RACSubject *successObject;

@property (nonatomic, strong) RACSubject *failureObject;

@property (nonatomic, strong) RACSubject *errorObject;

- (id) buttonIsValid;

- (void)login;
@end
