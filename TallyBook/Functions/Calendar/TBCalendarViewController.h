//
//  TBCalendarViewController.h
//  TallyBook
//
//  Created by 三木 on 2021/8/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBCalendarViewController : UIViewController

@property (nonatomic, strong) void(^didFinishDatePick)(BOOL cancel, NSDate * _Nullable date);

@end

NS_ASSUME_NONNULL_END
