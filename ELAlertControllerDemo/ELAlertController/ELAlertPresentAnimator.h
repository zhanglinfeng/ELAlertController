//
//  ELAlertPresentAnimator.h
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/24.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELAlertPresentAnimator : NSObject<UIViewControllerAnimatedTransitioning> {
    id <UIViewControllerContextTransitioning> _transitionContext;
    UIView *_maskView;
}

@property (nonatomic, assign) BOOL hideMask;
@property (nonatomic, assign) BOOL needTapGesture;//是否需要点击空白处的事件

@end


@interface ELActionSheetPresentAnimator : NSObject<UIViewControllerAnimatedTransitioning> {
    id <UIViewControllerContextTransitioning> _transitionContext;
    UIView *_maskView;
}

@property (nonatomic, assign) BOOL hideMask;

@end
