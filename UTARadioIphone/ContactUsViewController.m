//
//  ContactUsViewController.m
//  radiouta
//
//  Created by James Fielder on 6/4/14.
//  Copyright (c) 2014 com.mobi. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ContactUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Contact Us!";
}

- (void) viewDidLayoutSubviews{
    NSString *textViewStr = @"";
    textViewStr = [textViewStr stringByAppendingFormat:@"%@\n%@\n\n%@\n%@", @"UTA Radio", @"radio@uta.edu", @"MOBI", @"uta.mobi@gmail.com"];
    [self.textView setText:textViewStr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
