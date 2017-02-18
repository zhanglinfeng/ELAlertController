//
//  ELAlertController.m
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/18.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "ELAlertController.h"
#import "ELAlertPresentAnimator.h"
#import "ELAlertDismissAnimator.h"
#import "Masonry.h"


@interface ELAlertController () 

@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) NSString *alertMessage;


@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UILabel *lbMessage;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnOK;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *viewLine;

@property (nonatomic, assign) ELAlertControllerStyle elPreferredStyle;

@property (nonatomic, copy) NSMutableArray *btnBlocks;

@end

@implementation ELAlertController


+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(ELAlertControllerStyle)preferredStyle {
    
    ELAlertController *alert = [[ELAlertController alloc] init];
    alert.alertTitle = title;
    alert.alertMessage = message;
    alert.elPreferredStyle = preferredStyle;
    return alert;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _btnBlocks = [NSMutableArray new];
        _textFields = [NSMutableArray new];
        self.view.backgroundColor = [UIColor whiteColor];
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = 10;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_btnBlocks.count < 1) {
        return;
    }
    if (self.elPreferredStyle == ELAlertControllerStyle_Alert) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initAlertUI];
    } else {
        [self initSheetUI];
        self.view.backgroundColor = [UIColor clearColor];
    }
    
    
}

#pragma mark - 初始化

- (void)initAlertUI {
    
    self.lbTitle = [[UILabel alloc] init];
    self.lbTitle.textColor = [UIColor blackColor];
    self.lbTitle.backgroundColor = [UIColor clearColor];
    self.lbTitle.textAlignment = NSTextAlignmentCenter;
    self.lbTitle.numberOfLines = 0;
    self.lbTitle.font = [UIFont boldSystemFontOfSize:16];
    self.lbTitle.text = self.alertTitle;
    [self.view addSubview:self.lbTitle];
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        
    }];
    
    self.lbMessage = [[UILabel alloc] init];
    self.lbMessage.textColor = [UIColor blackColor];
    self.lbMessage.backgroundColor = [UIColor clearColor];
    self.lbMessage.textAlignment = NSTextAlignmentCenter;
    self.lbMessage.numberOfLines = 0;
    self.lbMessage.font = [UIFont systemFontOfSize:13];
    self.lbMessage.text = self.alertMessage;
    [self.view addSubview:self.lbMessage];
    [self.lbMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat top = (self.alertMessage.length > 0 && self.alertTitle.length > 0) ? 10 : 0;
        make.top.equalTo(self.lbTitle.mas_bottom).offset(top);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        
    }];
    
    if (_textFields.count > 0) {
        [self initTextfield];
    }
    
    //横线
    self.viewLine = [[UIView alloc] init];
    self.viewLine.backgroundColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
    [self.view addSubview:self.viewLine];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (_textFields.count > 0) {
            UITextField *tfLast = [self.view viewWithTag:_textFields.count - 1 + 10];
            make.top.equalTo(tfLast.mas_bottom).offset(15);
        } else {
            make.top.equalTo(self.lbMessage.mas_bottom).offset(15);
        }
        make.height.equalTo(@(1/[UIScreen mainScreen].scale));
    }];
    
    
    
    if (_btnBlocks.count < 3) {
        [self initButton];
    } else {
        [self initTableView];
    }
    
}

- (void)initTextfield {
    for (NSInteger i = 0; i < _textFields.count; i++) {
        UITextField *tf = _textFields[i];
        tf.tag = i + 10;
        [self.view addSubview:tf];
        if (i == 0) {
            [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lbMessage.mas_bottom).offset(15);
                make.left.equalTo(self.view).offset(15);
                make.right.equalTo(self.view).offset(-15);
                make.height.equalTo(@25);
            }];
        } else {
            UITextField *tfLast = [self.view viewWithTag:i - 1 + 10];
            [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tfLast.mas_bottom).offset(-1/[UIScreen mainScreen].scale);
                make.left.equalTo(self.view).offset(15);
                make.right.equalTo(self.view).offset(-15);
                make.height.equalTo(@25);
            }];
        }
    }
}

- (void)initButton {
    if (_btnBlocks.count == 1) {
        //确定按钮
        NSArray *blockOK = [_btnBlocks lastObject];
        NSString *titleOK = [blockOK objectAtIndex:1];
        
        self.btnOK = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnOK.backgroundColor = [UIColor clearColor];
        self.btnOK.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.btnOK setTitle:titleOK forState:UIControlStateNormal];
        
        
        [self.view addSubview:self.btnOK];
        [self.btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(-0);
            make.top.equalTo(self.viewLine.mas_bottom);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.view).offset(-0);
        }];
        
        [self.btnOK addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
    } else if (_btnBlocks.count == 2) {
        
        //取消按钮
        NSArray *blockCancel = [_btnBlocks firstObject];
        NSString *titleCancel = [blockCancel objectAtIndex:1];
        
        self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnCancel.backgroundColor = [UIColor clearColor];
        self.btnCancel.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.btnCancel setTitle:titleCancel forState:UIControlStateNormal];
        [self.btnCancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.btnCancel];
        [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.viewLine.mas_bottom);
            make.height.equalTo(@40);
            make.bottom.equalTo(self.view);
        }];
        
        //竖线
        UIView *viewLine = [[UIView alloc] init];
        viewLine.backgroundColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
        [self.view addSubview:viewLine];
        [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.viewLine.mas_bottom);
            make.bottom.equalTo(self.view);
            make.width.equalTo(@(1/[UIScreen mainScreen].scale));
        }];
        
        
        //确定按钮
        NSArray *blockOK = [_btnBlocks lastObject];
        NSString *titleOK = [blockOK objectAtIndex:1];
        
        self.btnOK = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnOK.backgroundColor = [UIColor clearColor];
        self.btnOK.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.btnOK setTitle:titleOK forState:UIControlStateNormal];
        
        [self.view addSubview:self.btnOK];
        [self.btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnCancel.mas_right);
            make.right.equalTo(self.view);
            make.top.equalTo(self.btnCancel.mas_top);
            make.bottom.equalTo(self.btnCancel.mas_bottom);
            make.height.equalTo(self.btnCancel.mas_height);
            make.width.equalTo(self.btnCancel.mas_width);
        }];
        [self.btnOK addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.alertTitle.length < 1 && self.alertMessage.length < 1) {
            make.top.equalTo(self.view);
        } else {
            make.top.equalTo(self.viewLine.mas_bottom);
        }
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(@(_btnBlocks.count * 44));
    }];
}

- (void)initSheetUI {
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.clipsToBounds = YES;
    containerView.layer.cornerRadius = 10;
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
    }];
    
    self.lbTitle = [[UILabel alloc] init];
    self.lbTitle.textColor = [UIColor blackColor];
    self.lbTitle.backgroundColor = [UIColor clearColor];
    self.lbTitle.textAlignment = NSTextAlignmentCenter;
    self.lbTitle.numberOfLines = 0;
    self.lbTitle.font = [UIFont boldSystemFontOfSize:15];
    self.lbTitle.text = self.alertTitle;
    [containerView addSubview:self.lbTitle];
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(containerView).offset(15);
        make.right.equalTo(containerView).offset(-15);
        
    }];
    
    self.lbMessage = [[UILabel alloc] init];
    self.lbMessage.textColor = [UIColor blackColor];
    self.lbMessage.backgroundColor = [UIColor clearColor];
    self.lbMessage.textAlignment = NSTextAlignmentCenter;
    self.lbMessage.numberOfLines = 0;
    self.lbMessage.font = [UIFont systemFontOfSize:14];
    self.lbMessage.text = self.alertMessage;
    [containerView addSubview:self.lbMessage];
    [self.lbMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat top = (self.alertMessage.length > 0 && self.alertTitle.length > 0) ? 10 : 0;
        make.top.equalTo(self.lbTitle.mas_bottom).offset(top);
        make.left.equalTo(containerView).offset(15);
        make.right.equalTo(containerView).offset(-15);
        
    }];
    
    self.viewLine = [[UIView alloc] init];
    self.viewLine.hidden = _btnBlocks.count < 2;
    self.viewLine.backgroundColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
    [containerView addSubview:self.viewLine];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        make.top.equalTo(self.lbMessage.mas_bottom).offset(15);
        make.height.equalTo(@(1/[UIScreen mainScreen].scale));
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:containerView.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    [containerView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.alertTitle.length < 1 && self.alertMessage.length < 1) {
            make.top.equalTo(containerView);
        } else {
            make.top.equalTo(self.viewLine.mas_bottom);
        }
        make.left.right.bottom.equalTo(containerView).offset(0);
        make.height.equalTo(@((_btnBlocks.count - 1) * 56));
    }];
    
    //取消按钮
    NSArray *blockCancel = [_btnBlocks firstObject];
    NSString *titleCancel = [blockCancel objectAtIndex:1];
    
    self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnCancel.backgroundColor = [UIColor whiteColor];
    self.btnCancel.layer.cornerRadius = 10;
    self.btnCancel.clipsToBounds = YES;
    self.btnCancel.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.btnCancel setTitle:titleCancel forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnCancel];
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(containerView.mas_bottom).offset(15);
        make.height.equalTo(@56);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
}

#pragma mark - public

- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block {
    [_btnBlocks addObject:[NSArray arrayWithObjects:
                        block ? [block copy] : [NSNull null],
                        title,
                        nil]];
}

- (void)addCancelButtonWithTitle:(NSString *)title block:(void (^)())block {
    [_btnBlocks insertObject:[NSArray arrayWithObjects:
                        block ? [block copy] : [NSNull null],
                        title,
                        nil] atIndex:0];
}

- (void)addTextFieldWidthPlaceholder:(NSString *)text {
    UITextField *tf = [[UITextField alloc] init];
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    tf.layer.borderColor = [UIColor darkGrayColor].CGColor;
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont systemFontOfSize:13];
    tf.placeholder = text;
    tf.backgroundColor = [UIColor whiteColor];
    [_textFields addObject:tf];
}


#pragma mark - Action

- (void)clickOK {
    NSArray *block = [_btnBlocks lastObject];
    
    [self dismissViewControllerAnimated:YES completion:^{
        id obj = block[0];
        if (![obj isEqual:[NSNull null]])
        {
            ((void (^)())obj)();
        }
    }];
}

- (void)clickCancel {
    NSArray *block = [_btnBlocks firstObject];
    
    [self dismissViewControllerAnimated:YES completion:^{
        id obj = block[0];
        if (![obj isEqual:[NSNull null]])
        {
            ((void (^)())obj)();
        }
    }];
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.elPreferredStyle == ELAlertControllerStyle_Alert ? _btnBlocks.count : _btnBlocks.count - 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.elPreferredStyle == ELAlertControllerStyle_Alert ? 44 : 56;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:122/255.0f blue:255/255.0f alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row < _btnBlocks.count - 1) {
        NSArray *block = [_btnBlocks objectAtIndex:indexPath.row + 1];
        NSString *title = [block objectAtIndex:1];
        cell.textLabel.text = title;
    } else {
        if (self.elPreferredStyle == ELAlertControllerStyle_Alert) {
            NSArray *block = [_btnBlocks objectAtIndex:0];
            NSString *title = [block objectAtIndex:1];
            cell.textLabel.text = title;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        }
        
    }
    
    //分割线顶头
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *block = nil;
    if (indexPath.row < _btnBlocks.count - 1) {
        block = [_btnBlocks objectAtIndex:indexPath.row + 1];
    } else {
        if (self.elPreferredStyle == ELAlertControllerStyle_Alert) {
            block = [_btnBlocks objectAtIndex:0];
            
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        id obj = block[0];
        if (![obj isEqual:[NSNull null]])
        {
            ((void (^)())obj)();
        }
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    if (_textFields.count > 0) {
        UITextField *tf = _textFields[0];
        [tf becomeFirstResponder];
    }
    if (self.elPreferredStyle == ELAlertControllerStyle_Alert) {
        _presentedTransitioning = [ELAlertPresentAnimator new];
        [(ELAlertPresentAnimator *)_presentedTransitioning setNeedTapGesture:self.needTap];
    } else {
        _presentedTransitioning = [ELActionSheetPresentAnimator new];
    }
    
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.elPreferredStyle == ELAlertControllerStyle_Alert) {
        _dimissTransitioning = [ELAlertDismissAnimator new];
    } else {
        _dimissTransitioning = [ELActionSheetDismissAnimator new];
    }
    return _dimissTransitioning;
}

@end
