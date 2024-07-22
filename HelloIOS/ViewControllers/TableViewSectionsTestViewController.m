//
//  TableViewSectionsTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/22.
//

#import "TableViewSectionsTestViewController.h"

#define CellIdentifier @"CellIdentifier"

@interface TableViewSectionsTestViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *dictData;
@property (nonatomic, strong) NSArray *listGroupName;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewSectionsTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"team_dictionary" ofType:@"plist"];
    self.dictData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *tempList = [self.dictData allKeys];
    self.listGroupName = [tempList sortedArrayUsingSelector:@selector(compare:)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *groupName = self.listGroupName[section];
    NSArray *listTeams = self.dictData[groupName];
    return [listTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *groupName = self.listGroupName[section];
    NSArray *listTeams = self.dictData[groupName];
    
    cell.textLabel.text = listTeams[row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.listGroupName count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *groupName = self.listGroupName[section];
    return groupName;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    for (NSString *item in self.listGroupName) {
        NSString *title = [item substringToIndex:1];
        [listTitles addObject:title];
    }
    return listTitles;
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
