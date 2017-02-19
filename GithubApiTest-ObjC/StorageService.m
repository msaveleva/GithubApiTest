//
//  StorageService.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 19/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "StorageService.h"

#import "Repo.h"
#import "RepoMO.h"

#import "Constants.h"

static NSString * const kModelName = @"GithubApiTest_ObjC";

@interface StorageService ()

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) NSManagedObjectContext *fetchingObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *savingObjectContext;

@end

@implementation StorageService

#pragma mark - Public methods

- (void)saveRepos:(NSArray <Repo *> *)repos {
    for (Repo *repo in repos) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:kRepoEntityName
                                                  inManagedObjectContext:self.savingObjectContext];
        RepoMO *repoObject = [[RepoMO alloc] initWithEntity:entity
                             insertIntoManagedObjectContext:self.savingObjectContext];
        [repoObject configureWith:repo];
    }

    NSError *savingError = nil;
    if (![self.savingObjectContext save:&savingError]) {
        NSAssert(NO, @"Error saving context: %@, %@", [savingError localizedDescription], [savingError userInfo]);
    }
}

- (NSArray <Repo *> *)fetchRepos {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kRepoEntityName];
    request.fetchBatchSize = 20;

    NSError *fetchingError;
    NSArray <RepoMO *> *reposObjects = [self.fetchingObjectContext executeFetchRequest:request
                                                                                 error:&fetchingError];
    if (fetchingError) {
        NSAssert(NO, @"Error fetching context: %@, %@", [fetchingError localizedDescription], [fetchingError userInfo]);
    }

    NSMutableArray <Repo *> *repos = [NSMutableArray arrayWithCapacity:reposObjects.count];
    for (RepoMO *repoObject in reposObjects) {
        Repo *repo = [[Repo alloc] initWithIdentifier:repoObject.identifier
                                                 name:repoObject.name
                                      repoDescription:repoObject.repoDescription];
        if (repo) {
            [repos addObject:repo];
        }
    }

    return [repos copy];
}

#pragma mark - Private methods

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:kModelName];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull storeDescription, NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Can't load persistent stores");
                }
            }];
        }
    }

    return _persistentContainer;
}

- (NSManagedObjectContext *)savingObjectContext {
    if (_savingObjectContext == nil) {
        _savingObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _savingObjectContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator;
    }

    return _savingObjectContext;
}

- (NSManagedObjectContext *)fetchingObjectContext {
    if (_fetchingObjectContext == nil) {
        _fetchingObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _fetchingObjectContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator;
    }

    return _fetchingObjectContext;
}

@end
