firebaseError(error) {
  switch (error.code) {
    case "ERROR_INVALID_EMAIL":
      return "Your Email Is not Validated";
      break;
    case "ERROR_WRONG_PASSWORD":
      return "Wrong Password";
      break;
    case "ERROR_USER_NOT_FOUND":
      return "Your Email Is not Found";
      break;
    case "ERROR_USER_DISABLED":
      return "Your Email Was Disabled";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too Many Request Please Wait...";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Something Wrong. Please Try later";
      break;
    default:
      return "Something Wrong. Please Try later";
  }
}
