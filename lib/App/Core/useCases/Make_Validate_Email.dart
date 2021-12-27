makeValidateEmail(String fullName, String rollNumber, String studentSection){
  return "${fullName.replaceAll(RegExp(" "), "").toLowerCase()}$rollNumber$studentSection@gmail.com";
}