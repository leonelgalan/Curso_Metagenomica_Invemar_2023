#' Loads object from file or runs function and saves result.
#'
#' @param name Resulting object name and file name.
#' @param f function to run if object does not exist.
#' @param directory Directory to save object in.
#' @param envir Environment to assign object to.
#' @examples
#' load_or_run("foo", \() "bar")
#' load_or_run("foo", function() { "bar" })
load_or_run <- function(name, f, directory = "Robjects", envir = .GlobalEnv) {
  if (!(exists(name) && mode(get(name)) != "function")) {
    object_path <- paste0(directory, .Platform$path.sep, name, ".RDS")
    if (file.exists(object_path)) {
      value <- readRDS(object_path)
    } else {
      value <- f()
      saveRDS(value, object_path)
    }
    assign(name, value, envir = envir)
  }
}
