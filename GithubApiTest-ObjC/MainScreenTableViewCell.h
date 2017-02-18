//
//  MainScreenTableViewCell.h
//  GithubApiTest-ObjC
//
//  Created by MariaSaveleva on 18/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Repo;

@interface MainScreenTableViewCell : UITableViewCell

- (void)configureWithRepo:(Repo *)repo;

@end
