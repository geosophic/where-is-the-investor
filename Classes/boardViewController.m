//
//  monkeyViewController.m
//  monkey
//
//  Created by Robert Diamond on 4/9/11.
//  Copyright 2011 none. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "monkeyViewController.h"
#import "GeosophicServiceController.h"
#import "InvestorViewController.h"
#import "InvestorType.h"
#import "CustomerViewController.h"
#import "CrashViewController.h"
#import "SettingsViewController.h"

#define rND_0_1 ((double)arc4random() / ARC4RANDOM_MAX);

@implementation monkeyViewController
@synthesize geosophicButton;
@synthesize timeRemaining;
@synthesize where;
@synthesize cashRemaining;
@synthesize animatedMessage;

bool firstPlay = true;
double ARC4RANDOM_MAX = 0x100000000;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	CGColorSpaceRef csp = CGColorSpaceCreateDeviceRGB();
	CGColorRef col1 = [UIColor cyanColor].CGColor;
	CGFloat comps[4] = {0};
	memcpy(comps, CGColorGetComponents(col1), 4 * sizeof(CGFloat));
	comps[0] = 0.75;
	CGColorRef col2 = CGColorCreate(csp, comps);
    comps[0] = 0;
    for (int i=0; i < 3; ++i) comps[i] *= .7;
    col1 = CGColorCreate(csp, comps);
	//CGColorRef col2 = [UIColor whiteColor].CGColor;
	const CGColorRef cols[] = {col1, col2};
	CFArrayRef collist = CFArrayCreate(nil, (const void **)cols, sizeof(cols)/sizeof(CGColorRef), NULL);
	CGFloat locs[] = {.99,0.0};
	
	UIButton *b1 = (UIButton *)[self.view viewWithTag:1001];
	CGContextRef ctx = CGBitmapContextCreate(nil, b1.bounds.size.width, b1.bounds.size.height, 8, 4 * b1.bounds.size.width, csp, kCGImageAlphaPremultipliedLast);
	CGGradientRef grad = CGGradientCreateWithColors(csp, collist, locs);
	CGContextDrawRadialGradient(ctx, grad, CGPointMake(b1.bounds.size.width/2,b1.bounds.size.height/2), 1, CGPointMake(b1.bounds.size.width/2,b1.bounds.size.height/2), b1.bounds.size.width/2, kCGGradientDrawsAfterEndLocation);
	CGImageRef bg = CGBitmapContextCreateImage(ctx);
	UIImage *im = [UIImage imageWithCGImage:bg];
	
	for (int i=1001; i < 1010; ++i) {
		UIButton *b = (UIButton *)[self.view viewWithTag:i];
		[b addTarget:self action:@selector(guess:) forControlEvents:UIControlEventTouchUpInside];
		[b setBackgroundImage:im forState:UIControlStateNormal];
	}
	CGImageRelease(bg);
	CFRelease(collist);
	CGColorRelease(col2);
    CGColorRelease(col1);
	CGGradientRelease(grad);
	CGColorSpaceRelease(csp);
    stage = 0;
	[self resetGame];
	
	NSError *error = nil;
	NSURL *noiseURL = [[NSBundle mainBundle] 
					   URLForResource:@"buzzer" 
					   withExtension:@"mp3"];
	avp = [[AVAudioPlayer alloc] 
						  initWithContentsOfURL:noiseURL error:&error];
	if (error) {
		NSLog(@"failed to load sound: %@", [error localizedDescription]);
		return;
	}
	noiseURL = [[NSBundle mainBundle] 
				URLForResource:@"win" 
				withExtension:@"m4a"];
	win = [[AVAudioPlayer alloc] 
		   initWithContentsOfURL:noiseURL error:&error];
	[avp setDelegate:self];
	[avp setVolume:1.0];
	[avp prepareToPlay];
	[win setDelegate:self];
	[win setVolume:1.0];
	[win prepareToPlay];
	
	[self becomeFirstResponder];
    firstPlay = true;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (motion == UIEventSubtypeMotionShake) {
		[self startGame];
	}
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (motion == UIEventSubtypeMotionShake) {
		[self startGame];
	}
}

- (void) viewDidUnload {
	[avp release];
	[win release];
    [self setCashRemaining:nil];
    [self setAnimatedMessage:nil];
    [self setGeosophicButton:nil];
    [self setGeosophicButton:nil];
	[super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void)resetGame {
    [UIView animateWithDuration:1.0 animations:^{
        animatedMessage.text = @"";
    }];
    if (stage != 0 && equity_remaining <= 0) {
        stage = 0;
        CrashViewController* crashView = [[CrashViewController alloc] initWithCash:cash_remaining withEquity:equity_remaining];
        [self presentModalViewController:crashView animated:TRUE];
        [self resetGame];
    } else {
        CABasicAnimation *trans = [CABasicAnimation animation];
        trans.keyPath = @"transform.scale";
        trans.repeatCount = HUGE_VALF;
        trans.duration = 0.5;
        trans.autoreverses = YES;
        trans.removedOnCompletion = NO;
        trans.fillMode = kCAFillModeForwards;
        trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        trans.fromValue = [NSNumber numberWithFloat:0.9];
        trans.toValue = [NSNumber numberWithFloat:1.1];
        for (int i=1001; i < 1010; ++i) [(UIButton *)[self.view viewWithTag:i] setEnabled:NO];
        if (stage == 0) {
            equity_remaining = 100;
            cash_remaining = 2000;
        }
        stage++;
        [self startGame];
    }
}

- (void)startGame {
    for (int i=1001; i < 1010; ++i) {
        UIButton *b = (UIButton *)[self.view viewWithTag:i];
        [b setImage:nil forState:UIControlStateNormal];
        [b setTitle:@"?" forState:UIControlStateNormal];
        b.enabled = YES;
    }
    NSUInteger isCorrect = 0;
    SecRandomCopyBytes(kSecRandomDefault, sizeof(NSUInteger), (void *)&isCorrect);
    hiddenInvestor = isCorrect % 9;
    hiddenCustomer = hiddenInvestor;
    while (hiddenCustomer == hiddenInvestor) {
        SecRandomCopyBytes(kSecRandomDefault, sizeof(NSUInteger), (void *)&isCorrect);
        hiddenCustomer = isCorrect % 9;
    }
    [where setText:[self getTitleFromStage:stage]];
    if (stage == 1) {
        [timeRemaining setText:[NSString stringWithFormat:@"%.3f %%", equity_remaining]];
        [cashRemaining setText:[NSString stringWithFormat:@"%d $", cash_remaining]];
    }
}

- (BOOL)canBecomeFirstResponder { return YES; }

- (void)guess:(id)sender {
	UIButton *guessed = (UIButton *)sender;
	guessed.enabled = NO;
	
	CATransition *trans = [[CATransition alloc] init];
	trans.duration = 0.25;
	trans.type = kCATransitionFade;
	[guessed.layer addAnimation:trans forKey:@"Fade"];
	[trans release];
	[CATransaction begin];
	if (guessed.tag - 1001 == hiddenInvestor) {
		[guessed setTitle:@"" forState:UIControlStateNormal];
		[guessed setImage:[UIImage imageNamed:@"money_bag"] forState:UIControlStateNormal];
        firstPlay = false;
		[win play];
        NSNumber* investorEquity;
        NSNumber* investorFunds;
        NSNumber* investorType;
        [self getInvestorFund:&investorType giveFunds:&investorFunds getEquity:&investorEquity inStage:stage];
        equity_remaining = equity_remaining - (equity_remaining * [investorEquity floatValue]/100.0);
        cash_remaining = cash_remaining + [investorFunds intValue];
        InvestorViewController* investorView = [[InvestorViewController alloc] initWithStage:stage withInvestor:investorType withFunds:investorFunds withEquity:investorEquity withTotalCash:cash_remaining withTotalEquity:equity_remaining];
        [self presentModalViewController:investorView animated:FALSE];
        [timeRemaining setText:[NSString stringWithFormat:@"%.3f %%", (equity_remaining <= 0? 0 : equity_remaining)]];
        [cashRemaining setText:[NSString stringWithFormat:@"%d $", cash_remaining]];
        if (stage == 5) {
            stage = 0;
        }
        [self resetGame];
	} else {
        if (guessed.tag - 1001 == hiddenCustomer) {
            [guessed setTitle:@"" forState:UIControlStateNormal];
            [guessed setImage:[UIImage imageNamed:@"money_bag"] forState:UIControlStateNormal]; 
            [win play];
            NSNumber* customerFund = [self getCustomerFund:stage];
            int customerAdding = [customerFund intValue];
            [UIView animateWithDuration:1.0 animations:^{
                UIColor *newColor = [UIColor blueColor];
                animatedMessage.textColor = newColor;
                animatedMessage.text = [NSString stringWithFormat:@"+%d $", customerAdding];
            }];
            cash_remaining = cash_remaining + customerAdding;
            CustomerViewController* customerView = [[CustomerViewController alloc] initWithStage:stage withFunds:customerFund withCurrentCash:cash_remaining withCurrentEquity:equity_remaining];
            [self presentModalViewController:customerView animated:FALSE];
            [cashRemaining setText:[NSString stringWithFormat:@"%d $", cash_remaining]];
        } else {
            [guessed setTitle:@"×" forState:UIControlStateNormal];
            int cash_lost = [self getCashSubstractFactor:stage];
            cash_remaining = cash_remaining - cash_lost;
            [UIView animateWithDuration:1.0 animations:^{
                UIColor *newColor = [UIColor redColor];
                animatedMessage.textColor = newColor;
                animatedMessage.text = [NSString stringWithFormat:@"-%d $", cash_lost];
            }];
            if (cash_remaining <= 0) {
                stage = 0;
                CrashViewController* crashView = [[CrashViewController alloc] initWithCash:cash_remaining withEquity:equity_remaining];
                [self presentModalViewController:crashView animated:FALSE];
                [self resetGame];
            } else {
                [cashRemaining setText:[NSString stringWithFormat:@"%d $", cash_remaining]];
            }
            [avp stop];
            [avp prepareToPlay];
            [avp play];
        }
	}
	[CATransaction commit];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (float) getSubstractFactor:(int) currentStage
{
    switch (currentStage) {
        case 1:
            return 3.125;
            break;
        case 2:
            return 4.375;
            break;
        case 3:
            return 5;
            break;
        case 4:
            return 6.25;
            break;
        default:
            return 0;
            break;
    }
}

- (int) getCashSubstractFactor:(int) currentStage
{
    int factor;
    double random = rND_0_1;
    
    switch (currentStage) {
        case 1:
            factor = 800;
            break;
        case 2:
            factor = 4000;
            break;
        case 3:
            factor = 15000;
            break;
        case 4:
            factor = 40000;
            break;
        case 5:
            factor = 250000;
            break;
        default:
            factor = 0;
            break;
    }
    
    NSNumber* numberAllocator = [NSNumber numberWithDouble:(random * factor)];
    return [numberAllocator intValue];
}

- (NSString*) getTitleFromStage:(int) currentStage
{
    switch (currentStage) {
        case 1:
            return @"Friends, Family and Fools";
            break;
        case 2:
            return @"Seed";
            break;    
        case 3:
            return @"Series A";
            break;
        case 4:
            return @"Series B";
            break;
        case 5:
            return @"IPO";
            break;
        default:
            return 0;
            break;
    }
}

- (void) getInvestorFund:(NSNumber**) currentInvestor giveFunds:(NSNumber**) funds getEquity:(NSNumber**) equity inStage:(int) currentStage
{
    double random = rND_0_1;
    if (random <= [self getAngelInvestorProbability:currentStage]) {
        *currentInvestor = [NSNumber numberWithInt:ANGEL];
    } else {
        *currentInvestor = [NSNumber numberWithInt:SHARK];
    }
    
    random = rND_0_1;
    *funds = [NSNumber numberWithDouble:([self getInvestorFundingBase:currentStage] * random)];
    random = rND_0_1;
    *equity = [NSNumber numberWithDouble:[self getInvestorEquity:currentStage withRandom:random withInvestor:[*currentInvestor intValue]]];
}

-(NSNumber*) getCustomerFund:(int) currentStage
{
    double random = rND_0_1;
    switch (currentStage) {
        case 1:
            return [NSNumber numberWithDouble:(random * 5000)];
            break;
        case 2:
            return [NSNumber numberWithDouble:(random * 100000)];
            break;
        case 3:
            return [NSNumber numberWithDouble:(random * 250000)];
            break;
        case 4:
            return [NSNumber numberWithDouble:(random * 500000)];
            break;
        case 5:
            return [NSNumber numberWithDouble:(random * 1000000)];
            break;
        default:
            return 0;
            break;
    }
  
}

-(double) getAngelInvestorProbability:(int) currentStage
{
    switch (currentStage) {
        case 1:
            return 0.2;
            break;
        case 2:
            return 0.35;
            break;
        case 3:
            return 0.5;
            break;
        case 4:
            return 0.65;
            break;
        case 5:
            return 0.8;
            break;
        default:
            return 0;
            break;
    }
}

-(double) getInvestorFundingBase:(int) currentStage
{
    switch (currentStage) {
        case 1:
            return 10000.0;
            break;
        case 2:
            return 200000.0;
            break;
        case 3:
            return 500000.0;
            break;
        case 4:
            return 2000000.0;
            break;
        case 5:
            return 10000000.0;
            break;
        default:
            return 0;
            break;
    }
}

-(double) getInvestorEquity:(int) currentStage withRandom:(double) randomValue withInvestor:(int) investorType
{
    switch (currentStage) {
        case 1:
            switch (investorType) {
                case ANGEL:
                    return (randomValue * 10) + 1;
                    break;
                case SHARK:
                    return (randomValue * 10) + 8;
                default:
                    return 0;
                    break;
            }
            break;
        case 2:
            switch (investorType) {
                case ANGEL:
                    return (randomValue * 15) + 8;
                    break;
                case SHARK:
                    return (randomValue * 20) + 15;
                default:
                    return 0;
                    break;
            }
            break;
        case 3:
            switch (investorType) {
                case ANGEL:
                    return (randomValue * 25) + 10;
                    break;
                case SHARK:
                    return (randomValue * 30) + 15;
                default:
                    return 0;
                    break;
            }
            break;
        case 4:
            switch (investorType) {
                case ANGEL:
                    return (randomValue * 25) + 20;
                    break;
                case SHARK:
                    return (randomValue * 25) + 25;
                default:
                    return 0;
                    break;
            }
            break;
        case 5:
            switch (investorType) {
                case ANGEL:
                    return (randomValue * 30) + 20;
                    break;
                case SHARK:
                    return (randomValue * 45) + 25;
                default:
                    return 0;
                    break;
            }
            break;
        default:
            return 0;
            break;
    }

}

- (IBAction)displaySettings:(id)sender
{
    SettingsViewController* settingsView = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self presentModalViewController:settingsView animated:TRUE];
}

- (void)dealloc {
    [cashRemaining release];
    [animatedMessage release];
    [geosophicButton release];
    [geosophicButton release];
    [super dealloc];
}
						 

@end
