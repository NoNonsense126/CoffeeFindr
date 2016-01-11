//
//  DetailViewController.h
//  CoffeeFindr
//
//  Created by Wong You Jing on 10/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeePlace.h"

@interface DetailViewController : UIViewController

@property CoffeePlace *coffeePlace;
@property CLLocation *currentLocation;

@end
