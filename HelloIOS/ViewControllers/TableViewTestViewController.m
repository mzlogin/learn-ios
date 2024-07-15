//
//  TableViewTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/15.
//

#import "TableViewTestViewController.h"
#import "Components/TableViewCustomCell.h"

#define CellIdentifier @"CellIdentifier"

@interface TableViewTestViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *listTeams;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listTeams count];
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
    
    NSDictionary *rowDict = self.listTeams[row];
    cell.myLabel.text = rowDict[@"name"];
    
    NSString *imageFile = rowDict[@"image"];
    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@.png", imageFile];
    
    cell.myImageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
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
