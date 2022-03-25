//
//  ViewController.m
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 22/03/22.
//

#import "ViewController.h"
#import "Api.h"
#import "ApiDelegate.h"
#import "Parser.h"
#import "Movie.h"
#import "DetailsViewController.h"
#import "TableViewCell.h"


@interface ViewController () <ApiDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property Api* api;
@property NSArray* popularMovies;
@property NSArray* nowPlayingMovieList;

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;


@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.api = [[Api alloc] init];
    self.api.delegate = self;
    [self.api fetchMovieList:FetchPopular];
    [self.api fetchMovieList:FetchPlaying];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController* detailsVC = [segue destinationViewController];
    
    if (detailsVC != nil) {
        [detailsVC loadViewIfNeeded];
   //     [detailsVC setMovie:sender];
    }
}

- (void)fetchFailedWithError:(nonnull NSError *)error {
    NSLog(@"FETCH FAILED");
    NSLog(@"%@", error.localizedDescription);
}

- (void)receivedMovieList:(NSData *)json from:(FetchOption)option {
    NSLog(@"%@", json.description);
    
    NSError* error = nil;
    NSArray* movies = [Parser movieListFromJSON:json error:&error];
    
    if (error) {
        NSLog(@"Parse Error");
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    switch (option) {
        case FetchPopular:
            NSLog(@"-VVV- FETCH POPULAR SUCCESS");
            self.popularMovies = movies;
            break;
            
        case FetchPlaying:
            NSLog(@"-VVV- FETCH NOW PLAYING SUCCESS");
            self.nowPlayingMovieList = movies;
            break;
            
        default:
            NSLog(@"-!!!- UNSUPPORTED FETCH OPTION");
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.moviesTableView reloadData];
    });
}
- (void)receivedMovieDetails:(nonnull NSData *)json for:(nonnull Movie *)movie {
    NSError* error = nil;
    
    [Parser detailsForMovie:movie from:json error:&error];
    
    if (error != nil) {
        NSLog(@"-XXX- FETCH DETAILS ERROR");
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self performSegueWithIdentifier:@"ShowMovie" sender:movie];
//    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    }
    
    Movie* movie;
    switch (indexPath.section) {
        case 0:
            movie = self.popularMovies[indexPath.row];
            break;
            
        default:
            movie = self.nowPlayingMovieList[indexPath.row];
            break;
    }
    
//    if (movie != nil) {
//        [cell populateCellWithMovie:movie];
//    }
    
    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 10;
//}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            NSLog(@"-!!!- SECTION: POPULAR --- COUNT: %d", (int)self.popularMovies.count);
            return 2;
            break;
            
        default:
            NSLog(@"-!!!- SECTION: NOW PLAYING --- COUNT: %d", (int)self.nowPlayingMovieList.count);
            return self.nowPlayingMovieList.count;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie* movie;

    switch (indexPath.section) {
        case 0:
            movie = self.popularMovies[indexPath.row];
            break;

        default:
            movie = self.nowPlayingMovieList[indexPath.row];
            break;
    }

    if (movie != nil) {
       // if (movie.genre == nil) {
       //     [self.api fetchMovieDetails:movie];
      //  } else {
 //           [self performSegueWithIdentifier:@"ShowMovie" sender:movie];
        DetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewControllerID2"];
    [self.navigationController pushViewController:vc animated:YES];
      //  }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table View Section Headers
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width, 22)];
    
    [label setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold]];
    
    switch (section) {
        case 0:
            NSLog(@"-!!!- SECTION: POPULAR");
            [label setText:@"Popular movies"];
            break;
            
        default:
            NSLog(@"-!!!- SECTION: NOW PLAYING");
            [label setText:@"Now playing"];
            break;
    }
    
    [header addSubview:label];
    
    return header;
}


@end
