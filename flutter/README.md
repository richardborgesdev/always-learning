
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

## linux setup checklist
1. java
    1. sudo apt-get update
    1. sudo apt-get install openjdk-10-jdk
    1. java --version
1. git
    1. apt-get install git
    1. git --version
1. vscode
    1. download from site
    1. add flutter extension
    1. start without debugging
1. android studio
    1. download from site
    1. custom > android virtual device
    1. adroid virtual device > create virtual device
    1. check virtualization on your bios: kvm-ok
    1. add flutter plugin
1. flutter
    1. download sdk from site
    1. or use repo from git with stable version tag
    1. add flutter alias on bashrc: nano .bashrc
    1. flutter doctor to check variable path
    1. accept android licenses
    1. flutter create project-example
    1. flutter run

### accepting license error
solved with: [stackoverflow - flutter doctor --android-licenses gives a java error](https://stackoverflow.com/questions/61993738/flutter-doctor-android-licenses-gives-a-java-error)

### andriod AVD problem
#### [stackoverflow - Android Studio: /dev/kvm device permission denied](https://stackoverflow.com/questions/37300811/android-studio-dev-kvm-device-permission-denied)

1. install virtualization manager: sudo apt install qemu-kvm
1. check permissions: ls -al /dev/kvm
1. check groups permissions: grep kvm /etc/group
1. add current user: sudo adduser $USER kvm

# tips
1. run the emulator (flutter emulator or android virtual device) before run the flutter app

# good projects to start
[fireship - Flutter Basic Training - 12 Minute Bootcamp](https://youtu.be/1xipg02Wu8s)

[flutter doc - Test drive vscode](https://docs.flutter.dev/get-started/test-drive?tab=vscode)
