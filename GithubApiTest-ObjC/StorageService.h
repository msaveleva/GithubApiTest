//
//  StorageService.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 19/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Repo; 

@interface StorageService : NSObject

- (void)saveRepos:(NSArray <Repo *> *)repos;
- (NSArray <Repo *> *)fetchRepos;

@end
