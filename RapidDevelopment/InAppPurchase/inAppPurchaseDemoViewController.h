//
//  inAppPurchaseDemoViewController.h
//  RapidDevelopment
//
//  Created by Sonata on 04/05/15.
//  Copyright (c) 2015 Sonata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inAppPurchaseDemoViewController : UIViewController

@property (strong,nonatomic) NSArray *products;
@property (strong,nonatomic) NSUserDefaults *defaults;

@property (weak, nonatomic) IBOutlet ADBannerView *adView;
@property (weak, nonatomic) IBOutlet UILabel *itemPurchaseLbl;


@end
