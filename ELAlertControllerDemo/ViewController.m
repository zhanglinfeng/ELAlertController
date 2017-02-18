//
//  ViewController.m
//  ELAlertControllerDemo
//
//  Created by 张林峰 on 17/1/23.
//  Copyright © 2017年 张林峰. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+PresentAlert.h"


@interface ViewController ()

@property (nonatomic, strong) UIImageView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)alert1:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_Alert];
    [alert addButtonWithTitle:@"OK" block:^{
        NSLog(@"点击了OK");
    
    }];
//    [self presentAlertController:alert completion:nil];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)alert2:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_Alert];
    [alert addButtonWithTitle:@"OK" block:^{
        NSLog(@"点击了OK");
    }];
    
    [alert addCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"点击了Cancel");
    }];
    
    [self presentAlertController:alert completion:nil];
}
- (IBAction)alert3:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_Alert];
    [alert addButtonWithTitle:@"OK1" block:^{
        NSLog(@"点击了OK1");
    }];
    
    [alert addButtonWithTitle:@"OK2" block:^{
        NSLog(@"点击了OK2");
    }];
    
    [alert addCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"点击了Cancel");
    }];
    [self presentAlertController:alert completion:nil];
}


- (IBAction)sheet1:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_ActionSheet];
    [alert addButtonWithTitle:@"OK" block:^{
        NSLog(@"点击了OK");
        
    }];
    [self presentAlertController:alert completion:nil];
    
}

- (IBAction)sheet2:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_ActionSheet];
    [alert addButtonWithTitle:@"OK" block:^{
        NSLog(@"点击了OK");
    }];
    
    [alert addCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"点击了Cancel");
    }];
    
//    [self presentAlertController:alert completion:nil];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)sheet3:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_ActionSheet];
    [alert addButtonWithTitle:@"OK1" block:^{
        NSLog(@"点击了OK1");
    }];
    
    [alert addButtonWithTitle:@"OK2" block:^{
        NSLog(@"点击了OK2");
    }];
    
    [alert addCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"点击了Cancel");
    }];
    [self presentAlertController:alert completion:nil];
}
- (IBAction)tfAlert1:(id)sender {
    
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_Alert];
    [alert addButtonWithTitle:@"OK" block:^{
        NSLog(@"点击了OK1");
    }];
    
    
    [alert addCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"点击了Cancel");
    }];
    
    [alert addTextFieldWidthPlaceholder:@"请输入密码"];
    [self presentAlertController:alert completion:nil];
}

- (IBAction)tfAlert2:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_Alert];
    [alert addButtonWithTitle:@"OK1" block:^{
        NSLog(@"点击了OK1");
    }];
    
    [alert addButtonWithTitle:@"OK2" block:^{
        NSLog(@"点击了OK2");
    }];
    
    [alert addCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"点击了Cancel");
    }];
    [alert addTextFieldWidthPlaceholder:@"请输入账号"];
    [alert addTextFieldWidthPlaceholder:@"请输入密码"];
    
    [self presentAlertController:alert completion:nil];
}

- (IBAction)custom:(id)sender {
    ELAlertController *alert = [ELAlertController alertControllerWithTitle:@"提示" message:@"温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示温馨提示" preferredStyle:ELAlertControllerStyle_Alert];
    alert.needTap = YES;
    [alert.view addSubview:self.customView];
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(alert.view);
        make.height.equalTo(@200);
    }];
    [self presentAlertController:alert completion:nil];
}

-(UIImageView *)customView {
    if (!_customView) {
        _customView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"蚂蚁.jpg"];
        _customView.image = image;
    }
    return _customView;
}

@end
