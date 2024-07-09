//
//  CollectionViewTestViewController.m
//  HelloIOS
//
//  Created by 马壮 on 2024/7/9.
//

#import "CollectionViewTestViewController.h"
#import "Components/EventCollectionViewCell.h"

@interface CollectionViewTestViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *events;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation CollectionViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"plist"];
    self.events = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    [self setupCollectionView];
}

- (void) setupCollectionView {
    // 创建流式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个单元格尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 设置整个 CollectionView 的内边距
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 30, 15);
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // 大屏的重新设置
    if (screenSize.height > 568) {
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 30, 15);
    }
    
    // 单元格之间的间距
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    // 设置可重用单元格标识与单元格类型
    [self.collectionView registerClass:[EventCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
}

#define COL_NUM 3

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    int num = [self.events count] % COL_NUM;
    if (num == 0) {
        return [self.events count] / COL_NUM;
    } else {
        return [self.events count] / COL_NUM + 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return COL_NUM;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSInteger idx = indexPath.section * COL_NUM + indexPath.row;
    
    if (self.events.count <= idx) {
        return cell;
    }
    
    NSDictionary *event = self.events[idx];
    cell.label.text = [event objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:event[@"image"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *event = self.events[indexPath.section * COL_NUM + indexPath.row];
    NSLog(@"select event name : %@", event[@"name"]);
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
