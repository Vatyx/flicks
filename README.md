# Project 1 - *Flicks*

<img src='http://i.imgur.com/tvznpKW.png' title='Icon' width='150px' alt='Icon' />

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **9.5** hours spent in total (**8** for Part 1, **1.5** for Part 2)

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User can select from a tab bar for either Now Playing or Top Rated movies.
- [x] User can view movie details by tapping on a cell.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:

- [x] User can also select from a tab bar for Popular and Upcoming as well.
- [x] Similar movies to the movie clicked are displayed as well
- [x] If a similar movie is tapped, another view will open with the information of that movie being displayed. The user can click on as many similar movies as they want.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Being app to see showtimes for a movie at theaters around you and purchase tickets for the movie online.
2. Allowing the user to customize the UI of the main view.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

Unfortunately imgur made my gif into a gifv which can't be seen in page on Github.

View the walkthrough [here](http://i.imgur.com/JSjFq1O.gifv)

[Part 2](http://i.imgur.com/1Ij5Tup.gifv)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The screen tearing is due to running OSX on a virtual machine. Although the virtual machine I am using now is better (VMWare instead of VirtualBox) than what I used on the prework. The tearing is still there and there isn't much I can do about it.

Implementing a scrolling view for the detailed movie view was quite tough to get it the way I wanted it to be.

I wasn't able to change the selection style of my cells due to using CollectionView

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
