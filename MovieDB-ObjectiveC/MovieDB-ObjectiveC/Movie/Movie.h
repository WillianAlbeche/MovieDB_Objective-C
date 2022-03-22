//
//  Movie.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 22/03/22.
//

#ifndef Movie_h
#define Movie_h

@interface Movie: NSObject{
    NSString *title;
    NSString *description;
    NSString *genre[10];
    double rating;
}

-(id)initWithTitle:(NSString*)title
description:(NSString*)description
rating:(double)rating;
- (void)setGenre:(NSString*)genre;
- (NSString*)getTtitle;
- (NSString*)getDescription;
- (NSString*)getGenre;
- (double*)getRating;
@end


#endif /* Movie_h */
