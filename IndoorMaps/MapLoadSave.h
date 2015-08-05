//
//  MapLoadSave.h
//  IndoorMaps
//
//  Created by David Zheng on 7/29/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"

@interface MapLoadSave : NSObject

extern NSMutableDictionary *maps;

+ (void)updateMapNamesAndIds;

+ (void)loadFullMap:(NSString *)unique_id;

+ (void)downloadMap:(NSString *)unique_id;

+ (void)saveMap:(Map *)map;
@end
