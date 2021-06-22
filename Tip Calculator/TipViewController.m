//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Mary Jiang on 6/22/21.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageControl;
@property (weak, nonatomic) IBOutlet UIView *labelsContainerView;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hideLabels]; //hide labels when we start as there is nothing there
    [_billField becomeFirstResponder]; //pops up with keyboard ready to type into billField
}

- (IBAction)onTap:(id)sender {
    //NSLog(@"hello");
    
    [self.view endEditing:true]; //makes the keyboard go away when user taps on screen
}
- (IBAction)updateLabels:(id)sender {
    //checks to see if bill field is empty, if so will hide labels, if not will check to see if labels are visible or not by checking alpha of the labels, if the billfield is not empty and the labels are not visible will call show labels
    if(self.billField.text.length == 0){
        [self hideLabels];
    }else if(self.labelsContainerView.alpha == 0){
        [self showLabels];
    }
    
    //gets a selected tip percentage from the segmented
    double tipPercentages[] = {0.15, 0.2, 0.25};
    double tipPercentage = tipPercentages[self.tipPercentageControl.selectedSegmentIndex];
    
    //calculate tip based on selected tip
    double bill = [self.billField.text doubleValue];
    double tip = bill * tipPercentage;
    double total = bill + tip;
    
    //display calculated tip and total
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}

- (void)hideLabels{
    [UIView animateWithDuration:0.2 animations:^{ //animates the following block over .2 seconds, causes gradual transistion
        CGRect billFrame = self.billField.frame; //frame of the billfield
        billFrame.origin.y += 200; //move down (adding to y moves down)
        
        self.billField.frame = billFrame; //sets frame property of billField to our newly moved down frame
        
        CGRect labelsFrame = self.labelsContainerView.frame; //frame of the labels
        labelsFrame.origin.y += 200; //move down
        
        self.labelsContainerView.frame = labelsFrame; //sets frame property of the labels to new moved down frame
        
        self.labelsContainerView.alpha = 0; //when alpha is 0 not visible, so this over time fades away the labels
        
    }];
}

- (void)showLabels{
    //this is the same thing as hide labels except moving labels up and making them visible
    [UIView animateWithDuration:0.2 animations:^{
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y -= 200;
        
        self.billField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y -= 200;
        
        self.labelsContainerView.frame = labelsFrame;
        
        self.labelsContainerView.alpha = 1;
        
    }];
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
