//
//  UIViewController+PresentAlert.h
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/22.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELAlertController.h"

@interface UIViewController (PresentAlert)


- (void)presentAlertController:(nullable ELAlertController *)ctrl completion:(void (^ __nullable)(void)) completion;

@end
