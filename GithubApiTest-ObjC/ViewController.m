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

@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong, nullable) NSString *userName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - Private methods

- (void)setupUI {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140.0;

    UINib *cellNib = [UINib nibWithNibName:@"MainScreenTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:kMainScreenCellId];
}

- (IBAction)refreshData:(id)sender {
    if (![self isValidUserName:self.userName]) {
        return;
    }

    __weak typeof(self) weakSelf = self;
    [[DataManager sharedInstance] forceLoadReposForUser:self.userName
                                             completion:^(NSArray<Repo *> * _Nullable repos, NSError * _Nullable error) {
        weakSelf.repos = repos;

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (IBAction)changeUser:(id)sender {
    [self showUserAlert];
}

- (void)showUserAlert {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Find repos"
                                                                        message:@"Enter Github user name"
                                                                 preferredStyle:UIAlertControllerStyleAlert];

    __weak typeof(self) weakSelf = self;
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        weakSelf.userNameTextField = textField;
        textField.placeholder = @"Enter user name";
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [controller addAction:cancelAction];

    UIAlertAction *findAction = [UIAlertAction actionWithTitle:@"Find"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.userName = weakSelf.userNameTextField.text;
        [weakSelf fetchDataForUser:weakSelf.userNameTextField.text];
    }];
    [controller addAction:findAction];

    [self presentViewController:controller animated:YES completion:nil];
}

- (void)fetchDataForUser:(nullable NSString *)userName {
    if (![self isValidUserName:userName]) {
        return;
    }

    __weak typeof(self) weakSelf = self;
    [[DataManager sharedInstance] loadReposForUser:userName completion:^(NSArray<Repo *> * _Nullable repos, NSError * _Nullable error) {
        weakSelf.repos = repos;

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (BOOL)isValidUserName:(nullable NSString *)userName {
    if (userName == nil || userName.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incorrect user name"
                                                                       message:@"Try enter another user name."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];

        return NO;
    } else {
        return YES;
    }
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
