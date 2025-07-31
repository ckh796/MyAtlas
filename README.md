![MyAtlas_Demo_page-0001](https://github.com/user-attachments/assets/de7a1c01-ce2f-459b-a8f2-dfd6ee516ec2)
![MyAtlas_Demo_page-0002](https://github.com/user-attachments/assets/4403f960-234b-4e73-a53e-6bb69fe72a0b)
![MyAtlas_Demo_page-0003](https://github.com/user-attachments/assets/cd240421-a8d8-4acd-9384-2cc2308b4a08)
![MyAtlas_Demo_page-0004](https://github.com/user-attachments/assets/a52c55d0-b78f-4ed3-8583-7a52725a9052)
![MyAtlas_Demo_page-0005](https://github.com/user-attachments/assets/c85a6b33-c084-4c66-8bc7-80f0403a11b5)


## Features

- Fetch and display all countries from the REST Countries API
- Save up to 5 favorite destinations
- View country details including name, capital, flag, and currency
- Search and filter countries
- Smooth UI experience
- Core Data caching for offline access
- Alphabetical sorting of countries
- Display user's location by default

## Technologies Used

- **SwiftUI** 
- **Combine** 
- **MVVM Architecture** 
- **Core Data** 
- **REST Countries API** 
- **SDWebImage** 
- **Xcode** 

## Unit Testing

The project includes a MockCountryServiceFailure that inherits the live CountryService. It is used to simulate various responses (failure to fetch countries for example) for unit testing FetchCountriesUseCase and view models without making real network calls.

