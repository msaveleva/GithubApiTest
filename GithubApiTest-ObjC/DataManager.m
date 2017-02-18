//
//  DataManager.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "DataManager.h"

#import "ConnectionService.h"

#import "UserReposRequest.h"

#import "Repo.h"

#import "RepoParser.h"

@interface DataManager ()

@property (nonatomic, strong) ConnectionService *connectionService;
@property (nonatomic, strong) RepoParser *repoParser;

@end


@implementation DataManager

+ (instancetype)sharedInstance {
    static DataManager *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DataManager new];
    });

    return sharedInstance;
}

#pragma mark - Public methods

- (void)loadReposForUser:(NSString *)userName completion:(void (^)(NSArray <Repo *> * _Nullable, NSError * _Nullable))completion {
    UserReposRequest *userReposRequest = [UserReposRequest createWithUserName:userName];
    [self.connectionService loadDataWithRequest:userReposRequest completion:^(NSArray * _Nullable dataArray, NSError * _Nullable error) {
        //TODO: parse data
    }];
}


#pragma mark - Private methods

- (ConnectionService *)connectionService {
    if (_connectionService == nil) {
        _connectionService = [ConnectionService new];
    }

    return _connectionService;
}

- (RepoParser *)repoParser {
    if (_repoParser == nil) {
        _repoParser = [RepoParser new];
    }

    return _repoParser;
}

@end
