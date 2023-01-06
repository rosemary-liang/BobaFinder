# BobaFinder

An iOS mobile application for boba lovers who want to find nearby boba places.

## Technologies Used

- Swift (no third-party libraries or SDK's used)
- Foursquare Place API 
    - Place Search
    - Get Place Photos
    - Get Place Tips



## Features

- Users can search for boba places near a specified zipcode
- Users can view a collection view of boba places near their zipcode
- Users can view full details of a boba place
- Users can add a boba place to their favorites
- Users can remove a boba place from their favorites


## Stretch Features

- Users can view the app in landscape mode
- Users can view boba places in a map view
- Users can click a button to get navigation directions to a boba place


## Preview

**SearchVC with alerts**\
![2023-01-05_14-48-54 (1)](https://user-images.githubusercontent.com/95596680/210895750-6820af18-09f0-4861-acd7-3a73db706516.gif)

**PlacesListVC with Search Feature**\
![2023-01-05_14-56-39 (1)](https://user-images.githubusercontent.com/95596680/210896102-336a0406-dcf6-4411-b7ac-1341025398f2.gif)


**PlacesListVC opening PlaceInfoVC**\
![2023-01-05_14-58-06 (1)](https://user-images.githubusercontent.com/95596680/210896264-7c413a6e-f208-43b5-bdcb-fac2eaa9973c.gif)

**PlaceInfoVC add to Favorites**\
![2023-01-05_14-59-24 (1)](https://user-images.githubusercontent.com/95596680/210896423-c749e668-3bc3-40e3-9abe-51315f2e1b56.gif)

**FavoritesListVC scroll and delete all**\
![2023-01-05_15-01-43 (1)](https://user-images.githubusercontent.com/95596680/210896672-4026c6e5-9def-4f5e-9abb-8c2f06ff119d.gif)

**FavoritesListVC opening PlaceInfoVC**\
![2023-01-05_15-03-14 (1)](https://user-images.githubusercontent.com/95596680/210896817-dddb1d95-27e6-468a-bc5d-63d619b751d9.gif)




## Architectural Design Pattern
- The MVC design pattern was used. Models are used to contain the structure of data. View controllers contain the logic and control the views. Views do not have logic, only styling and layout placement.



## Architectural Overview 
Names, relationships, & purposes of all componenets and relevant data models

### Screens
- **SearchVC** is the Search ViewController that contains an image view, a textField, and a UIButton so that a user can input a zipcode and press the UIButton or "enter" to search
  - Input validation is performed, and if it passes, the PlacesListVC is pushed onto the stack and passes the zipcode to the PlacesListVC. 

- **PlacesListVC** shows a collection view of all nearby boba places using the zipcode provided from the SearchVC
  - PlacesListVC calls `getPlaces()`, which is a network call from the `NetworkManager` that returns an array of Places (`[Place]`)
  - The data source is configured to dequeue resusable `PlaceCell`s and set the cell's place variable with the appropriate `place`.
      - **PlaceCell** is a collection view cell consisting of an image view (BFImageView) and labels
  - A UISearchController allows the user to search for specific places within the existing `places` array. 
  - When a collection view item is selected, the related `PlaceInfoVC` is pushed onto the stack, and the `place` variable is passed to the `PlaceInfoVC`.

- **PlaceInfoVC** controls the view showing the details of a specific place that was selected for viewing either from the `PlacesListVC` or the `FavoritesListVC`.
  - It consists of a parent scroll view and its corresponding scroll container view. Within the scroll container view is a header view (`BFPlaceInfoHeadVC`), a label, a button, and a tips view (`BFTipsVC`).
      - **BFPlaceInfoHeadVC** is the header view and contains an image view and several labels.
      - **BFTipsVC** is a collection view of place tips that calls getPlaceTips(), which consists of a network call from the `NetworkManager` that returns an array of Tips (`[Tip]`)
          - The data source is configured to dequeue resusable `TipCell`s and set the cell's tip variable with the appropriate `tip`.
              - `TipCell` is a collection view cell consisting of labels
      - **Add To Favorites Button** is a button that allows the user to add a place to their favorites. Favorites is handled by the enum `PersistenceManager`.

 - **FavoritesListVC** is a table view of all of the users favorites stored in `UserDefaults` using the `PersistenceManager`. Both the corresponding `UITableViewDataSource` and `UITableViewDelegate` are included as extensions to the `FavoritesListVC`.
      - `FavoritesListVC` calls `getFavorites()`, which consists of an call to `PersistenceManager` `retrieveFavorites()` function and returns an array of Favorites (`[Place]`)
      - The data source is configured to dequeue resusable `FavoriteCell`s and set the cell's place variable with the appropriate `favorite`.
      - **FavoriteCell** is a table view cell consisting of an image view (`BFImageView`) and a label
          - **BFImageView** method of `getPhotoURLAndSetImage()` is called to set the image for the cell with the corresponding place. Either the network call's response or placeholder image is used.
      - When a table view item is selected, the related `PlaceInfoVC` is pushed onto the stack, and the `place` variable is passed to the PlaceInfoVC.
      - When a user swipes left on a table view item, the user can delete the row and remove the item from the favorites array. The `PersistenceManger` `updateWith()` function with case `remove` is called to handle this deletion. 
            
### Data Models
- All data models are structs generated using quicktype.io based on the sample response received from a Foursquare Places API call
- `Place` data model is from the Place Search endpoint
- `Tip` data model is from the Get Place Tips endpoint
- `Photo` data model is from the Get Place Photos endpoint
        
        
### Other Components
- **NetworkManager** class contains methods for network calls to the Foursquare Places API
    - static variable `shared` creates a single instance of the NetworkManager
    - cache was created to hold images so they don't need to be redownloaded
    - getPlaces() returns an array of places (`[Place]`)
    - getPhotoURLs() returns an array of photoURLs (`[Photo]`)
    - downloadImage() returns either `nil` or a `UIImage` created by the photoURL
    - getPlaceTips() returns an array of tips (`[Tip]`)

- **PersistenceManager** contains access to updating UserDefaults to store user favorites and contains the following methods:
    - `save` - to encode and save favorites array, then set it to userdefaults
    - `retrieveFavorites` - to retrieve and decode current userdefaults favorites array
    - `updateWith` - to run `retieveFavorites`, check if it is case add or case remove.
        - If `case add`: check if current place is already in favorites and append to favorites if it is not. 
        - If `case remove`: remove all favorites where fsqId matches
        - Run `save` to save the current state of the favorites array

- **BFImageView** is a UIImageView containing an image that either shows a placeholder image or a resulting image from a network call using a place's fsqId and photoURL.
    - It contains a method `getPhotoURLAndSetImage()` that:
        - gets photo URLs by calling the `NetworkManager` `getPhotoURLs()` from the Get Place Photos endpoint and returns an array of photo URLs (`[Photo]`) sorted by popularity in descending order.
        - takes the first photo url and calls the `NetworkManager` `downloadImage()` by creating an image from the URL and returning it to the `BFImageView` to be displayed.
        - if this method is unsuccessful,  the placeholder image will be displayed instead.


- **UIViewController+Ext** is an extension that contains methods including:
    - `presentBFAlert()` to present a custom alert
    - `presentDefaultError()` to present a default error
    - `showLoadingView()` to show a loading activity indicator during a network call
    - `dismissLoadingView()` to dismiss loading indicator when network call has completed
    - `showEmptyStateview()` to show an empty state when needed
        - **BFEmptyStateView** - is a view consisting of an image and a message so the user knows that they are viewing an empty state. It is called as a method extension of UIViewController.

- **BFAlertVC** - Controls custom alerts that are triggered when various errors arise, including those related to network calls and data validation.
    - Alerts are presented by calling presentBFAlert() on a UIView on the main thread.
    - Alerts consist of a container view (`BFAlertContainerView`), labels, and a button to dismiss the alert

- **BFTabBarController** is a `UITabBarController` that allows the user to navigate between the `PlacesListVC` and the `FavoritesListVC`. It is hidden on the SearchVC for aesthetics, but visible on all other screens.

- **String+Ext** is an extension containing method `isValidFiveDigitZipcode` to help perform regex zipcode input validation on the `SearchVC`. If it does not return true, a custom alert will be presented to the user.


## UI Components Used

- Collection view
- Table view
- Search bar
- Tab bar
- Label
- Button
- Image
- Activity indicator (for loading view)
- Custom alert

