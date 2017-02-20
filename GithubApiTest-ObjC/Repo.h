//
//  Repo.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

- (int64_t)identifier;
- (NSString *)name;
- (NSString *)repoDescription;
- (NSString *)owner;

- (instancetype)initWithIdentifier:(int64_t)identifier
                              name:(NSString *)name
                   repoDescription:(NSString *)repoDescription
                             owner:(NSString *)owner;

@end
