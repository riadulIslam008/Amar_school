makeValidateEmail(String fullName, String rollNumber){
  return "${fullName.replaceAll(RegExp(" "), "").toLowerCase()}$rollNumber@gmail.com";
}