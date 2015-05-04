//
//  inAppPurchaseDemoViewController.m
//  RapidDevelopment
//
//  Created by Sonata on 04/05/15.
//  Copyright (c) 2015 Sonata. All rights reserved.
//

#import "inAppPurchaseDemoViewController.h"
#import <StoreKit/StoreKit.h>

@interface inAppPurchaseDemoViewController () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@end

@implementation inAppPurchaseDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // SKPaymentQueue
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isPro = [defaults boolForKey:@"isPro"];
    
    if (!isPro) {
        // Show the ads
        [self fetchProducts];
        self.buyButton.enabled = YES;
        
    } else {
        // Hide ads
        adsView.alpha = 0.0;
        self.buyButton.enabled = NO;
    }
    
}

-(void)Purchase {
    self.titleLabel.text = @"The item has been purchased.";
}

-(void)fetchProducts {
    NSSet *set = [NSSet setWithArray:@[@"com.sonata-software.rapidDevelopment.removeAd"]];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}

-(void)Buy:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UnlockAppFeature:(id)sender {
    SKProduct *prod = [products objectAtIndex:0];
    [self Buy:prod];
}

#pragma mark - SKProductsRequestDelegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    products = response.products;
    NSLog(@"product is available");
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Error ; %@", error);
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    for (SKPaymentTransaction *tx in transactions) {
        switch (tx.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [[SKPaymentQueue defaultQueue] finishTransaction:tx];
                adsView.alpha = 0.0;
                [defaults setBool:YES forKey:@"isPro"];
                self.buyButton.enabled = NO;
                break;
                
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue] finishTransaction:tx];
                NSLog(@"Error : %@", tx.error);
                break;
                
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] finishTransaction:tx];
                break;
                
            default:
                break;
        }
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
