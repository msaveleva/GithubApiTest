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
static NSString * const kOwnerKey = @"owner";
static NSString * const kLoginKey = @"login";

@implementation RepoParser

- (nullable Repo *)createRepoWithDictionary:(NSDictionary *)dictionary {
    Repo *repo = nil;

    int64_t identifier = [dictionary[kIdentifierKey] integerValue];
    NSString *name = dictionary[kNameKey];
    NSString *repoDescription = dictionary[kDescriptionKey];
    NSString *owner = dictionary[kOwnerKey][kLoginKey];

    //TODO: improve check
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }

    if (![repoDescription isKindOfClass:[NSString class]]) {
        repoDescription = @"";
    }

    if (![owner isKindOfClass:[NSString class]]) {
        owner = @"";
    }

    if (name != nil && owner != nil) {
        repo = [[Repo alloc] initWithIdentifier:identifier
                                           name:name
                                repoDescription:repoDescription
                                          owner:owner];
    }

    return repo;
}

@end
