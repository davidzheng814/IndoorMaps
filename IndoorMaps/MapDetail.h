//
//  TPSProduct.h
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import <Foundation/Foundation.h>


@interface MapDetail : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;

+ (NSArray *)mapDetails;

+ (instancetype)detailWithDescription:(NSString *)description :(NSString *)name;


@end
