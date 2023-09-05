# Summary of Results
In summary, our results suggest the season will be closer to the B/C/D scenarios with relatively high and early peaks. 
Although the influenza season kicked-off exceptionally early, our projections do not result in exceptionally bad 
outcomes by either cumulative or peak hospitalization.

# General Model Description
For each state our scenario projections are generated using a mechanistic model with S[Sv]I[Iv]HR compartments, 
where 'v' subscripts indicate vaccinated. We use the population and vaccine time series provided by the Scenario Hub 
and assume that the infection-susceptibility of vaccinated individuals is reduced by one half of vaccine effectiveness. 
Our model requires as inputs an estimate for R0, the hospitalization probability of an infectious case, and the initial 
number of cases.  For each state these were estimated by fitting the scenario D model to daily data from HHS. The 
national projection profiles are calculated as the sum of states using randomly ordered state level profiles.

# Explanation of observed dynamics given model assumptions
The primary source of uncertainty in our model appears in the transmissibility parameter.  This causes the various
model trajectories to vary in both peak time and peak height.  As a result, the central quantiles seem to ramp-up
rather quickly followed by a much slower decline, when in fact this is simply the result of the spread in peak
timing.

# Model Calibration
Our most significant modeling observation is that fitting the data to scenario A (and to a lesser extent B and C) 
results in parameters well outside the historical distribution of seasonal influenza.  So we decided to ignore these 
unreasonable parameters (hyper transmissible and extremely low severity), and simply apply the parameters from fitting 
scenario D to all scenarios.  This resulted in a poor match to the data for scenario A, but very reasonable forward 
projections.  

To calibrate the model we fit the reproduction number, infection-hospitalization rate, and initial number of infections
to the data to-date.  We then applied uncertainty to each of the parameters based on previous seasonal-influenza 
modeling activities.

# Model Assumptions
## Immunity assumptions
### Number/type of immune classes considered
2 - Susceptible-vaccinated (partial immunity), Recovered (fully immune)

### Initial proportion of population with residual immunity from previous infections and previous seasonal vaccinations (by age, if available)
None

### Waning immunity throughout the season (yes, no, differs for vaccination and natural infection)
No

## Details on Influenza Strain(s)
### Number of strains/subtypes included in model
Only one strain.

### Strain(s) specifications (immune escape, transmissibility)
Single strain. 
Generation time = 2.5 (days)
Fit parameters: reproduction number, infection-hospitalization rate, initial number of infections

### Are interactions between strains/subtypes implicitly modeled?
No

## Seasonality implementation
None

## Initial Conditions
### Details on circulating strains at the start of the projection period
Single strain with a fit distribution of parameters.

## Non-pharmaceutical interventions (NPIs)
None

## Age Group Variability
### No of age groups
1 - Population treated as a single age group.  

### Age-stratification differences (susceptibility, vaccine effectiveness, waning)
None

## State-level Variability
### State-stratification details (prior immunity, vaccine coverage)
States only varied as a result of model fit parameters and provided vaccine uptake time-series (and of course 
population size).

## Vaccine Effectiveness
### VE against infection (by age, if relevant)
VE against infection is set as one half of VE against hospitalization.

### VE against mortality (by age, if relevant)
Mortality not considered.

### VE against transmission (by age, if relevant)
We assume that VE only affects susceptibility, not infectiousness.

## Other Model Assumptions
We assume that the transmission parameter remains constant throughout the season

