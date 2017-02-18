//
//  UIViewController+PresentAlert.m
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/22.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "UIViewController+PresentAlert.h"

NSString const *EL_TransitioningDelegate = @"EL_TransitioningDelegate";

@implementation UIViewController (PresentAlert)

- (void)presentAlertController:(nullable ELAlertController *)ctrl completion:(void (^ __nullable)(void))completion {

    
    [self presentViewController:ctrl animated:YES completion:^{
        if (completion) {
            completion();
        }
    }];
}

@end
