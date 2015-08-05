//
//  MapViewController.m
//  IndoorMaps
//
//  Created by David Zheng on 7/27/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () 

@end

@implementation MapViewController

@synthesize map;
@synthesize imageView;
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    
    UIImage *image = map.image;
    imageView = [[UIImageView alloc] initWithImage:image];
    
    scrollView.contentSize = CGSizeMake(MAX(image.size.width, fullScreenRect.size.width),
                                        MAX(image.size.height, fullScreenRect.size.height));
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 6.0;
    
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
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
