//
//  TBCalendarViewController.m
//  TallyBook
//
//  Created by 三木 on 2021/8/8.
//

#import "TBCalendarViewController.h"
#import "TBBaseDefines.h"
#import <objc/runtime.h>

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
    
    
    self.cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *xCancel = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:50];
    NSLayoutConstraint *yCancel = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:50];
    [self.view addConstraints:@[xCancel,yCancel]];
    
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *xPicker = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cancelBtn attribute:NSLayoutAttributeBottom multiplier:1 constant:50];
    NSLayoutConstraint *yPicker = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:50];
    
    [self.view addConstraints:@[xPicker, yPicker]];
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
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
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
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setDate:[NSDate date]];
        [_datePicker setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"zh_CN"]];
        [_datePicker setBackgroundColor:[UIColor yellowColor]];
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
        SEL  selector =  NSSelectorFromString (@"setHighlightsToday:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDatePicker instanceMethodSignatureForSelector:selector]];
        BOOL no = NO;
        [invocation setSelector:selector];
        [invocation setArgument:&no atIndex:2];// 这个方法要从这里设置参数的Index 需要从2开始，因为前两个被selector和target占用
        [invocation invokeWithTarget:_datePicker];// 设好的参数 以及方法 赋值 给pickerView
        
        unsigned int propertyCount;
        objc_property_t *propertyList = class_copyPropertyList([UIDatePicker class], &propertyCount);
        for (int index = 0; index < propertyCount; index++) {
            NSString *getPropertyName = [NSString stringWithCString:property_getName(propertyList[index]) encoding:NSUTF8StringEncoding];
            NSString *getPropertyNameString = [NSString stringWithCString:property_getAttributes(propertyList[index]) encoding:NSUTF8StringEncoding];
            if([getPropertyName isEqualToString:@"textColor"]) {
                [_datePicker setValue:[UIColor blackColor] forKey:@"textColor"];
            }
            if([getPropertyName isEqualToString:@"highlightColor"]) {
                [_datePicker setValue:[UIColor blackColor] forKey:@"highlightColor"];
            }
//            NSLog(@"%@====%@",getPropertyNameString,getPropertyName);
        }
    }
    return _datePicker;
}


@end
