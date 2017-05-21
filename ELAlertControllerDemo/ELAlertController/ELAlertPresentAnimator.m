//
//  ELAlertPresentAnimator.m
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/24.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "ELAlertPresentAnimator.h"
#import "Masonry.h"

#pragma mark - ELAlertPresentAnimator

@implementation ELAlertPresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext = transitionContext;
    
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    _maskView = [[UIView alloc] initWithFrame:fromView.bounds];
    _maskView.backgroundColor = self.hideMask ? [UIColor clearColor] : [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    if (self.needTapGesture) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(elpresent_dismissCtrl:)];
        [_maskView addGestureRecognizer:gesture];
        gesture.cancelsTouchesInView = NO;//为yes只响应优先级最高的事件，Button高于手势，textfield高于手势，textview高于手势，手势高于tableview。为no同时都响应，默认为yes
    }
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    [transitionContext.containerView addSubview:_maskView];
    [transitionContext.containerView addSubview:toView];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(transitionContext.containerView);
    }];
    
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(transitionContext.containerView);
        make.width.equalTo(@280);
    }];
    
    BOOL hasTextField = NO;
    for (UIView *v in toView.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            hasTextField = YES;
            break;
        }
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        _maskView.backgroundColor = self.hideMask ? [UIColor clearColor] : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        if (hasTextField) {
            [toView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(transitionContext.containerView).centerOffset(CGPointMake(0, -128));
                
            }];
//            [transitionContext.containerView layoutIfNeeded];
        }
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)elpresent_dismissCtrl:(id)sender {
    UIViewController *toViewController = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [toViewController dismissViewControllerAnimated:YES completion:^{
        if (self.tapBlock) {
            self.tapBlock();
        }}];
}

@end


#pragma mark - ELActionSheetPresentAnimator

@implementation ELActionSheetPresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext = transitionContext;
    
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    _maskView = [[UIView alloc] initWithFrame:fromView.bounds];
    _maskView.backgroundColor = self.hideMask ? [UIColor clearColor] : [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    if (self.needTapGesture) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(elpresent_dismissCtrl:)];
        [_maskView addGestureRecognizer:gesture];
        gesture.cancelsTouchesInView = NO;//为yes只响应优先级最高的事件，Button高于手势，textfield高于手势，textview高于手势，手势高于tableview。为no同时都响应，默认为yes
    }
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    [transitionContext.containerView addSubview:_maskView];
    [transitionContext.containerView addSubview:toView];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(transitionContext.containerView);
    }];
    
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(transitionContext.containerView);
        make.width.equalTo(@(transitionContext.containerView.frame.size.width - 20));
        make.top.equalTo(transitionContext.containerView).offset(transitionContext.containerView.frame.size.height);
    }];
    
    [transitionContext.containerView layoutIfNeeded];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        _maskView.backgroundColor = self.hideMask ? [UIColor clearColor] : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        [toView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(transitionContext.containerView);
            make.width.equalTo(@(transitionContext.containerView.frame.size.width - 20));
            make.bottom.equalTo(transitionContext.containerView);
        }];
        [transitionContext.containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)elpresent_dismissCtrl:(id)sender {
    UIViewController *toViewController = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [toViewController dismissViewControllerAnimated:YES completion:^{
        if (self.tapBlock) {
            self.tapBlock();
        }
    }];
}

@end
