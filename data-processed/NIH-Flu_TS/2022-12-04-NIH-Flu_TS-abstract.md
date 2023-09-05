# Summary of Results
Our time series models of national and state-level hospitalizations project epidemics of increasing size, from scenario A (optimistic immunity and high vaccine effectiveness) to scenario C (optimistic immunity and low VE) to scenario B (pessimistic immunity and high VE) to scenario D (pessimistic immunity and low VE). All scenarios project that the national peak number of national hospitalizations will occur during the last week of December 2022 (median peak timing). We provide state-level projections for 12 states for which historical hospitalization rates are available through the Influenza Hospitalization Surveillance Network (FluSurv-NET). Projected peak timing for individual states ranges from early December 2022 (Michigan) to mid-January 2023 (Minnesota). 

Similar in intensity to the 2019-2020 season, Scenario A has a median peak of 20,027 national admissions, with 129,415 median cumulative hospitalizations. Similar to the 2017-2018 season, Scenario B has a median peak of 35,998 national admissions, with 224,421 median cumulative hospitalizations, and Scenario C has a median peak of 31,877 national admissions, with 205,391 median cumulative hospitalizations. Scenario D has a median peak of 56,795 national admissions, with median cumulative hospitalizations 352,388. Scenario D's peak and cumulative hospitalizations exceed those observed in recent severe flu seasons (e.g., 2017-2018, 2019-2020). 

# General Model Description
We use dynamic regression models with ARIMA errors and exogenous covariates for seasonal cumulative vaccination coverage, seasonal vaccine effectiveness, weekly A/H3N2 circulation, and weekly influenza infections. This approach requires that we provide values for the exogenous covariates during the projection period. For model projections, we average weekly infections and weekly A/H3N2 percent positive values observed during the 2017-2018 and 2019-2020 seasons and assume that cumulative vaccine coverage estimates have the same values as those observed in last flu season (2021-2022). Vaccine effectiveness values are dictated by the hub. 

We tested models with training windows including the COVID-19 pandemic period, but these models produced unrealistic projections. Thus, models are trained on weekly national or state-level hospitalizations during the five seasons prior to the COVID-19 pandemic (2015-2016 to 2019-2020), and hospitalizations for the upcoming season (2022-2023) are projected without considering flu hospitalizations observed during the 2020-2021 and 2021-2022 seasons. We then manually shift the timing of projected epidemics to line up with epidemic trajectories observed thus far in the 2022-2023 season. 

Methods for inferring weekly infections and information about initial susceptibility, historical vaccine effectiveness, and historical vaccine coverage are provided in later sections.

# Explanation of observed dynamics given model assumptions
 Prior immunity is more impactful than vaccine effectiveness. At the national level, we find little difference in projected peak sizes between scenarios B and C, and scenario B has higher cumulative hospitalizations.

# Model Calibration
We used historical data on influenza hospitalizations (incidence, epidemic size, and timing), influenza-like illness rates, influenza A subtype circulation, and vaccine coverage and effectiveness to calibrate our model. We used out-of-season projections for historical seasons prior to 2020-2021 to determine the optimal training period. 

The HHS target dataset begins in November 2020, and hospitals were not required to report influenza hospitalizations until February 2021. We found that national [FluSurv-NET hospitalization rates](https://www.cdc.gov/flu/weekly/influenza-hospitalization-surveillance.htm) were similar to those of the HHS dataset during the season in which both datasets are available (2021-2022, 2022-2023). Therefore, we converted weekly Flu-SurvNet rates to counts (using annual census population estimates) to serve as a historical hospitalizations dataset.

As a proxy for immunity, we include weekly influenza infections as a covariate in our models. For seasons 2010-2011 to 2019-2020, we estimated weekly influenza-like illness x percent positive values (for any flu type/subtype) using influenza syndromic and virological surveillance data provided by the [CDC FluView portal](https://www.cdc.gov/flu/weekly/fluviewinteractive.htm). To estimate weekly infections, we fit [semi-mechanistic Bayesian epidemiological models](https://imperialcollegelondon.github.io/epidemia/) to observed ILI x % positive rates during each season, assuming a case ascertainment rate of 0.3.

Information about historical and projected vaccine effectiveness and vaccine coverage are in the "Vaccine Effectiveness" and "Other Model Assumptions" sections.

# Model Assumptions
## Immunity assumptions
### Number/type of immune classes considered
N/A

### Initial proportion of population with residual immunity from previous infections and previous seasonal vaccinations (by age, if available)
In each historical season and for optimistic immunity scenarios (A and C), the initial proportion susceptible is assumed to be 0.65 ([Yang et al. 2015](https://doi.org/10.1073/pnas.1415012112)). 

When estimating infections for pessimistic scenarios seasons (B and D), we assumed an initial susceptiblity of 0.85, as dictated by the hub. We also applied a multiplier to weekly ILI x % positive cases observed in 2017-2018 and 2019-2020 to achieve a final attack rate of approximately 30%. We used the resultant amplified weekly infections as our immunity covariate in B and D scenario projections.

### Waning immunity throughout the season (yes, no, differs for vaccination and natural infection)
N/A

## Details on Influenza Strain(s)
### Number of strains/subtypes included in model
We do not train models on estimated strain or subtype-specific hospitalizations or project strain or subtype-specific hospitalizations. However, we include the proportion of samples testing positive for A/H3N2 as an exogenous covariate in model training and projections. We chose to focus on percent positive for A/H3N2 because the upcoming influenza season is expected to be A/H3N2 dominant, and A/H3N2 dominant seasons tend to be more severe than A/H1N1 dominant seasons. 

### Strain(s) specifications (immune escape, transmissibility)
N/A

### Are interactions between strains/subtypes implicitly modeled?
N/A

## Seasonality implementation
Seasonality is modeled using seasonal ARIMA terms. For the US and each state, we used the auto.arima() function in R to determine the best ARIMA model according to AICc.

## Initial Conditions
### Details on circulating strains at the start of the projection period
The initial proportion of samples positive for A/H3N2 is an average of the weekly value observed at the start of the 2017-2018 season and the 2019-2020 season. Averaged observed weekly A/H3N2 percent positive values from these two historical seasons were used as a covariate in model projections. 

## Non-pharmaceutical interventions (NPIs)
N/A. Models are trained on historical data up to the 2019-2020 season; thus, we do not consider the COVID-19 pandemic period and associated NPIs. 

## Age Group Variability
### No of age groups
N/A

### Age-stratification differences (susceptibility, vaccine effectiveness, waning)
N/A

## State-level Variability
### State-stratification details (prior immunity, vaccine coverage)
Each of the 12 states have separate models with exogenous covariates for seasonal cumulative vaccination coverage, seasonal vaccine effectiveness, weekly A/H3N2 circulation, and weekly influenza infections. The values of exogenous covariates, with the exception of VE, are specific to each state. 

## Vaccine Effectiveness
We obtained adjusted vaccine effectiveness estimates from published observational studies, the majority of which were test-negative case control design and focused on general populations or healthy adult populations in North America or Europe. See [Perofsky et al. 2020](https://elifesciences.org/articles/62955) for 1997-1998 to 2018-2019 estimates and the [CDC's influenza VE page](https://www.cdc.gov/flu/vaccines-work/past-seasons-estimates.html) for estimates from more recent seasons. 

If more than one VE study was available for a particular historical season, we calculated a seasonal weighted mean VE, with individual VE values weighted by the inverse of their 95% confidence intervals. One VE value per season was used as an exogenous covariate in model training and projections. Projections used vaccine effectiveness values dictated by the hub (0.5 for high vaccination and 0.3 for low vaccination).

### VE against infection (by age, if relevant)
N/A

### VE against mortality (by age, if relevant)
N/A

### VE against transmission (by age, if relevant)
N/A

## Other Model Assumptions
We obtained national and state-specific monthly vaccination coverage estimates for individuals aged 6+ months during seasons 2010-2011 to 2021-2022, from the [National Center for Immunization and Respiratory Diseases](https://data.cdc.gov/Flu-Vaccinations/Influenza-Vaccination-Coverage-for-All-Ages-6-Mont/vh55-3he6). For each historical season in the model training dataset, we used the final cumulative vaccine coverage value as our vaccine coverage covariate. For projection scenarios, we used the final vaccine coverage value from the 2021-2022 season.
