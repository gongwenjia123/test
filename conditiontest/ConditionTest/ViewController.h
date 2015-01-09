//
//  ViewController.h
//  ConditionTest
//
//  Created by Apple_Gong on 14-12-8.
//  Copyright (c) 2014年 Apple_Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NVMarginType) {
    NVMarginTypeDetail = 0,
    NVMarginTypeList,
    NVMarginTypeForm,
};

@interface ViewController : UIViewController

@property (nonatomic)NVMarginType marginType;


@end

