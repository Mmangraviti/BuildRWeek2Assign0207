#' fars_read
#'
#' @param filename The name and directory of input csv file
#'
#' @return  returns data from the file as a data frame
#' @import readr
#' @import dplyr
#' @export fars_read
#'
#' @examples fars_read( system.file("extdata","accident_2015.csv.bz2",package="BuildRWeek2Assign0207"))
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#' make_filename
#'
#' will recreate the file name associated wtih the given integer year
#'
#' @param year  -integer value of year from 2013 to 2015 inclusive
#'
#' @return  returns the full file name (wihtout the directory)
#'
#' @export make_filename
#'
#' @examples make_filename(2015)
make_filename <- function(year) {
  year <- as.integer(year)
  paste0(dirname(system.file("extdata","accident_2015.csv.bz2",package="BuildRWeek2Assign0207")),"/",sprintf("accident_%d.csv.bz2", year))
#  sprintf("accident_%d.csv.bz2", year)
}

#' fars_read_years
#'
#' @param years a list of integer years between 2013 and 2015 inclusive
#'
#' @return  returns the years and months found in the selected datafile
#' @import dplyr
#  @import magrittr
#' @importFrom magrittr "%>%"
#' @export fars_read_years
#'
#' @examples  fars_read_years(c(2013,2014))
fars_read_years <- function(years) {
  YEAR  <- MONTH <- NULL
  lapply(years, function(year) {
    file <- make_filename(year)
#    make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = YEAR) %>%
        dplyr::select(MONTH, year)
#      dat <- fars_read(file)
#      dplyr::mutate(dat, year = year) %>%
#      dplyr::mutate(dat, dat$year = year) %>%
#        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' fars_summarize_years
#' will count entries by year aross month for given year
#'
#' @param years as a list of integers years from 2013 to 2015 inclusive
#'
#' @return  returns total entries (accidents) in data across year by month
#' @export fars_summarize_years
#' @import dplyr
#' @import tidyr
#  @import magrittr
#' @importFrom magrittr "%>%"
#'
#' @examples  fars_summarize_years(c(2013,2014,2015))
fars_summarize_years <- function(years) {
  year<-MONTH<-NULL   # added to remove no visible binding error opton 2
# https://www.r-bloggers.com/2019/08/no-visible-binding-for-global-variable/
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

#' fars_map_state
#'
#' @param state.num the integer number representing each state
#' @param year integers years from 2013 to 2015 inclusive
#'
#' @return  latitude and longitude of the state
#' If the state.num is not valid, it will thrown an error
#' if the longtitude exceeds 900 it will throw an error
#' if the latitue exceeds 90 it will throw and error
#' it will tell user if there are no accidents meeting criteria
#' a chart will be produced if input is good
#'
#' @import maps
#' @import dplyr
#  @import magrittr
#' @importFrom magrittr "%>%"
#' @import readr
#' @export fars_map_state
#'
#' @examples fars_map_state(1,2015)
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, data$STATE == state.num)
#  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
