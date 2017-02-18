//
//  ViewController.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test];
}


- (void)test {
    [[DataManager sharedInstance] loadReposForUser:@"msaveleva" completion:^(NSArray<Repo *> * _Nullable repos, NSError * _Nullable error) {
        //
    }];
}


@end
