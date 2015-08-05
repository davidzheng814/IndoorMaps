//
//  Map.m
//  IndoorMaps
//
//  Created by David Zheng on 7/29/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import "Map.h"

@implementation Map
@synthesize image;
@synthesize points;
@synthesize location;
@synthesize summary;

- (id)initWithId:(NSString *)unique_id name:(NSString *)name{
    self = [super init];
    
    if(self){
        self.unique_id = unique_id;
        self.name = name;
    }
    self.image = nil;
    self.points = nil;
    self.location = nil;
    self.summary = nil;
    
    return self;
}

-(BOOL)isFullyLoaded{
    return self.image != nil && self.points != nil && self.location != nil && self.summary != nil;
}

- (void)updateWithPFObject:(PFObject *)mapData {
    PFFile *imagePFFile = mapData[@"image"];
    
    NSData *imageData = [imagePFFile getData];
    self.image = [UIImage imageWithData:imageData];
    self.points = mapData[@"points"];
    self.location = mapData[@"location"];
    self.summary = mapData[@"summary"];
    self.name = mapData[@"name"];
}

@end
