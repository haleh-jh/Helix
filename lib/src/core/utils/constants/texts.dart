import 'package:universal_html/html.dart';

String defaultError = "An error has occurred";

const String dashboard = "Dashboard";
const String telescope = "Telescopes";
const String telescopePath = "Telescopes";
const String telescopeDropDown = "Telescopes/GetDropDownTelescopes";
const String detectorDropDown = "Detectors/GetDropDownDetectors";
const String objectDropDown = "SObjects/GetDropDownSObjects";
const String frameDropDown = "Filters/GetDropDownDetectors";
const String detector = "Detectors";
const String Objects = "SObjects";
const String Users = "Users";
const String ObservationsPath = "ObservationSubmissions";
const String UserObservationPath = "UserProfile/GetUserObservationSubmissions";
const String Filters = "Filters";

const String kServerError = "Server error has occurred";
const String kGeneralError = "An Error has occurred please try again";
const String kConnectionError = "Check your internet connection";
const String kNotExistObservation = "There is no Observation recorded in this date";

bool? checkConnection() {
  return window.navigator.onLine;
}