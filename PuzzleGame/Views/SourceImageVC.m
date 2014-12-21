
#import "SourceImageVC.h"
#import "Config.h"

@interface SourceImageVC ()

@end

@implementation SourceImageVC

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
    
    if (currentImage) {
        [sourceImageView setImage:[UIImage imageWithCGImage:currentImage]];
    }
}


-(void)backBtnPressed:(id)sender{
//    [self dismissModalViewControllerAnimated:YES];
    
    
    [self dismissViewControllerAnimated: YES completion: ^{}];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
