//
//  TPSProduct.m
//  Sample-UISearchController
//
//  Created by James Dempsey on 7/4/14.
//  Copyright (c) 2014 Tapas Software. All rights reserved.
//
//  Based on Apple sample code TableSearch version 2.0
//

#import "MapDetail.h"

NSString *const SampleDescription = @"This map is cool";


@implementation MapDetail
@synthesize description = _description;

+ (NSArray *)mapDetails {
    return @[[MapDetail detailWithDescription:SampleDescription :@"iPhone"],
              [MapDetail detailWithDescription:SampleDescription :@"iPod"],
              [MapDetail detailWithDescription:SampleDescription :@"iPod touch"],
             [MapDetail detailWithDescription:SampleDescription :@"iPod nano"],
             [MapDetail detailWithDescription:SampleDescription :@"iPod classic"],
              [MapDetail detailWithDescription:SampleDescription :@"iPad"],
              [MapDetail detailWithDescription:SampleDescription :@"iPad mini"],
              [MapDetail detailWithDescription:SampleDescription :@"iPad Air"],
              [MapDetail detailWithDescription:SampleDescription :@"iMac"],
              [MapDetail detailWithDescription:SampleDescription :@"Mac Pro"],
              [MapDetail detailWithDescription:SampleDescription :@"Mac mini"],
              [MapDetail detailWithDescription:SampleDescription :@"MacBook"],
              [MapDetail detailWithDescription:SampleDescription :@"MacBook Air"],
              [MapDetail detailWithDescription:SampleDescription :@"MacBook Pro"]];
}

+ (instancetype)detailWithDescription:(NSString *)description :(NSString *)name {
    MapDetail *newProduct = [[self alloc] init];
    newProduct.description = description;
    newProduct.name = name;
    return newProduct;
}

static NSString *const NameKey = @"NameKey";
static NSString *const DescriptionKey = @"DescriptionKey";

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:NameKey];
        _description = [aDecoder decodeObjectForKey:DescriptionKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NameKey];
    [aCoder encodeObject:self.description forKey:DescriptionKey];
}

@end