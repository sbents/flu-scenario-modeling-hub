# Summary of Results
Hospitalization and death projections are provided for national and state level across five age groups. We observe that depending on the scenario, the national weekly hospitalizations could peak at around 40000-50000 weekly admissions based on the scenario. The peak timings could be from mid-to-late December with a wider range of possibilities across the states. The optimistic immunity scenarios are likely to have upto 400K cumulative hospital admissions by end of simulation, whereas the pessimistic immunity scenarios could have upto 500K cumulative hospital admissions. In general, we do not observe significant differences between the vaccine effectiveness branches irrespective of the assumption on prior immunity (see explanation for possible reasons).

# General Model Description
The model is based on a synthetic contact network at state level, aggregated to county level and five age groups. Individual states are run separately at a daily resolution, and combined to create national output. Outcomes (hospitalizations and deaths) are obtained by using age specific risk ratios from historical burden estimates. The model does not include waning, and is a single-strain simulation.

# Explanation of observed dynamics given model assumptions
Since the calibration process adjusts transmissibility along with seasonal forcing, the scenarios with higher vaccine effectiveness end up having higher transmissibility to match ongoing surges. This could explain the lack of difference between the VE branches. When the fitted transmissibility is combined with fewer or more residual susceptibles (influenced by prior immunity), it leads to <early,low> or <late,high> peaks.

# Model Calibration
Simulations are run from beginning of Round 1 (August 14th, 2022), and fitting done until the stipulated date for Round 2 (December 3rd, 2022) using backfilled data as observed on December 12th, 2022. For each region, the initial active infections are assumed to be 0.01% and distributed among exposed & infectious disease states equally. Baseline transmissibility is calibrated per state to achieve overall attack rate in the range of 3-30%. Seasonal forcing is parameterized as a tuple (width, midpoint, swing) each constrained as follows:

* Season width anywhere from 12 weeks to 30 weeks
* Season midpoint from week 12 to week 28 since August 14th
* Season swing ranging from 80% to 120% of base transmissibility

An additional buffer of 4 weeks on either side is enforced to ensure: (a) season does not start before Labor day (4th week from start of simulation), and (b) season end not after May 7, 2023 (39th week from start of simulation).

A full factorial design is constructed using the above design, and particles are evaluated using an exponentially weighted (alpha=0.975) absolute error normalized by similarly weighted ground truth. Fitting is done separately for each scenario and state. An additional peak constraint of 90% of Omicron BA.1 peak per state is enforced. Top 50 particles satisfying the peak constraint with the lowest error are selected and combined with hospitalization ratios to create the replicates.

# Model Assumptions
## Immunity assumptions
### Number/type of immune classes considered
The model contains one fully susceptible class, and two fully immune classes (V and R). The vaccine is implemented as an all-or-nothing vaccine.

### Initial proportion of population with residual immunity from previous infections and previous seasonal vaccinations (by age, if available)
Initial immunity is set at 33% for the optimistic immunity scenarios (A and C), and 16.5% for the pessimistic scenarios (B and D). No age stratification is assumed.

### Waning immunity throughout the season (yes, no, differs for vaccination and natural infection)
No waning immunity is considered

## Details on Influenza Strain(s)
### Number of strains/subtypes included in model
The model assumes single-strain dynamics.

### Strain(s) specifications (immune escape, transmissibility)
N/A (see Model calibration for transmissibility)

### Are interactions between strains/subtypes implicitly modeled?
N/A

## Seasonality implementation
Seasonal forcing timing is varied across states and fitted per scenario. See Model calibration.

## Initial Conditions
### Details on circulating strains at the start of the projection period
Single strain model. No specific strain/subtype (A(H1/H3),B) assumed.

## Non-pharmaceutical interventions (NPIs)
No NPIs considered.

## Age Group Variability
### No of age groups
Five age groups: 0-4, 5-17, 18-49, 50-64, and 65-130.

### Age-stratification differences (susceptibility, vaccine effectiveness, waning)
Each age group has varying outcome risk ratios based on past burden estimates. Further the vaccine update is heterogeneous, as suggested by the schedules. No stratification in vaccine effectiveness or baseline susceptibility is assumed.

## State-level Variability
### State-stratification details (prior immunity, vaccine coverage)
No state level variability in prior immunity. Vaccine coverage heterogeneity, as suggested by the schedules. Age profiles and contact patterns are heterogeneous since they are obtained by agggregating a realistic synthetic population.

## Vaccine Effectiveness
### VE against infection (by age, if relevant)
Same VE as against symptomatic illness and hospitalization. No age stratification assumed.

### VE against mortality (by age, if relevant)
Same VE as against symptomatic illness and hospitalization. No age stratification assumed.

### VE against transmission (by age, if relevant)
N/A

## Other Model Assumptions
Since the outcomes are based on burden estimates, to get reported hospitalizations, an age-stratified multiplier is used to 'undo' the under-detection correction as part of the burden pyramid model.
