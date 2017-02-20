//
//  MainScreenTableViewCell.m
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "MainScreenTableViewCell.h"
#import "Repo.h"

@interface MainScreenTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation MainScreenTableViewCell

- (void)configureWithRepo:(Repo *)repo {
    self.nameLabel.text = repo.name;
    self.descriptionLabel.text = repo.repoDescription;
}

@end
