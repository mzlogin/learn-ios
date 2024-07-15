//
//  TableViewTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/15.
//

#import "TableViewTestViewController.h"
#import "Components/TableViewCustomCell.h"

#define CellIdentifier @"CellIdentifier"

@interface TableViewTestViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *listTeams;

@property (nonatomic, strong) NSMutableArray *listFilteredTeams;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;

@end

@implementation TableViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    [self filterContentForSearchText:@"" scope:-1];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    // UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = FALSE;
    
    self.searchController.searchBar.scopeButtonTitles = @[@"中文", @"英文"];
    self.searchController.searchBar.delegate = self;
    
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self.searchController.searchBar sizeToFit];
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope {
    if ([searchText length] == 0) {
        self.listFilteredTeams = [NSMutableArray arrayWithArray:self.listTeams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    
    switch (scope) {
        case 0:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
            tempArray = [self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilteredTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
            
        case 1:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@", searchText];
            tempArray = [self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilteredTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
            
        default:
            self.listFilteredTeams = [NSMutableArray arrayWithArray:self.listTeams];
            break;
    }
}

#pragma mark - UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listFilteredTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    NSUInteger row = [indexPath row];
//    
//    NSDictionary *rowDict = self.listTeams[row];
//    cell.textLabel.text = rowDict[@"name"];
//    
//    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@.png", rowDict[@"image"]];
//    cell.imageView.image = [UIImage imageNamed:imagePath];
//    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TableViewCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *rowDict = self.listFilteredTeams[row];
    NSString *imageFile = rowDict[@"image"];
    
    cell.myLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", rowDict[@"name"], imageFile];
    
    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@.png", imageFile];
    
    cell.myImageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    [self filterContentForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
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
