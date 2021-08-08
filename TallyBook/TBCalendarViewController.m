//
//  TBCalendarViewController.m
//  TallyBook
//
//  Created by 三木 on 2021/8/8.
//

#import "TBCalendarViewController.h"

@interface TBCalendarViewController ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation TBCalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择日期";
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.confirmBtn];
    [self.view addSubview:self.datePicker];
    self.datePicker.center = self.view.center;
}

#pragma mark - actions

- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.didFinishDatePick) {
            self.didFinishDatePick(YES, nil);
        }
    }];
}

- (void)confirmAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.didFinishDatePick) {
            self.didFinishDatePick(NO, self.datePicker.date);
        }
    }];
}


#pragma mark - getter

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 100, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(300, 50, 100, 40)];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.textColor = [UIColor blackColor];// 为什么不生效
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 500, 500)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"zh_CN"]];
        [_datePicker setDate:[NSDate date]];
        [_datePicker setBackgroundColor:[UIColor yellowColor]];
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
    }
    return _datePicker;
}


@end
