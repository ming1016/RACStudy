//
//  ViewController.m
//  RACStudy
//
//  Created by DaiMing on 16/5/28.
//  Copyright © 2016年 Starming. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "SMStudent.h"

@interface ViewController ()

@property (nonatomic, strong) SMStudent *student;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UILabel *currentCreditLabel;
@property (nonatomic, strong) UILabel *isSatisfyLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    //present
    self.student = [[[[[SMStudent create]
                       name:@"ming"]
                      gender:SMStudentGenderMale]
                     studentNumber:345]
                    filterIsASatisfyCredit:^BOOL(NSUInteger credit){
                        if (credit >= 70) {
                            self.isSatisfyLabel.text = @"合格";
                            self.isSatisfyLabel.textColor = [UIColor redColor];
                            return YES;
                        } else {
                            self.isSatisfyLabel.text = @"不合格";
                            return NO;
                        }
                        
                    }];
    
    @weakify(self);
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.student sendCredit:^NSUInteger(NSUInteger credit) {
            credit += 5;
            NSLog(@"current credit %lu",credit);
            [self.student.creditSubject sendNext:credit];
            return credit;
        }];
    }];
    
    [self.student.creditSubject subscribeNext:^(NSUInteger credit) {
        NSLog(@"第一个订阅的credit处理积分%lu",credit);
        self.currentCreditLabel.text = [NSString stringWithFormat:@"%lu",credit];
        if (credit < 30) {
            self.currentCreditLabel.textColor = [UIColor lightGrayColor];
        } else if(credit < 70) {
            self.currentCreditLabel.textColor = [UIColor purpleColor];
        } else {
            self.currentCreditLabel.textColor = [UIColor redColor];
        }
    }];
    
    [self.student.creditSubject subscribeNext:^(NSUInteger credit) {
        NSLog(@"第二个订阅的credit处理积分%lu",credit);
        if (!(credit > 0)) {
            self.currentCreditLabel.text = @"0";
            self.isSatisfyLabel.text = @"未设置";
        }
    }];
}

- (void)setupUI {
    [self.view addSubview:self.currentCreditLabel];
    [self.currentCreditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.equalTo(self.view).offset(40);
    }];
    
    [self.view addSubview:self.isSatisfyLabel];
    [self.isSatisfyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];
}

#pragma mark - Getter
- (UILabel *)currentCreditLabel {
    if (!_currentCreditLabel) {
        _currentCreditLabel = [[UILabel alloc] init];
        _currentCreditLabel.textColor = [UIColor lightGrayColor];
    }
    return _currentCreditLabel;
}
- (UILabel *)isSatisfyLabel {
    if (!_isSatisfyLabel) {
        _isSatisfyLabel = [[UILabel alloc] init];
        _isSatisfyLabel.textAlignment = NSTextAlignmentRight;
        _isSatisfyLabel.textColor = [UIColor lightGrayColor];
        
    }
    return _isSatisfyLabel;
}
- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testButton setTitle:@"增加5个积分" forState:UIControlStateNormal];
        [_testButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:_testButton];
        [_testButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    return _testButton;
}

@end
