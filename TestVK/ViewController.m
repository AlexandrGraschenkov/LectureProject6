//
//  ViewController.m
//  TestVK
//
//  Created by Alexander on 20.03.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "ImageViewerController.h"
#import "WallCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    BOOL avatarLoaded;
    BOOL infoLoaded;
    NSMutableArray *wallData;
}
@property (nonatomic, weak) IBOutlet UIImageView *avatarImgView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (nonatomic, weak) IBOutlet UIButton *avatarButt;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, weak) IBOutlet UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.avatarButt.enabled = NO;
    avatarLoaded = NO;
    infoLoaded = NO;
    
    self.avatarImgView.layer.masksToBounds = YES;
    self.avatarImgView.layer.cornerRadius = 50;
}

- (IBAction)buttPressed:(id)sender{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadDataIfNecessary];
}

- (void)reloadDataIfNecessary
{
    if(!avatarLoaded){
        [[DataManager sharedInstance] getAsyncAvatarWithSender:self selector:@selector(avatarLoaded:)];
        [self.activity startAnimating];
    }
    if(!infoLoaded){
        [[DataManager sharedInstance] getAsyncInfoWithSender:self selector:@selector(infoLoaded:)];
        [self.activity startAnimating];
    }
    if(!wallData){
        [[DataManager sharedInstance] getAsyncWallDataWithSender:self selector:@selector(wallLoaded:)];
        [self.activity startAnimating];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[DataManager sharedInstance] stopAsyncOperations];
}

- (void)avatarLoaded:(UIImage*)image
{
    self.avatarImgView.image = image;
    self.avatarButt.enabled = YES;
    avatarLoaded = YES;
    
    if(infoLoaded)
        [self.activity stopAnimating];
}

- (void)infoLoaded:(NSDictionary*)dic
{
    self.nameLabel.text = dic[@"name"];
    self.statusLabel.text = dic[@"status"];
    self.cityLabel.text = dic[@"city"];
    infoLoaded = YES;
    
    if(avatarLoaded)
        [self.activity stopAnimating];
}

- (void)wallLoaded:(NSArray*)arr
{
    wallData = [arr mutableCopy];
    [self.table reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showAvatar"]){
        ImageViewerController *nextController = segue.destinationViewController;
        nextController.img = self.avatarImgView.image;
    }
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return wallData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.data = wallData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WallCell heightWithData:wallData[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [wallData removeObjectAtIndex:indexPath.row];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        
    }
}

@end
