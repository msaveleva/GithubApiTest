//
//  DataManager.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "DataManager.h"

#import "ConnectionService.h"
#import "StorageService.h"

#import "UserReposRequest.h"

#import "Repo.h"

#import "RepoParser.h"

@interface DataManager ()

@property (nonatomic, strong) ConnectionService *connectionService;
@property (nonatomic, strong) StorageService *storageService;
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
    //First try to load data from cache.
    NSArray <Repo *> *repos = [self.storageService fetchRepos];
    if (repos.count > 0 && [repos.firstObject.owner isEqualToString:userName]) {
        if (completion) {
            completion(repos, nil);
        }
    } else {
        //Load from server if there is no cached data.
        [self loadDataFromServerForUser:userName completion:^(NSArray<Repo *> * _Nullable repos, NSError * _Nullable error) {
            if (completion) {
                completion(repos, error);
            }
        }];
    }
}

- (void)forceLoadReposForUser:(NSString *)userName completion:(void (^)(NSArray<Repo *> * _Nullable, NSError * _Nullable))completion {
    [self loadDataFromServerForUser:userName completion:^(NSArray<Repo *> * _Nullable repos, NSError * _Nullable error) {
        if (completion) {
            completion(repos, error);
        }
    }];
}

- (NSArray <Repo *> *)checkCache {
    NSArray <Repo *> *repos = [self.storageService fetchRepos];

    return repos;
}


#pragma mark - Private methods

- (void)loadDataFromServerForUser:(NSString *)userName completion:(nullable void(^)(NSArray <Repo *> * _Nullable repos, NSError * _Nullable error))completion {
    UserReposRequest *userReposRequest = [UserReposRequest createWithUserName:userName];

    __weak typeof(self) weakSelf = self;
    //TODO: add strongSelf
    [self.connectionService loadDataWithRequest:userReposRequest completion:^(NSArray * _Nullable dataArray, NSError * _Nullable error) {
        NSMutableArray *repos = [NSMutableArray new];
        for (NSDictionary *dictionary in dataArray) {
            Repo *repo = [weakSelf.repoParser createRepoWithDictionary:dictionary];
            if (repo) {
                [repos addObject:repo];
            }
        }

        if (repos.count > 0) {
            [weakSelf.storageService saveRepos:repos];
        }

        if (completion) {
            completion([repos copy], error);
        }
    }];
}

- (ConnectionService *)connectionService {
    if (_connectionService == nil) {
        _connectionService = [ConnectionService new];
    }

    return _connectionService;
}

- (StorageService *)storageService {
    if (_storageService == nil) {
        _storageService = [StorageService new];
    }

    return _storageService;
}

- (RepoParser *)repoParser {
    if (_repoParser == nil) {
        _repoParser = [RepoParser new];
    }

    return _repoParser;
}

@end
