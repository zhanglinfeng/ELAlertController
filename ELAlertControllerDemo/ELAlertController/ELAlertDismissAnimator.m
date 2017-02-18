//
//  ELAlertDismissAnimator.m
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/24.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "ELAlertDismissAnimator.h"

@implementation ELAlertDismissAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toView.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
    }];
}

@end


@implementation ELActionSheetDismissAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toView.userInteractionEnabled = YES;
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    [transitionContext.containerView layoutIfNeeded];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [fromView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(transitionContext.containerView);
            make.width.equalTo(@(toView.frame.size.width - 20));
            make.top.equalTo(transitionContext.containerView).offset(transitionContext.containerView.frame.size.height);
        }];
        [transitionContext.containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
    }];
}

@end
