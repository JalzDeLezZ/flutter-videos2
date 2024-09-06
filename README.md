<header>
  <p align="center">
    <a href="https://flutter.dev/" target="blank"><img src="https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg" width="90" alt="Nest Logo" /></a>
    <h2 align="center">Cinema Movie</h2>
  </p>
  <section align="center">
  <a href="#"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
  <a href="#"><img src="https://opencollective.com/nest/sponsors/badge.svg" alt="Sponsors on Open Collective" /></a>
  <a href="#"><img src="https://img.shields.io/twitter/follow/nestframework.svg?style=social&label=Followers"></a>
  </section>
</header>
<hr/><br/>

<!-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -->

## Development

```bash
# Implementations
1. Copy the file .env.example and rename it to .env
2. Add your API KEY in the .env file
3. Run the project
3. Entity Changes, run the generator DB
flutter pub run build_runner build

# Open witch iOS Simulator
1. $open -a Simulator

# Verify dependences
1. flutter pub upgrade
2. flutter packages upgrade

#Implementaton to Android,
0. build.gradle (verify)
1. flutter clean
2. flutter pub get

$ flutter run


## PROD
//? Cambiar el nombre de la aplicación
$flutter pub add -d change_app_package_name

```

<br/>

## Dependences
[• go_router](https://pub.dev/packages/go_router)
[• flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
[• dio](https://pub.dev/packages/dio)
[• flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
[• card_swiper](https://pub.dev/packages/card_swiper)
[• animate_do](https://pub.dev/packages/animate_do)
[• intl](https://pub.dev/packages/intl)
[• path_provider](https://pub.dev/packages/path_provider)
[• flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view)
[• youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter)
[• flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)


<br/>
<hr/>

## Code Helpers

```bash
# Modify the most recent commit message
$ git commit --amend -m "an updated commit message"
# Create Tag release
$ git tag -a v1.0.0 -m "Version 1.0.0"
# Push Tag release
$ git push --tags || git push origin v1.0.0
# Delete Tag release
$ git tag -d v1.0.0
# Delete Tag release in remote
$ git push --delete origin v1.0.0
#! Before edit tag and create release in github and add description
```

<hr/>


## Others

<details><summary>Documentation</summary>
<ul>
  <li><a href="https://docs.flutter.dev/cookbook/plugins/play-video" target="_blank">Play and pause a video</a></li>
</ul>
</details><br/>

<details><summary>Bash Commands</summary>

```bash
# Init Empty Project
$ flutter create cinema_movie
# Run
$ flutter run

# Implementations
$ flutter pub add provider
$ flutter pub add dio

# Isar DB Implementation
• https://isar.dev/es/tutorials/quickstart.html
1. Add Dependencies
flutter pub add isar isar_flutter_libs
flutter pub add -d isar_generator build_runner
2. Write down the classes
import 'package:isar/isar.dart';
Id? isarId; // you can also use id = null to auto increment
3. Run the generator
flutter pub run build_runner build
4. Open an instance of Isar
5. Read and write data
# https://inspect.isar.dev/3.1.0+1/#/64985/x9Mg0VOx0Fg
```
</details><br/>

<hr/>

## Utils

[• Notes Dart](https://devtalles.com/files/dart-cheat-sheet.pdf)

[• Notes Flutter](https://devtalles.com/files/flutter-cheat-sheet.pdf)

[• QuickType](https://app.quicktype.io/)

[• Storage](https://pub.dev/packages/shared_preferences)
[• Isar DB](https://isar.dev/es/)

[• TMDB API](https://www.themoviedb.org/settings/api)
<!-- user: jalzdelezz -> jameslo***gmail.com -->
<!-- pass: ze**qc46 -->
<!-- key: 565abbc587f9eee9822e337179ba5ab4X -->


<hr/>

## Support

* Licence - [MIT licensed](LICENSE).
* Author - [James Diaz Lopez](https://www.linkedin.com/in/james-jalz/)
* Contact - [j4mes.delez@gmail.com](mailto:j4mes.delez@gmail.com)