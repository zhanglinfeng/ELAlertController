//
//  ELAlertController.h
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/18.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, ELAlertControllerStyle) {
    ELAlertControllerStyle_ActionSheet = 0,
    ELAlertControllerStyle_Alert
};

@interface ELAlertController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>
{
    id<UIViewControllerAnimatedTransitioning> _presentedTransitioning;
    id<UIViewControllerAnimatedTransitioning> _dimissTransitioning;
}

@property (nonatomic, strong) NSMutableArray * _Nonnull textFields;
@property (nonatomic, assign) BOOL needTap;//是否需要点击空白处消失

+ (instancetype _Nullable )alertControllerWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message preferredStyle:(ELAlertControllerStyle)preferredStyle;

- (void)addButtonWithTitle:(NSString *_Nonnull)title block:(void (^_Nonnull)())block;
- (void)addCancelButtonWithTitle:(NSString *_Nonnull)title block:(void (^_Nonnull)())block;
- (void)addTextField:(void (^ __nullable)(UITextField * _Nonnull textField))block;

@end
