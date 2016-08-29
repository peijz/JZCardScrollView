//
//  JZCardScrollView.m
//
//
//  Created by peijz on 16/2/2.
//  Copyright © 2016年 peijz. All rights reserved.
//

#import "ViewController.h"
#import "JZCardScrollView.h"

@interface ViewController ()


@property (nonatomic,strong) JZCardScrollView *cardSwitchView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSArray *dicAry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dicAry = @[@{@"isColloct":@(YES),
                  @"image":@"pic.jpg",
                  @"name":@"农庄1",
                  @"address":@"距100km",
                  },
                
                @{@"isColloct":@(YES),
                  @"image":@"pic.jpg",
                  @"name":@"农庄2",
                  @"address":@"距102km",
                  },
                
                @{@"isColloct":@(YES),
                  @"image":@"pic.jpg",
                  @"name":@"农庄3",
                  @"address":@"距104km",
                  },
                
                @{@"isColloct":@(YES),
                  @"image":@"pic.jpg",
                  @"name":@"农庄4",
                  @"address":@"距106km",
                  },
                
                @{@"isColloct":@(YES),
                  @"image":@"pic.jpg",
                  @"name":@"农庄5",
                  @"address":@"距108km",
                  }];
    
    
    [self addFelicityView];
    
}


- (void)addFelicityView {
    _cardSwitchView = [[JZCardScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 312)];
    [_cardSwitchView setCardSwitchViewAry:[self ittemsCardSwitchViewAry] delegate:self];
    [self.view addSubview:_cardSwitchView];
}

/**
 *  准备添加到卡片切换View上的View数组
 *
 *  @param felicityAry <#felicityAry description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)ittemsCardSwitchViewAry {
    NSMutableArray *ary = [NSMutableArray array];
    
    for (NSDictionary *felicityDic in _dicAry) {
        NSInteger index = [_dicAry indexOfObject:felicityDic];
        NSString * nameStr = felicityDic[@"name"];
        NSString * distanceStr = felicityDic[@"distance"];
        NSString * addressStr = felicityDic[@"address"];
        NSString *imageStr = felicityDic[@"image"];
        
        // 大的View   如果需要点击  这里用button
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 333, 312)];
        backImageView.backgroundColor = [UIColor whiteColor];
        backImageView.layer.masksToBounds = YES;
        backImageView.layer.cornerRadius = 4;
        backImageView.tag = index;
        
        
        
        // 图片框
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 333, 400)];
        imageView.center = CGPointMake(backImageView.frame.size.width/2, 0);
        imageView.image = [UIImage imageNamed:imageStr];
        [backImageView addSubview:imageView];
        
        //名称
        UILabel * nameText = [[UILabel alloc]initWithFrame:CGRectMake(0, 220, 333, 15)];
        nameText.text = nameStr;
        nameText.font = [UIFont systemFontOfSize:15];
        nameText.textColor = [UIColor blackColor];
        nameText.textAlignment = NSTextAlignmentCenter;
        [backImageView addSubview:nameText];
        
        
        // 地址
        
        UILabel * addressText = [[UILabel alloc]initWithFrame:CGRectMake(0, 240, 333, 11)];
        addressText.text = addressStr;
        addressText.font = [UIFont systemFontOfSize:11];
        addressText.textColor = [UIColor blackColor];
        addressText.textAlignment = NSTextAlignmentCenter;
        [backImageView addSubview:addressText];
        
        // 距离
        UILabel * distanceText = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, 333, 11)];
        distanceText.text = distanceStr;
        distanceText.font = [UIFont systemFontOfSize:11];
        distanceText.textColor = [UIColor blackColor];
        distanceText.textAlignment = NSTextAlignmentCenter;
        [backImageView addSubview:distanceText];
        
        [ary addObject:backImageView];
    }
    return ary;
}

- (void)addBottomView {
    if (_bottomView.subviews.count > 0) {
        [_bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
    
    float space = (self.view.frame.size.width - 49*_dicAry.count - 40)/(_dicAry.count-1);
    
    for (NSDictionary *felicityDic in _dicAry) {
        NSInteger index = [_dicAry indexOfObject:felicityDic];
        
        BOOL isColloct = [felicityDic[@"isColloct"] boolValue];
        
        NSString *title = felicityDic[@"title"];
        NSString *imageStr = felicityDic[@"smallImage"];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20+(49+space)*index, 2, 49, 49)];
        imageView.image = [UIImage imageNamed:imageStr];
        [_bottomView addSubview:imageView];
        
        UIImageView *selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x - 2, imageView.frame.origin.y - 2, 53, 53)];
        selectImageView.image = [UIImage imageNamed:@"fu_card_selected_border"];
        selectImageView.hidden = (index == _currentIndex) ? NO : YES;
        [_bottomView addSubview:selectImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 49, 14)];
        titleLabel.center = CGPointMake(imageView.center.x, imageView.center.y + imageView.frame.size.height/2 + 15);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = isColloct ? JZUIColorWithHex(0xffb170) : JZUIColorWithHex(0x898989);
        [_bottomView addSubview:titleLabel];
    }
}

#pragma mark JZCardScrollViewDelegate

- (void)cardSwitchViewDidScroll:(JZCardScrollView *)cardSwitchView index:(NSInteger)index {
    NSLog(@"index:%ld",(long)index);
    _currentIndex = index;
    [self addBottomView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
