//
//  TBFunctionRootViewController.m
//  TallyBook
//
//  Created by 三木 on 2021/8/8.
//

#import "TBFunctionRootViewController.h"
#import "TBCalendarViewController.h"


@interface TBFunctionRootViewController ()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation TBFunctionRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TallyBook";
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btm = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    [btm addTarget:self action:@selector(showCalendarVC) forControlEvents:UIControlEventTouchUpInside];
    btm.backgroundColor  = [UIColor greenColor];
    [btm setTitle:@"点击进入" forState:UIControlStateNormal];
    [btm setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btm];
    [self.view addSubview:self.dateLabel];
    self.dateLabel.center = self.view.center;
}

- (void)showCalendarVC
{
    TBCalendarViewController *vc = [[TBCalendarViewController alloc] init];
    vc.didFinishDatePick = ^(BOOL cancel, NSDate * _Nullable date) {
        if (!cancel) {
            NSString *label = [NSString stringWithFormat:@"%@", date];
            self.dateLabel.text = label;
        }
    };
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}


- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        [_dateLabel setTextColor:[UIColor blackColor]];
        _dateLabel.backgroundColor = [UIColor grayColor];
    }
    return _dateLabel;
}

@end
