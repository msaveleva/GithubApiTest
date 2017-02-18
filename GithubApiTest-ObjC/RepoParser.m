//
//  RepoParser.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "RepoParser.h"
#import "Repo.h"

static NSString * const kIdentifierKey = @"id";
static NSString * const kNameKey = @"name";
static NSString * const kDescriptionKey = @"description";

@implementation RepoParser

- (nullable Repo *)createRepoWithDictionary:(NSDictionary *)dictionary {
    Repo *repo = nil;

    int64_t identifier = [dictionary[kIdentifierKey] integerValue];
    NSString *name = dictionary[kNameKey];
    NSString *repoDescription = dictionary[kDescriptionKey];

    if (name != nil && repoDescription != nil) {
        repo = [[Repo alloc] initWithIdentifier:identifier
                                           name:name
                                repoDescription:repoDescription];
    }

    return repo;
}

@end
