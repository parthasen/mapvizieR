context("test util functions on a variety of different inputs")

#make sure that constants used below exist
testing_constants()

test_that("abbrev abbreviates school names properly", {
  
  roster <- prep_roster(ex_CombinedStudentsBySchool)
  school_names <- unique(roster$schoolname)
  
  expected_abbrev <- c("MBMS", "MHHS", "SHES", "TSES")
  
  alts <- list(
    old=c("SHES", "TSES"),
    new=c("St. Helens", "3 Sisters")
  )
  expected_alts <- c("MBMS", "MHHS", "St. Helens", "3 Sisters")
  
  expect_equal(abbrev(school_names), expected_abbrev)
  expect_equal(abbrev(school_names, exceptions = alts), expected_alts)
  
  expect_equal(length(abbrev(roster$schoolname)), nrow(roster))
})


test_that("kipp_quartile returns KIPP style quartiles",{
  
  test_percentiles <- c(78, 16, 64, 72, 17, 27, 92, 34, 67, 33, 25, 50, 75)
  expected_quartiles_kipp <- c(4,1,3,3,1,2,4,2,3,2,2,3,4)
  expected_quartiles_not_kipp <- c(4,1,3,3,1,2,4,2,3,2,1,2,3)
  
  cdf <- prep_cdf_long(ex_CombinedAssessmentResults)
  
  expect_equal(
    kipp_quartile(test_percentiles, return_factor = FALSE), 
    expected_quartiles_kipp
  )
  
  expect_equal(
    kipp_quartile(test_percentiles, return_factor = TRUE), 
    as.factor(expected_quartiles_kipp)
  )
  
  expect_equal(
    kipp_quartile(test_percentiles, return_factor = TRUE, proper_quartile = TRUE),
    as.factor(expected_quartiles_not_kipp)
  )
  
  expect_equal(
    kipp_quartile(test_percentiles, return_factor = FALSE, proper_quartile = TRUE),
    expected_quartiles_not_kipp
  )
  
  expect_equal(length(kipp_quartile(cdf$testpercentile)), nrow(cdf))
})


test_that("tiered_growth_factors calculates proper tiered growth factors",{
  
  grades <- rep(0:12, times=4)
  quartiles <- c(
    rep(1, times=13), 
    rep(2, times=13),
    rep(3, times=13),
    rep(4, times=13)
  )
  expected_quartiles <- c(
    rep(1.50, times=4),
    rep(2.00, times=9),
    rep(1.50, times=4),
    rep(1.75, times=9),
    rep(1.25, times=4),
    rep(1.50, times=9),
    rep(1.25, times=4),
    rep(1.25, times=9)
  )
  
  cdf <- prep_cdf_long(ex_CombinedAssessmentResults)
  cdf <- cdf  %>%
    mutate(testquartiles=kipp_quartile(testpercentile))
  
  expect_equal(tiered_growth_factors(quartiles, grades), expected_quartiles)
})


test_that("standardize_kinder translates kinder codes properly", {
  
  grades <- c(1:13)
  grades_k <- ifelse(grades==13, "K", grades)
  grades_kinder <- ifelse(grades==13, "Kinder", grades)
  grades_k_kinder <- c(grades_kinder, "kinder")
  
  expected_grades <- ifelse(grades==13, 0, grades)
  expected_grades_k_kinder <- c(expected_grades, 0)
  
  roster <- prep_roster(ex_CombinedStudentsBySchool)
  
  expect_equal(standardize_kinder(grades), expected_grades)
  expect_equal(standardize_kinder(grades_k), expected_grades)
  expect_equal(
    standardize_kinder(grades_kinder, other_codes = "Kinder"), 
    expected_grades
  )
  expect_equal(
    standardize_kinder(grades_k_kinder, other_codes = c("Kinder","kinder")), 
    expected_grades_k_kinder
  )
  
  expect_is(standardize_kinder(grades_k), "integer")
  
  expect_equal(length(standardize_kinder(roster$grade)), nrow(roster))
})


test_that("grade_level_seasonify correctly labels the NWEA sample data", {
  
  ex_roster <- prep_roster(ex_CombinedStudentsBySchool)
  ex_cdf <- prep_cdf_long(ex_CombinedAssessmentResults)
  
  ex_cdf$grade <- grade_levelify_cdf(ex_cdf, ex_roster)
  ex_cdf <- grade_level_seasonify(ex_cdf)
  
  gls_freq <- table(ex_cdf$grade_level_season)

  expect_equal(length(ex_cdf$grade_level_season), 9091)
  expect_equal(sum(ex_cdf$grade_level_season), 60633.9)
  
  expect_equal(gls_freq[['-0.8']], 40)
  expect_equal(gls_freq[['-0.5']], 40)
  expect_equal(gls_freq[['0']], 100)
  expect_equal(gls_freq[['0.2']], 33)
  expect_equal(gls_freq[['0.5']], 33)
  expect_equal(gls_freq[['1']], 65)
  expect_equal(gls_freq[['1.2']], 83)
  expect_equal(gls_freq[['1.5']], 83)
  expect_equal(gls_freq[['2']], 83)
  expect_equal(gls_freq[['3']], 165)
  expect_equal(gls_freq[['3.2']], 166)
  expect_equal(gls_freq[['3.5']], 166)
  expect_equal(gls_freq[['4']], 404)
  expect_equal(gls_freq[['4.2']], 171)
  expect_equal(gls_freq[['4.5']], 171)
  expect_equal(gls_freq[['5']], 283)
  expect_equal(gls_freq[['5.2']], 279)
  expect_equal(gls_freq[['5.5']], 279)
  expect_equal(gls_freq[['6']], 627)
  expect_equal(gls_freq[['6.2']], 348)
  expect_equal(gls_freq[['6.5']], 348)
  expect_equal(gls_freq[['7']], 744)
  expect_equal(gls_freq[['7.2']], 412)
  expect_equal(gls_freq[['7.5']], 412)
  expect_equal(gls_freq[['8']], 816)
  expect_equal(gls_freq[['8.2']], 520)
  expect_equal(gls_freq[['8.5']], 520)
  expect_equal(gls_freq[['9']], 619)
  expect_equal(gls_freq[['9.2']], 148)
  expect_equal(gls_freq[['9.5']], 148)
  expect_equal(gls_freq[['10']], 344)
  expect_equal(gls_freq[['10.2']], 147)
  expect_equal(gls_freq[['10.5']], 147)
  expect_equal(gls_freq[['11']], 147)
})


test_that("fall_spring_me properly sets grade-season labels", {
  
  expect_equal(fall_spring_me(-0.8), 'KF')
  expect_equal(fall_spring_me(-0.5), 'KW')
  expect_equal(fall_spring_me(0), 'KS')
  expect_equal(fall_spring_me(-1), NA_character_)
  expect_equal(fall_spring_me(13), NA_character_)
  expect_equal(fall_spring_me(4.2), '5F')
  expect_equal(fall_spring_me(4.5), '5W')
  expect_equal(fall_spring_me(6), '6S')
  expect_equal(fall_spring_me(6.1), NA_character_)
  expect_equal(fall_spring_me(NA), NA_character_)
})


test_that("df sorter correctly sorts sample df",{
  
  ex_sort <- df_sorter(ex_CombinedStudentsBySchool, by=names(ex_CombinedStudentsBySchool))  
  
  expect_equal(ex_sort[1, ]$StudentID, 'F08000021')
  expect_equal(ex_sort[1, ]$StudentLastName, 'Adidas')
  expect_equal(ex_sort[1, ]$StudentFirstName, 'Cecilia')

  expect_equal(ex_sort[17, ]$StudentID, 'SF07002137')
  expect_equal(ex_sort[17, ]$StudentLastName, 'Berg')
  expect_equal(ex_sort[17, ]$StudentFirstName, 'Andreas')
})


test_that("is_error and is_not_error tags properly",{
  
  expect_false(is_error("foo"))
  expect_true(is_error(try(kipp_quartile(-1))))
  
  expect_true(is_not_error("foo"))
  expect_false(is_not_error(try(kipp_quartile(-1))))

})


test_that("rand_stu gets students", {
  expect_is(rand_stu(mapviz), 'character')

  expect_true(
    all(rand_stu(mapviz) %in% mapviz[['roster']]$studentid)
  )
})


test_that("clean_measurementscale cleans subjects", {
  expect_equal(clean_measurementscale('Reading'), 'Reading')
  expect_equal(clean_measurementscale('Science - General Science'), 'General Science')
})


test_that("make_npr_consistent returns expected values", {
  
  nprs <- make_npr_consistent(prepped_cdf)
  samp_table <- table(nprs$consistent_percentile)
  
  expect_equal(nrow(samp_table), 95)
  expect_equal(sum(samp_table), 9091)  

})


test_that("timing functions",{
  gls <- unique(processed_cdf$grade_level_season)
  for_test <- base::sample(gls, 100000, replace = TRUE)  
  
  msg <- capture.output(
    n_timings(n=20, test_function="fall_spring_me", test_args=list(x=for_test))
  )

  expect_output(msg, "20 trials of fall_spring_me with mean time")
    
})


test_that("mv_limit_cdf tests",{
  cdf_limit <- mv_limit_cdf(mapviz, studentids_normal_use, 'Reading')
  expect_equal(nrow(cdf_limit), 316)
  expect_equal(sum(cdf_limit$grade_level_season), 1738.1, tolerance = 0.01)
  expect_equal(sum(cdf_limit$consistent_percentile), 13270)
})


test_that("mv_limit_growth tests",{
  
  growth_df_limit <- mv_limit_growth(mapviz, studentids_normal_use, 'Mathematics')
  expect_equal(nrow(growth_df_limit), 576)
  expect_equal(sum(growth_df_limit$cgi, na.rm=TRUE), 60.967, tolerance = 0.01)
  expect_equal(sum(growth_df_limit$typical_growth, na.rm=TRUE), 1841.18, tolerance = 0.01)  
  expect_equal(sum(growth_df_limit$accel_growth, na.rm=TRUE), 3134.5, tolerance = 0.01)
})


test_that("force_string_breaks",{
  expect_equal(
    force_string_breaks("I am an American, Chicago born-Chicago, that somber city-and go at things as I have taught myself, free-style, and will make the record in my own way: first to knock, first admitted; sometimes an innocent knock, sometimes a not so innocent", 40),
    "I am an American, Chicago born-Chicago,\nthat somber city-and go at things as I\nhave taught myself, free-style, and will\nmake the record in my own way: first to\nknock, first admitted; sometimes an\ninnocent knock, sometimes a not so\ninnocent"  
  )    
})