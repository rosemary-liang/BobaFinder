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

**SearchVC with input validation alerts**\
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
Names, relationships, & purposes of all components and relevant data models

### Screens & Diagrams
![image](https://user-images.githubusercontent.com/95596680/211235614-890bba45-13a0-49b4-9182-2f0ed9e54752.png)
![image](https://user-images.githubusercontent.com/95596680/211236119-751c72cf-66e6-42c4-ad24-967a50a2cfab.png)
![image](https://user-images.githubusercontent.com/95596680/211236251-692dfbbe-a457-4687-a80c-cb83678f8443.png)
![image](https://user-images.githubusercontent.com/95596680/211236274-bd23ce59-243c-473c-ad30-97b576521f19.png)
![image](https://user-images.githubusercontent.com/95596680/211236290-651cb783-910a-4187-acb4-1bbf172b83f0.png)
![image](https://user-images.githubusercontent.com/95596680/211235842-5b9182d2-7cb6-4e45-a3f0-94cd1cbb78b9.png)

            
### Data Models
- All data models are structs generated using quicktype.io based on sample response received from Foursquare Places API call
        
### Other Components
- **NetworkManager** class contains methods for network calls to the Foursquare Places API
    - static variable `shared` creates a single instance of the NetworkManager
    - cache was created to hold images so they don't need to be redownloaded

- **UIViewController+Ext** is an extension that contains methods including:
    - `presentBFAlert()` to present a custom alert
    - `presentDefaultError()` to present a default error
    - `showLoadingView()` to show a loading activity indicator during a network call
    - `dismissLoadingView()` to dismiss loading indicator when network call has completed
    - `showEmptyStateview()` to show an empty state (BFEmptyStateView, an extension of UIViewController) when needed

- **BFAlertVC** - Controls custom alerts that are triggered when user tries to favorite a place, or when various errors arise, including those related to network calls and data validation.
    - Alerts are presented by calling presentBFAlert() on a UIView on the main thread.
    - Alerts consist of a container view (`BFAlertContainerView`), labels, and a button to dismiss the alert

- **BFTabBarController** is a `UITabBarController` that allows the user to navigate between the `PlacesListVC` and the `FavoritesListVC`. It is hidden on the SearchVC for aesthetics, but visible on all other screens.



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


## Miscellaneous
- App was locked in portrait mode as the app's existing constraints did not convert well to landscape mode and after spending a couple hours trying to convert a few screens, it wasn't working too well and I had already reached 50 hours of coding at this point.
