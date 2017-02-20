//
//  RepoMO.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 19/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "RepoMO.h"
#import "Repo.h"

@implementation RepoMO

@dynamic identifier;
@dynamic name;
@dynamic repoDescription;
@dynamic owner;

- (void)configureWith:(Repo *)repo {
    self.identifier = repo.identifier;
    self.name = repo.name;
    self.repoDescription = repo.repoDescription;
    self.owner = repo.owner;
}

@end
