% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/cgp_prep.R
\name{cohort_expectation_via_lookup}
\alias{cohort_expectation_via_lookup}
\title{cohort_expectation_via_lookup}
\usage{
cohort_expectation_via_lookup(measurementscale_in, grade_in, growth_window_in,
  baseline_avg_rit, baseline_avg_npr, sch_growth_study, calc_for)
}
\arguments{
\item{measurementscale_in}{a MAP subject}

\item{grade_in}{the ENDING grade level for the growth window.  ie, if this calculation
crosses school years, use the grade level for the END of the term, per the example on p. 7
of the 2012 school growth study}

\item{growth_window_in}{the growth window to calculate CGP over}

\item{baseline_avg_rit}{mean rit at the START of the growth window}

\item{baseline_avg_npr}{mean npr at the START of the growth window}

\item{sch_growth_study}{which school growth study to use.  currently only have the 2012 data
files in the package}

\item{calc_for}{what CGPs to calculate for?}
}
\description{
wrapper function to get cohort growth expectations for the lookup method
}

