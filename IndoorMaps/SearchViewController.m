//
//  SearchViewController.m
//  IndoorMaps
//
//  Created by David Zheng on 7/27/15.
//  Copyright (c) 2015 solid. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"
#import "MapDetail.h"

@interface SearchViewController () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults; // Filtered search results

@end

#pragma mark -

@implementation SearchViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mapDetails = [MapDetail mapDetails];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.mapDetails count]];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    NSArray *sourceArray = self.searchController.active ? self.searchResults : self.mapDetails;
    
    UIViewController *destinationController = segue.destinationViewController;
    MapDetail *mapDetail = sourceArray[indexPath.row];
    ((DetailViewController *)destinationController).mapDetail = mapDetail;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.active) {
        return [self.searchResults count];
    } else {
        return [self.mapDetails count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DetailCell";
    
    // Dequeue a cell from self's table view.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    MapDetail *mapDetail;
    
    if (self.searchController.active) {
        mapDetail = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        mapDetail = [self.mapDetails objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = mapDetail.name;
    return cell;
}


#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    
    [self updateFilteredContentForDetailName:searchString];
    
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

// Workaround for bug: -updateSearchResultsForSearchController: is not called when scope buttons change
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}


#pragma mark - Content Filtering

- (void)updateFilteredContentForDetailName:(NSString *)mapDetailName {
    
    // Update the filtered array based on the search text and scope.
    if ((mapDetailName == nil) || [mapDetailName length] == 0) {
        // If there is no search string and the scope is "All".
        
        self.searchResults = [self.mapDetails mutableCopy];
        
        return;
    }
    
    
    [self.searchResults removeAllObjects]; // First clear the filtered array.
    
    for (MapDetail *detail in self.mapDetails) {
        NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
        NSRange detailNameRange = NSMakeRange(0, detail.name.length);
        NSRange foundRange = [detail.name rangeOfString:mapDetailName options:searchOptions range:detailNameRange];
        if (foundRange.length > 0) {
            [self.searchResults addObject:detail];
        }
        
    }
}

@end
