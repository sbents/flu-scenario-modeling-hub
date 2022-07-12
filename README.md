<a href="https://fluscenariomodelinghub.org/"><img src= "https://github.com/midas-network/flu-scenario-modeling-hub/blob/main/logo.png" alt="drawing" width="300"/>

# Flu Scenario Modeling Hub

Last updated: 7-7-2022 for **Round 1 Scenarios**.

## Rationale    

Even the best models of infectious disease transmission struggle to give 
accurate forecasts at time scales greater than 3-4 weeks due to unpredictable 
drivers like changing policy environments, behavior change, development of new 
control measures, and stochastic events. However, policy decisions around the 
course of infectious diseases, particularly emerging and seasonal infections, 
often require projections in the time frame of months. The goal of long-term 
projections is to compare outbreak trajectories under different scenarios, as 
opposed to offering a specific, unconditional estimate of what “will” happen. 
As such, long-term projections can guide longer-term decision-making while 
short-term forecasts are more useful for situational awareness and guiding 
immediate response.

We have specified a set of scenarios and target outcomes to allow alignment of 
model projections for collective insights. Scenarios have been designed in 
consultation with academic modeling teams and government agencies (e.g., CDC).

</br>

## How to participate    

The Flu Scenario Modeling Hub is open to any team willing to provide projections
at the right temporal and spatial scales, with minimal gatekeeping. We only 
require that participating teams share point estimates and uncertainty bounds, 
along with a short model description and answers to a list of key questions 
about design. A major output of the projection hub is ensemble estimates of 
epidemic outcomes (e.g., infection, hospitalizations, and deaths), for different
time points, intervention scenarios, and US jurisdictions.

Those interested to participate should email scenariohub@midasnetwork.us .

Model projections should be submitted via pull request to the data-processed 
folder of this GitHub repository. Technical instructions for submission and 
required file formats can be found 
[here](https://github.com/midas-network/flu-scenario-modeling-hub/blob/master/data-processed/README.md).

</br>

## Round 1 Scenarios     

Round 1 of influenza projections considers the interaction of vaccination 
protection during the current season (first dimension) with the impact of the 
COVID-19 pandemic on prior immunity (2nd dimension) over a 41-week period. We 
follow the usual 2 * 2 table structure from the 
[COVID-19 Scenario Modeling Hub](https://covid19scenariomodelinghub.org/). 

<img src= "https://github.com/midas-network/flu-scenario-modeling-hub/blob/main/flu_round1.png">

### **OTHER SPECIFICATIONS AND ASSUMPTIONS**

**Prior Immunity***

*   Prior influenza immunity is assumed to be a combination of residual immunity
from previous infections and previous seasonal vaccinations. In a typical 
influenza season, it has been estimated that around 70% of the population has 
some level of prior immunity (30% susceptible) [ADD REFS - numbers need refined 
based on published estimates]. 
*   Teams are allowed to vary prior immunity by age or other demographic 
characteristic, as long as the overall matches the scenario specifications.

**COVID-19 Interactions**

*   No major interactions with future COVID-19 surges (immunological, social, 
behavior)

**Influenza strains**

*   All subtypes together (but H3N2 is presumed dominant, >75% H3N2 of all 
positive flu viruses)
    *   Targets include influenza A and B combined
*   Subtype-specific models are allowed
    *   Immunity conditions should be applied to all subtypes/strains that 
    aggregates to the overall conditions specified in the scenarios
*   Intrinsic transmissibility: Assumed H3N2 is same as 2021-2022 H3N2 

**Vaccine Effectiveness**

*    https://www.cdc.gov/flu/vaccines-work/vaccineeffect.htm#:~:text=While%20vaccine%20effectiveness%20(VE)%20can,used%20to%20make%20flu%20vaccines.
*   Teams can use prior seasons to scale VE to age groups and different 
strains/subtypes
    *   2012-13 season:
        *  H3N2 dominant
        *  VE = 49% overall, VE = 39% for H3N2
        *  https://www.cdc.gov/flu/vaccines-work/2012-2013.html 
    *  2017-18 season:
        *  H3N2 dominant
        *  VE = 38% overall, VE = 33% for H3N2
        *  https://www.cdc.gov/flu/vaccines-work/2017-2018.html

**Vaccine immune waning**

*To be added*

**Age groups**

*   Age-stratification is optional. If stratified, immunity and vaccination 
should aggregate to specifications in scenarios
*   Suggested age-strata:
    *   0-4, 5-17, 18-49, 50-64, and 65+ (or some aggregation of this, like 
    0-17, etc.)

**State-level variability**

*   Vaccination coverage, age population 
*   Variability in severity between states is possible
*   Acceptable to assume prior immunity (due to a combination of vaccination 
and natural infection) the same across states; variability between states is 
allowed as long as it aggregates to the scenario definition for the US overall 
(population weighted average)

**Cross-protection of subtype immunity:** At the discretion of the teams.

**Influenza vaccine coverage data:** Projected coverage for each scenario to be 
provided by SMH for age groups: 0-17yr, 18-49yr, 50-64yr, 65+yr.

**Seasonality:** Teams should include their best estimates of influenza 
seasonality in their model but we do not prescribe a specific level of seasonal
forcing.

**NPI:** No reactive NPIs to COVID-19 or influenza; low level masking allowed at 
groups’ discretion.

**Seeding of influenza:** Influenza begins seeding into the US with 50 
infections per week for 16 weeks starting August 14, 2022. Seeding locations 
and distribution are at the discretion of the teams. 
*If influenza is already circulating in the US, this seeding will be adjusted.*

**Initial Conditions:** The mix of circulating strains at the start of the 
projection period is at the discretion of the teams based on their 
interpretation/analysis of the available data and estimates at the time of 
projection. Variation in initial prevalence between states is left at teams’ 
discretion.
 
**All of the teams’ specific assumptions should be documented in metadata and 
abstract.**


### **Targets and Time Horizon:**

**Projection time horizon:** We consider a **42-week projection period:**

*    *August 14, 2022* to *June 3, 2023*

**Targets:** 

*    Both mechanistic/time-resolved and overall statistical model projections 
are encouraged to participate. To facilitate this we will accept projections by 
state and for the US overall for either (or both) of:
	 * Weekly projections of incident outcomes (infections, symptomatic cases, hospitalizations, deaths)
	 * Overall season peak size, peak timing, total size (infections, hospitalizations, deaths)

</br>

## Submission Information    

| Scenario | Scenario name for submission file | Scenario ID for submission file |
| ---------------------------------------------- |:---------------------------------:|:-------------------------------:|
| Scenario A. Low vaccination coverage, no new variant            | lowVac_optImm  | A-2022-08-14 |
| Scenario B. Low vaccination coverage, new immune escape variant | lowVac_pesImm  | B-2022-08-14 |
| Scenario C. High vaccination coverage, no new variant           | highVac_optImm | C-2022-08-14 |
| Scenario D. High vaccination coverage, new immune escape variant| highVac_pesImm | D-2022-08-14 | 
*   **Due date**: Aug 16, 2022 
*   **End date for fitting data**: Aug 13, 2022 
*   **Start date for scenarios**: Aug 14, 2022  (first date of simulated 
transmission/outcomes)
*   **Simulation end date:** June 3, 2023  (42-week horizon)
*   We aim to release results by Aug 30, 2022 


**Other submission requirements**

*   **Geographic scope:** state-level and national projections
    *    All states not required, US overall not required.
*   **Results:**
    *  Summary: Results must consist of a subset of weekly and/or summary 
    targets listed below; all are not required. Weeks follow epi-weeks (Sun-Sat)
    dated by the last day of the week.
    *  **Weekly Targets** (subset of: infections, symptomatic cases, 
    hospitalizations, deaths)
        *    Weekly incident 
        *    Weekly cumulative since start of season (August 14, 2022)
    *  **Summary Targets** (subset of: infections, symptomatic cases, 
    hospitalizations, deaths)
        *    Peak size
        *    Peak timing 
        *    Total size
*   **Metadata:** We will require a brief meta-data form, from all teams.
*   **Uncertainty:** We ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 
0.99. Teams are also encouraged to submit 0 (min value) and 1 (max) quantiles 
if possible. At present time, *inclusion in ensemble models requires a full set 
of quantiles from 0.01 to 0.99.*
*    **Simulation sample:** We ask that teams submit a sample of up to 100 
simulation replicates. Simulations should be sampled in such a way that they 
will be most likely to produce the same summary statistics as that quantile 
submitted. For some models, this may mean a random sample of simulations, for 
others with larger numbers of simulations, it may require weighted sampling.

</br>

## Submitting model projections

Groups interested in participating can submit model projections for each 
scenario in a CSV file formatted according to our specifications, and a metadata
file with a description of model information. See 
[here](https://github.com/midas-network/flu-scenario-modeling-hub/blob/master/data-processed/README.md) 
for technical submission requirements. Groups can submit their contributions as 
often as they want; the date of when a model projection was made (projection 
date) is recorded in the model submission file.   

### Model projection dates
Model projections will have an associated `model_projection_date` that 
corresponds to the day the projection was made.    

For week-ahead model projections with `model_projection_date` of Sunday or 
Monday of EW12, a 1 week ahead projection corresponds to EW12 and should have 
`target_end_date` of the Saturday of EW12. For week-ahead projections with 
`model_projection_date` of Tuesday through Saturday of EW12, a 1 week ahead 
projection corresponds to EW13 and should have `target_end_date` of the 
Saturday of EW13. A week-ahead projection should represent the total number of 
incident deaths or hospitalizations within a given epiweek (from Sunday through 
Saturday, inclusive) or the cumulative number of deaths reported on the 
Saturday of a given epiweek. Model projection dates in the Flu Scenario 
Modeling Hub are equivalent to the forecast dates in the 
[COVID-19 Forecast Hub](https://covid19forecasthub.org/).

### Gold standard data

*to be addded*

### Locations
Model projections may be submitted for any state in the US and the US at the 
national level.

### Probabilistic model projections
Model projections will be represented using quantiles of predictive 
distributions. Similar to the 
[COVID-19 Forecast hub](https://covid19forecasthub.org/), we encourage all 
groups to make available the following 25 quantiles for each distribution: 
`c(0, 0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99, 1)`. One goal of 
this effort is to create probabilistic ensemble scenarios, and having 
high-resolution component distributions will provide data to create better 
ensembles.

## Ensemble model
We aim to combine model projections into an ensemble.

## Data license and reuse
We are grateful to the teams who have generated these scenarios. The groups 
have made their public data available under different terms and licenses. You 
will find the licenses (when provided) within the model-specific folders in the 
[data-processed](./data-processed/) directory. Please consult these licenses 
before using these data to ensure that you follow the terms under which these 
data were released.

All source code that is specific to the overall project is available under an 
open-source [MIT license](https://opensource.org/licenses/MIT). We note that 
this license does NOT cover model code from the various teams or model scenario 
data (available under specified licenses as described above).

## Computational power
Those teams interested in accessing additional computational power should 
contact Katriona Shea at k-shea@psu.edu.

## Teams and models    

*to be addded*

## The Flu Scenario Modeling Hub Coordination Team    

 - Shaun Truelove, Johns Hopkins University
 - Cécile Viboud, NIH Fogarty
 - Justin Lessler, University of North Carolina
 - Katriona Shea, Penn State University
 - Rebecca Borchering, Penn State University
 - Claire Smith, Johns Hopkins University
 - Emily Howerton, Penn State University
 - Nick Reich, University of Massachusetts at Amherst
 - Harry Hochheiser, University of Pittsburgh
 - Michael Runge, USGS
 - Lucie Contamin, University of Pittsburgh
 - John Levander, University of Pittsburgh
 - J Espino, University of Pittsburgh
 - Luke Mullany, Johns Hopkins University
 - Kaitlin Lovett, John Hopkins University
