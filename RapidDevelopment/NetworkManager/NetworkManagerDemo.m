//
//  NetworkManagerDemo.m
//  RapidDevelopment
//
//  Created by Sonata on 04/05/15.
//  Copyright (c) 2015 Sonata. All rights reserved.
//

#import "NetworkManagerDemo.h"
#import "AFNetworking.h"
#import <MBProgressHUD.h>

#define APPLE_URL_METALLICA @"https://itunes.apple.com/search?term=metallica"

@interface NetworkManagerDemo ()

@end

@implementation NetworkManagerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"Network Manager";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BasicHttpCall:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_responceWebView loadHTMLString:@"" baseURL:nil];
    
    NSURL *url = [NSURL URLWithString:APPLE_URL_METALLICA];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"responseObject = %@", responseObject);
         NSLog(@"responseObject is class = %@", [responseObject class]);
         [_responceWebView loadHTMLString:[NSString stringWithFormat:@"<html><p>%@</p></html>",responseObject] baseURL:nil];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"failed to get the JSON string!. Error = %@", error);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
    
    [operation start];
    
}
- (IBAction)BasicGETCall:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_responceWebView loadHTMLString:@"" baseURL:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:APPLE_URL_METALLICA
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"response = %@", responseObject);
         [_responceWebView loadHTMLString:[NSString stringWithFormat:@"<html><p>%@</p></html>",responseObject] baseURL:nil];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"failure = %@", error);
     }];
    
}
- (IBAction)BasicPOSTCall:(id)sender {
    
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
