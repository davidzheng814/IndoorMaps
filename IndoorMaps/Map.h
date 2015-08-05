//
//  Map.h
//  IndoorMaps
//
//  Created by David Zheng on 7/29/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface Map : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSArray *points;
@property (strong, nonatomic) NSString *unique_id;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *summary;

- (id)initWithId:(NSString *)unique_id name:(NSString *)name;

- (BOOL)isFullyLoaded;

- (void)updateWithPFObject:(PFObject *)mapData;

@end
