//
//  ViewController.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "Repo.h"
#import "MainScreenTableViewCell.h"

static NSString * const kMainScreenCellId = @"MainScreenCellId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <Repo *> *repos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    [self test];
}


- (void)test {
    __weak typeof(self) weakSelf = self;
    [[DataManager sharedInstance] loadReposForUser:@"msaveleva" completion:^(NSArray<Repo *> * _Nullable repos, NSError * _Nullable error) {
        weakSelf.repos = repos;

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

#pragma mark - Private methods

- (void)setupUI {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140.0;

    UINib *cellNib = [UINib nibWithNibName:@"MainScreenTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:kMainScreenCellId];
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMainScreenCellId];

    if (self.repos.count - 1 >= indexPath.row) {
        Repo *currentRepo = self.repos[indexPath.row];
        [cell configureWithRepo:currentRepo];
    }

    return cell;
}


@end
