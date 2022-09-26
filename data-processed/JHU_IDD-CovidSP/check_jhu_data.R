
library(tidyverse)



# QUICK CHECK BEFORE SUBMITTING -------------------------------------------


samples <- arrow::read_parquet("data-processed/JHU-IDD_CovidSP/2022-08-14-JHU_IDD-CovidSP-sample.parquet")
quants <- arrow::read_parquet("data-processed/JHU-IDD_CovidSP/2022-08-14-JHU_IDD-CovidSP.parquet")



# REDUCE SAMPLES TO !00 ---------------------------------------------------

unique(sort(as.integer(samples$sample)))
samps_ <- unique(sort(as.integer(samples$sample)))
subsamp_ <- as.character(sort(as.integer(sample(samps_, 100, replace=FALSE))))
subsamp_recode <- tibble(sample = subsamp_, sample_new = 1:100)

samples <- samples %>% filter(sample %in% as.character(subsamp_))
samples <- samples %>% 
  mutate(sample = as.character(sample)) %>%
  left_join(subsamp_recode) %>% mutate(sample = as.integer(sample_new)) %>% select(-sample_new)



# Dates -------------------------------------------------------------------

range(quants$target_end_date, na.rm=TRUE)
quants <- quants %>% filter(target_end_date <= lubridate::as_date("2023-06-03") | is.na(target_end_date))

range(samples$target_end_date, na.rm=TRUE)
samples <- samples %>% filter(target_end_date <= lubridate::as_date("2023-06-03"))



# Scenarios ---------------------------------------------------------------

unique(quants$scenario_id)
unique(quants$scenario_name)
unique(samples$scenario_id)
unique(samples$scenario_name)



# Targets -----------------------------------------------------------------

unique(quants$target)
unique(samples$target)

quants <- quants %>% 
  filter(grepl("inc death|cum death|inc hosp|cum hosp|peak time hosp|peak size hosp", target))

samples <- samples %>% 
  filter(grepl("inc death|inc hosp", target))


# Quantiles ---------------------------------------------------------------

unique(quants$quantile)
unique(quants$type)

quants <- quants %>%
  filter(type %in% c("quantile","point"))
  



# Locations ---------------------------------------------------------------

sum(is.na(quants$location))
sum(is.na(samples$location))

unique(quants$location)
unique(samples$location)

match_locs <- tibble(location_orig = unique(quants$location),
                     location = unique(quants$location)) %>%
  mutate(location=as.character(cdlTools::fips(location))) %>%
  mutate(location = ifelse(location=="US", "US", location)) %>%
  mutate(location = ifelse(location_orig=="US", "US", location)) %>%
  mutate(location=stringr::str_pad(location, width=2, side="left", pad="0")) %>%
  rename(new_loc = location, location = location_orig)

quants <- quants %>%
  left_join(match_locs) %>%
  mutate(location = new_loc) %>%
  select(-new_loc)

unique(quants$location)


# samples         
unique(samples$location)

match_locs <- tibble(location_orig = unique(samples$location),
                     location = unique(samples$location)) %>%
  mutate(location=as.character(cdlTools::fips(location))) %>%
  mutate(location = ifelse(location_orig=="US", "US", location)) %>%
  mutate(location = ifelse(location_orig=="US", "US", location)) %>%
  mutate(location=stringr::str_pad(location, width=2, side="left", pad="0")) %>%
  rename(new_loc = location, location = location_orig)

samples <- samples %>%
  left_join(match_locs) %>%
  mutate(location = new_loc) %>%
  select(-new_loc)

unique(samples$location)



# Remove state-level deaths

quants <- quants %>% filter(!(grepl("death", target) & location!="US"))
samples <- samples %>% filter(!(grepl("death", target) & location!="US"))

unique(quants$location)
unique(samples$location)

unique(quants %>% filter(grepl("death", target)) %>% pull(location))
unique(samples %>% filter(grepl("death", target)) %>% pull(location))

unique(quants %>% filter(!grepl("death", target)) %>% pull(location))
unique(samples %>% filter(!grepl("death", target)) %>% pull(location))


arrow::write_parquet(samples, "data-processed/JHU-IDD_CovidSP/2022-08-14-JHU_IDD-CovidSP-sample.parquet")
arrow::write_parquet(quants, "data-processed/JHU-IDD_CovidSP/2022-08-14-JHU_IDD-CovidSP.parquet")



