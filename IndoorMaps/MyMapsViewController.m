//
//  SecondViewController.m
//  IndoorMaps
//
//  Created by David Zheng on 7/27/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import "MyMapsViewController.h"
#import "MapLoadSave.h"
#import "MapViewController.h"

@interface MyMapsViewController ()

@end

@implementation MyMapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [maps count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MyMapsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    Map *map = [maps objectAtIndex:indexPath.row];
    cell.textLabel.text = map.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMapSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MapViewController *destViewController = segue.destinationViewController;
        Map *map = [maps objectAtIndex:indexPath.row];
        if (![map isFullyLoaded])
            [MapLoadSave loadFullMap:(int)indexPath.row];
        destViewController.map = map;
    }
}

@end
