[Docs](https://docs.flutter.dev/)

[Linux install](https://docs.flutter.dev/get-started/install/linux)
[setup vscode](https://docs.flutter.dev/get-started/editor?tab=vscode)
[test drive vscode](https://docs.flutter.dev/get-started/test-drive?tab=vscode)

# android sdk problems on linux
* on run flutter  doctor, get these errors:
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
