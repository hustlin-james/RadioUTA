//
//  SongRequestViewController.m
//  UTARadioIphone
//
//  Created by James Fielder on 6/2/14.
//  Copyright (c) 2014 com.mobi. All rights reserved.
//

#import "SongRequestViewController.h"
#import "AudioPlayerSingleton.h"
#import <Parse/Parse.h>

@interface SongRequestViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIView *contentView;

//Text Fields
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextField *songnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestingTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation SongRequestViewController

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
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    //TODO: unregister these events when dismissing the view controller
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.navigationItem.title = @"Song Request";
    
    
   
}

- (void)viewDidLayoutSubviews{
    //Stuff
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)callUsBtnPressed:(id)sender {
    NSLog(@"callUsBrnPressed");
    NSString *phoneStr = @"tel:8172722651";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
}

- (IBAction)submitBtnPressed:(id)sender {
    
    [self disableFieldsAndBtn];
    if([self.songnameTextField.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Song name missing" message:@"Please enter a song name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        //Send the request to parse.
        NSString *artist = self.artistTextField.text;
        NSString *songName = self.songnameTextField.text;
        NSString *requester = self.requestingTextField.text;
        
        //NSLog(@"Making parse request");
        PFObject *songRequest = [PFObject objectWithClassName:@"SongRequest"];
        songRequest[@"artist"] = artist;
        songRequest[@"songName"] = songName;
        songRequest[@"requester"] =requester;
        
        [songRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your request has been sent." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                NSString *err = [error localizedDescription];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:err delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            [self enableFieldsAndBtn];
        }];
    }
    
    [self enableFieldsAndBtn];
    
}

-(void) disableFieldsAndBtn{
    self.artistTextField.enabled = NO;
    self.songnameTextField.enabled = NO;
    self.requestingTextField.enabled = NO;
    self.submitBtn.enabled = NO;
}

- (void) enableFieldsAndBtn{
    self.artistTextField.enabled = YES;
    self.songnameTextField.enabled = YES;
    self.requestingTextField.enabled = YES;
    self.submitBtn.enabled = YES;
    
    self.artistTextField.text = @"";
    self.songnameTextField.text =@"";
    self.requestingTextField.text = @"";
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
  
    return YES;
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    contentInsets = UIEdgeInsetsMake(60, 0, -60, 0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
