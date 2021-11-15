# music_management_app

A small music management app.

## Getting Started

The music management app works as a small song library that uses data provided by the last.fm api. It has mainly three small features, namely the main screen, where locally saved albums are displayed; search artists by name, where you can look for a specific artist by inputting his/her name; and lastly the feature to see the top albums of the selected artist as well as the details of the album. There is the possibility of liking the album and it is in this way that the albums are saved locally to be shown on the main screen, as mentioned before. The application seeks to follow the clean architecture style and is mainly divided into infrastructure, domain, application and presentation layers. For state management the idea is to follow the bloc pattern with the help of the flutter_bloc package (making use of both blocs and cubits). Images used in the project are not copyrighted.