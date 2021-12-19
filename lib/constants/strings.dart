// BaseUrl
const baseUrl = 'https://look54.kassesvn.tn-rechenzentrum1.de/api/';
// License Key for First page
const license = "E3h1f2b1n4h1E3Q1";
// Login & Password for Second Page
const login = "AlexTNA";
const password = "dev123";
const userToken = "USER_TOKEN";

// declare all screens in app here
const splashScreen = '/';
const licenseKeyScreen = '/LicenseKeyScreen';
const loginScreen = '/loginScreen';
const startScreen = '/startScreen';
const scannerScreen = '/scannerScreen';
const inventurScreen = '/inventurScreen';
const teilInventurScreen = '/teilInventurScreen';
const teilInventurViewerScreen = '/teilInventurViewerScreen';

//enum for form, to make change between forms
enum FormType {
  aktiv,
  archiv,
}
