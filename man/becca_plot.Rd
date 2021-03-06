% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/becca_plot.R
\name{becca_plot}
\alias{becca_plot}
\title{Becca Vichniac's Quartile (Floating Bar) Chart}
\usage{
becca_plot(mapvizieR_obj, studentids, measurementscale,
  first_and_spring_only = TRUE, entry_grade_seasons = c(-0.8, 4.2),
  detail_academic_year = 2014, small_n_cutoff = 0.5,
  color_scheme = "KIPP Report Card")
}
\arguments{
\item{mapvizieR_obj}{mapvizieR object}

\item{studentids}{target students}

\item{measurementscale}{target subject}

\item{first_and_spring_only}{show all terms, or only entry & spring?  default is TRUE.}

\item{entry_grade_seasons}{which grade_level_seasons are entry grades?}

\item{detail_academic_year}{don't mask any data for this academic year}

\item{small_n_cutoff}{drop a grade_level_season if less than x% of the max?
(useful when dealing with weird cohort histories)}

\item{color_scheme}{color scheme for the stacked bars.  options are 'KIPP Report Card',
'Sequential Blues', or a vector of 4 colors.}
}
\value{
prints a ggplot object
}
\description{
\code{becca_plot} returns a ggplot object binned quaritle performonce
}
\details{
This function builds and prints a bar graph with 4 bins per bar show MAP data
binned by quartile (National Percentile Rank).  Bars are centered at 50th percentile
horizonatally
}

