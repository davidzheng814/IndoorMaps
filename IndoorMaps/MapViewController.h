//
//  MapViewController.h
//  IndoorMaps
//
//  Created by David Zheng on 7/27/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Map.h"

@interface MapViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) Map *map;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end
