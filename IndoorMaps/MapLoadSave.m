//
//  MapLoadSave.m
//  IndoorMaps
//
//  Created by David Zheng on 7/29/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import "MapLoadSave.h"
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>

@implementation MapLoadSave

NSMutableDictionary *maps;

+ (void)initialize {
    [super initialize];
    
    [MapLoadSave updateMapNamesAndIds];
}

// Should not have to be called usually, except by initialize.
+ (void)updateMapNamesAndIds{
    PFQuery *query = [PFQuery queryWithClassName:@"Map"];
    [query fromLocalDatastore];
    
    NSArray* localMaps = [query findObjects];
    
    NSMutableDictionary *new_maps = [[NSMutableDictionary alloc] init];
    [localMaps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        PFObject *mapObject = (PFObject *)obj;
        NSString *unique_id = mapObject.objectId;
        NSString *name = mapObject[@"name"];
        
        new_maps[unique_id] = [[Map alloc] initWithId:unique_id name:name];
        
    }];
    maps = new_maps;
}

+ (void)loadFullMap:(NSString *)unique_id{
    Map *map = maps[unique_id];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Map"];
    [query fromLocalDatastore];
    
    PFObject *result = [query getObjectWithId:map.unique_id];
    
    [map updateWithPFObject:result];
    
    return;
};

+ (void)saveMap:(Map *)map {
    PFQuery *query = [PFQuery queryWithClassName:@"Map"];
    [query fromLocalDatastore];
    
    PFObject *result = [query getObjectWithId:map.unique_id];
    
    result[@"name"] = map.name;
    result[@"location"] = map.location;
    result[@"summary"] = map.summary;
    result[@"image"] = [PFFile fileWithData:UIImagePNGRepresentation(map.image)];
    result[@"points"] = map.points;
    
    [result pinInBackground];
    [result saveEventually];
    
    return;
}

+ (int)createNewMap:(NSString *)name{
    PFObject *mapObject = [PFObject objectWithClassName:@"Map"];
    
    mapObject[@"name"] = name;
    mapObject[@"location"] = nil;
    mapObject[@"summary"] = nil;
    mapObject[@"image"] = nil;
    mapObject[@"points"] = nil;
    
    [mapObject saveEventually];
    
    Map *map = [[Map alloc] initWithId:mapObject.objectId name:name];
    
    maps[mapObject.objectId] = map;
    
    return (int)[maps count] - 1;
}

+ (void)downloadMap:(NSString *)unique_id{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Map"];
    [query getObjectInBackgroundWithId:unique_id block:^(PFObject *mapData, NSError *error) {
        [mapData pinInBackground];
        
        if (!maps[unique_id]){
            Map *map = [[Map alloc] initWithId:unique_id
                                          name:mapData[@"name"]];
            maps[unique_id] = map;
        } else{
            Map *map = maps[unique_id];
            
            [map updateWithPFObject:mapData];
        }
        
    }];
};

+ (void)deleteMap:(NSString *)unique_id{
    
};

@end
