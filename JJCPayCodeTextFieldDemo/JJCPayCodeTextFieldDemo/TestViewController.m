//
//  TestViewController.m
//  JJCPayCodeTextField
//
//  Created by 苜蓿鬼仙 on 2017/8/3.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import "TestViewController.h"

#import "JJCPayCodeTextField.h"



@interface TestViewController ()

@property (nonatomic, strong) JJCPayCodeTextField *textField;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)setType:(NSInteger)type {
    
    _type = type;
    
    
    if (type == 0) {
        _textField = [[JJCPayCodeTextField alloc] initWithFrame:CGRectMake(50, 200, 250, 40) TextFieldType:JJCPayCodeTextFieldTypeEveryBorder];
        _textField.borderColor = [UIColor orangeColor];
    } else if (type == 1) {
        _textField = [[JJCPayCodeTextField alloc] initWithFrame:CGRectMake(50, 200, 250, 40) TextFieldType:JJCPayCodeTextFieldTypeWholeBorder];
        _textField.textFieldNum = 5;
    } else {
        _textField = [[JJCPayCodeTextField alloc] initWithFrame:CGRectMake(50, 200, 250, 40) TextFieldType:JJCPayCodeTextFieldTypeSpaceBorder];
        _textField.borderSpace = 5;
    }
    
    [self.view addSubview:_textField];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(100, 400, 150, 50);
    [btn setTitle:@"切换明文/密文" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnAction:(UIButton *)btn {
    
    _textField.isShowTrueCode = !_textField.isShowTrueCode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
