# uSync Flutter

Flutter project for uSync App.

## Getting Started

Clone this project to your working directory using the following command.

```shell
git clone git@git.usync.us:usync/usync-flutter.git
```

##  Project Structure

```shell
<project-root>
  |
  |- android (Android related files)/
  |- ios (iOs related files)/
  |- lib/
  |     |- components/
  |     |- config/
  |     |- modules/
  |           |- <ModuleName>
  |                     |- screens/
  |                     |- model/
  |     |- services
  |     |- utils
  |     |- main.dart
  |
```

## Building the app

### Web

### iOS

### Android

- Generate a keystore file using instruction provided here [https://docs.flutter.dev/deployment/android#create-an-upload-keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore)
- Put the **keystore** file in project root.
- Create a file named **[project]/android/key.properties** that contains a reference to your keystore
  ```
  storePassword=<password from previous step>
  keyPassword=<password from previous step>
  keyAlias=upload
  storeFile=./upload-keystore.jks
  ```
- Ensure these two files are excluded from git repository
- Configure gradle to use your upload key when building your app in release mode by editing the **[project]/android/app/build.gradle** file.
- Add the keystore information from your properties file before the android block
```
 def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
         ...
   }
```
- Find the **buildTypes** block:
```
buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```
And replace it with the following signing configuration info
```
 signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```
- Create a release bundle using the following command
```sh
flutter build appbundle --build-name=<versionCode> --build-number=<versionCode>
```
- to know more about how to version your app, please read this [documentation](https://developer.android.com/studio/publish/versioning).



## Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
