
# flutter doc
[Docs](https://docs.flutter.dev/)

# flutter setup

## linux setup
[flutter doc - Linux install](https://docs.flutter.dev/get-started/install/linux)

[medium (pt-br) - Instalando o Flutter no Linux](https://medium.com/sysvale/instalando-o-flutter-no-linux-fa3a8db67180)

## vscode setup
[setup vscode](https://docs.flutter.dev/get-started/editor?tab=vscode)

# android sdk setup

## android sdk problems on linux

### on run flutter  doctor, get these errors:
```
✗ Flutter requires Android SDK 29 and the Android BuildTools 28.0.3
  To update the Android SDK visit https://flutter.dev/docs/get-started/install/linux#android-setup for detailed instructions.
✗ Android license status unknown.
  Run `flutter doctor --android-licenses` to accept the SDK licenses.
  See https://flutter.dev/docs/get-started/install/linux#android-setup for more details.
```
* tried:
```
sudo apt update && sudo apt install android-sdk

sudo snap install androidsdk --edge
```
> solved with adroid studio
---

### accepting license error
solved with: [stackoverflor - flutter doctor --android-licenses gives a java error](https://stackoverflow.com/questions/61993738/flutter-doctor-android-licenses-gives-a-java-error)

# good projects to start
[fireship - Flutter Basic Training - 12 Minute Bootcamp](https://youtu.be/1xipg02Wu8s)

[flutter doc - Test drive vscode](https://docs.flutter.dev/get-started/test-drive?tab=vscode)
