//
//  ELAlertController.h
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/18.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, ELAlertControllerStyle) {
    ELAlertControllerStyle_Alert,
    ELAlertControllerStyle_ActionSheet
};

@interface ELAlertController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>
{
    id<UIViewControllerAnimatedTransitioning> _presentedTransitioning;
    id<UIViewControllerAnimatedTransitioning> _dimissTransitioning;
}

@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, assign) BOOL needTap;//是否需要点击空白处消失

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(ELAlertControllerStyle)preferredStyle;

- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addCancelButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addTextFieldWidthPlaceholder:(NSString *)text;

@end
