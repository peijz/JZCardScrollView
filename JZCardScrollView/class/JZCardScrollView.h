//
//  JZCardScrollView.h
//  JZCardScrollView
//
//  Created by peijz on 16/2/2.
//  Copyright © 2016年 peijz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JZUIColorWithHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

@class JZCardScrollView;

@protocol JZCardScrollViewDelegate <NSObject>

- (void)cardSwitchViewDidScroll:(JZCardScrollView *)cardSwitchView index:(NSInteger)index;

@end

@interface JZCardScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic,assign) id<JZCardScrollViewDelegate> delegate;
@property (nonatomic,strong) UIScrollView *cardSwitchScrollView;
@property (nonatomic,assign) float currentIndex;

- (void)setCardSwitchViewAry:(NSArray *)cardSwitchViewAry delegate:(id)delegate;

@end
