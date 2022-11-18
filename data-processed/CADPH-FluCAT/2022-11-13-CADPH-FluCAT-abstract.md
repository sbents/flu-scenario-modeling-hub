# Summary of Results
This model provides influenza scenario projections for the state of California (CA). Optimistic prior immunity scenarios roughly align with historical magnitudes of CA hospitalization trends (2014-2017 & 2018-2020). Pessimistic prior immunity scenarios roughly align with historical magnitude of CA hospitalization during the 2017-2018 flu season. 

- For the high vaccination effectiveness, optimistic prior immunity scenario (scenario A), the model predicts a peak weekly incidence hospitalization size of 2417 individuals (50th percentile) and a cumulative hospitalization burden of 17268 (50th percentile).
- For the high vaccination effectiveness, pessimistic prior immunity scenario the model predicts a peak weekly incidence hospitalization size of	4813 individuals (50th percentile) and a cumulative hospitalization burden of 36545 (50th percentile).
- For the low vaccination effectiveness, optimistic prior immunity scenario (scenario C), the model predicts a peak weekly incidence hospitalization size of 3108 individuals (50th percentile) and a cumulative hospitalization burden of 20320 (50th percentile).
- For the low vaccination effectiveness, pessimistic prior immunity scenario (scenario D), the model predicts a peak weekly incidence hospitalization size of 6060 individuals (50th percentile) and a cumulative hospitalization burden of 41007 (50th percentile).


# General Model Description

This model provides scenarios for the state of CA. The model is a stochastic, mechanistic model implemented via the tau leap method with the following states:

- Susceptible = $S(t)$
- Vaccinated = $V(t)$
- Exposed: Unvaccinated= $E(t)$
- Exposed: Vaccinated= $E_v(t)$
- Infected = $I(t)$
- Infected: Vaccinated= $I_v(t)$
- Hospitalized= $H(t)$
- Dead= $D(t)$
- Recovered= $R(t)$

Scenario results are based on a sample size of 100 simulations per scenario. 

# Explanation of observed dynamics given model assumptions

In terms of peak weekly incidence and cumulative burden, these scenario results have similar ordering to Round 1: `lowVE_pesImm` > `highVE_pesImm` > `lowVE_optImm` > `highVE_optImm`. For the magnitude reached by each scenario, the prior immunity levels remain a stronger driver than vaccination effectiveness. Because the scenarios required a high number of initial infections in the seeding process to match observed hospitalization rates and because the model only has aleatory uncertainty and not epistemic uncertainty around parameter values, there is minimal variation in the uncertainty estimates. 

Some key changes in modeling assumptions from Round 1 include:

- allowing for waning of vaccine induced immunity
- adding VE against infection in addition to existing VE against hospitalization
- updating seeding conditions for each scenario to better match actuals for the current season
- calibrating the P(hospitalization|infection) and P(death|hospitalization) to better match historical burdens of hospitalizations and deaths in each respective age group

# Model Assumptions
## Immunity assumptions
### Number/type of immune classes considered

Individuals can be either Recovered, $R(t)$ (immunity due to prior infection), or Vaccinated, $V(t)$ (from vaccination during current season).

### Initial proportion of population with residual immunity from previous infections and previous seasonal vaccinations (by age, if available)

Initial proportions with residual immunity were calculated as a function of the age class population and the frequency with which different age classes experience flu infection (captured by the \kappa values described in the "Natural immunity waning details below"). More specifically, these values were calculated by solving a series of linear equations:

$0.054R_1+ 0.167x_2+ 0.442R_3+0.185R_4+0.153R_5= R(t=0)$ where the coefficients correspond to the relative proportion of the population in each age class, $R_i$ corresponds to the initial proportion of that age class that is immune, and $R(t=0)=0.30$ or $0.15$ per scenario specifications.
$R_i$ is then proportional to the rate of natural immunity waning for age class $i$, $\kappa_i$, such that for example:
 $r= \kappa_2/\kappa_1$ & $R_2 = rR_1$.
 
**Optimistic Prior Immunity (overall 30%):**

- Ages 0-4: $R_1(t=0) = 0.0966$
- Ages 5-17: $R_2(t=0) = 0.1087$   
- Ages 18-49: $R_3(t=0) = 0.2173$
- Ages 50-64: $R_4(t=0) = 0.4967$
- Ages 65+: $R_5(t=0) = 0.5796$ 

**Pessimistic Prior Immunity (overall 15%):**

- Ages 0-4: $R_1(t=0) = 0.0483$ 
- Ages 5-17: $R_2(t=0) = 0.0543$ 
- Ages 18-49: $R_3(t=0) = 0.1087$
- Ages 50-64: $R_4(t=0) =0.2484$
- Ages 65+: $R_5(t=0) =0.2898$

### Waning immunity throughout the season (yes, no, differs for vaccination and natural infection)
**Natural immunity waning details:**
The rate at which natural immunity wanes is dependent upon age class according to [Kucharski et al. 2015, Fig.4](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002082#pbio-1002082-g004):

- Ages 0-4: $\kappa_1= 1/(10/4.5*365)$
- Ages 5-17: $\kappa_2= 1/(10/4*365)$,  
- Ages 18-49: $\kappa_3= 1/(10/2*365)$,
- Ages 50-64: $\kappa_4= 1/(10/1.75*365)$,
- Ages 65+: $\kappa_5= 1/(10/1.5*365)$ 


**Vaccine-induced immunity waning details:**
Vaccine-induced immunity, $\epsilon$, wanes at a rate of 1/(6*30) days^-1^ ([Ferdinands et al. 2017](https://academic.oup.com/cid/article/64/5/544/2758477?login=false)).

## Details on Influenza Strain(s)
### Number of strains/subtypes included in model
The model only considers a single strain of influenza.

### Strain(s) specifications (immune escape, transmissibility)
N/A

### Are interactions between strains/subtypes implicitly modeled?
No

## Seasonality implementation
We calculated a seasonal forcing function $f(t)$ based on a phase-shifted mean of CA flu hospitalization admit from 2014-2020 flu seasons ([HCAI](https://hcai.ca.gov/)). $R_0$ was calculated as $R_0=f(t)*(R_{0max}-R_{0min})+R_{0min}$ and $\beta$ was calculated as $\beta=R_0/(\rho(M)*D)$ where $\rho(M)$ is the dominant eigenvalue of the contact matrix between age groups, $M$, and $D$ is the duration of infectiousness. 

## Initial Conditions
### Details on circulating strains at the start of the projection period
Seeding was calibrated independently for each scenario to better replicate observed hospitalizations to date for the 2022-2023 season. Seeds were distributed randomly, but proportionally to the population size of each age class in CA. 

**Week 1 across all scenarios:**

- Ages 0-4: +0
- Ages 5-17: +200
- Ages 18-49: +600 
- Ages 50-64: +200
- Ages 65+: +200

*Scenario A*

**Week 2**

- Ages 0-4: +0
- Ages 5-17: +900
- Ages 18-49: +2700 
- Ages 50-64: +900
- Ages 65+: +900

**Weeks 3-16**

- Ages 0-4: +0
- Ages 5-17: +850
- Ages 18-49: +2550 
- Ages 50-64: +850
- Ages 65+: +850

*Scenario B*

**Week 2**

- Ages 0-4: +0
- Ages 5-17: +100
- Ages 18-49: +300 
- Ages 50-64: +100
- Ages 65+: +100

**Weeks 3-16**

- Ages 0-4: +0
- Ages 5-17: +200
- Ages 18-49: +600 
- Ages 50-64: +200
- Ages 65+: +200

*Scenario C*

**Week 2**

- Ages 0-4: +0
- Ages 5-17: +800
- Ages 18-49: +2400 
- Ages 50-64: +800
- Ages 65+: +800

**Weeks 3-16**

- Ages 0-4: +0
- Ages 5-17: +500
- Ages 18-49: +1500 
- Ages 50-64: +500
- Ages 65+: +500

*Scenario D*

**Week 2**

- Ages 0-4: +0
- Ages 5-17: +200
- Ages 18-49: +600 
- Ages 50-64: +200
- Ages 65+: +200

**Weeks 3-16**

- Ages 0-4: +0
- Ages 5-17: +75
- Ages 18-49: +225
- Ages 50-64: +75
- Ages 65+: +75

## Non-pharmaceutical interventions (NPIs)
N/A

## Age Group Variability
### No of age groups
Five age groups were included in the model following typical flu reporting: 0-4, 5-17, 18-49, 50-64, 65+

### Age-stratification differences (susceptibility, vaccine effectiveness, waning)
Age groups differ in their: proportion with prior immunity, vaccine effectiveness, hospitalization rates, hospital length of stay, and death rates.

## State-level Variability
### State-stratification details (prior immunity, vaccine coverage)
Initial conditions for prior immunity and waning of prior immunity by age class are described in the **Model Assumptions** section above. Vaccine coverage was implemented by age class in the model following the vaccination coverage curves provided by the [Scenario Modeling Hub](https://raw.githubusercontent.com/midas-network/flu-scenario-modeling-hub_resources/main/Rd2_datasets/Age_Specific_Coverage_Flu_RD2_2022_23_Sc_A_B_C_D.csv) for the state of CA. 

## Vaccine Effectiveness
### VE against infection (by age, if relevant)
The model assumes that VE against infection is 50% of that for VE against hospitalization for a given age class $i$, e.g. $VE_{infection,i}= 0.5*VE_{hospitalization, i}$.

### VE against mortality (by age, if relevant)
The model does not explicitly include VE against mortality, but does include VE against hospitalization, which is adjusted by age group from: [2015-2016 season VE, Jackson et al. 2017](https://pubmed.ncbi.nlm.nih.gov/28792867/); [CDC 2018-2019 season VE](https://www.cdc.gov/flu/vaccines-work/2018-2019.html)

**Optimistic**

- $VE_{h,1} = 0.51$
- $VE_{h,2} = 0.57$ 
- $VE_{h,3} = 0.52$ 
- $VE_{h,4} = 0.26$
- $VE_{h,4} = 0.42$

**Pessimistic**

- $VE_{h,1} = 0.48$
- $VE_{h,2} = 0.20$ 
- $VE_{h,3} = 0.25$ 
- $VE_{h,4} = 0.14$
- $VE_{h,4} =0.12$

### VE against transmission (by age, if relevant)
The model assumes that VE against transmission is negligible. 

## Other Model Assumptions
The model includes assortative mixing by age group based off of POLYMOD survey data [Fumanelli et al. 2012 (UK)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002673).

**Parameter value estimates:**
*Parameters that were adjusted such that optimistic prior immunity scenarios reasonably replicated historical flu hospitalization trends. 

| Parameter     | Value         | Description                     | Source/Notes       |
| ------------- |:-------------:| -------------------------------:| ------------:|
| $\kappa$      | $\kappa_1= 1/(10/4.5*365)$, $\kappa_2= 1/(10/4*365)$, $\kappa_3= 1/(10/2*365)$, $\kappa_4= 1/(10/1.75*365)$, $\kappa_5= 1/(10/1.5*365)$      |Loss of immunity rate (days^-1^) | [Kucharski et al. 2015](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002082#pbio-1002082-g004); [Hill et al. 2019](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002082#pbio-1002082-g004) |
| $R_0$*         | 1.3-2.2    |Basic reproduction number | [Grech et. al., 2020](https://www.sciencedirect.com/science/article/pii/S0378378220303455) [Biggerstaff et. al., 2014](https://doi.org/10.1186/1471-2334-14-480) |
| $\beta$       | Calculated with NGM: R0= $\beta/\gamma*\rho(M)$ where $\rho(M)$ is the dominant eigenvalue of the contact matrix, $M$ |Transmission rate                | [Mistry et al. 2021](https://www.nature.com/articles/s41467-020-20544-y); [Fumanelli et al. 2012 (UK)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002673)  |
| $\sigma$*      | 1/2.8        | Loss of latency rate (days^-1^)   |[Fox et al. 2017](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005749); [Chowell et. al., 2008](https://www.cambridge.org/core/journals/epidemiology-and-infection/article/seasonal-influenza-in-the-united-states-france-and-australia-transmission-and-prospects-for-control/CE0D31575579C69D9693890FA0F7C806); [Cori et. al., 2012](https://www.sciencedirect.com/science/article/pii/S175543651200031X)|
| $\gamma$*      | 1/2.0         | Recovery rate (days^-1^)   | 1.0 days [Cori et. al., 2012](https://www.sciencedirect.com/science/article/pii/S175543651200031X); 3.8 days [Hill et al. 2019](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002082#pbio-1002082-g004) |
| $\epsilon$    | 1/(6*30)      | Loss of vaccine immunity (days^-1^)   | [Ferdinands et al. 2017](https://academic.oup.com/cid/article/64/5/544/2758477?login=false) |
| $h$*           | $h_1= 0.007$, $h_2=0.00135$, $h_3=0.00255$, $h_4=0.01375$, $h_5=0.1547$         | Probability of being hospitalized with flu given infection  | Calibrated from historical HCAI hospitalizations by age group using [FluServ-NET](https://gis.cdc.gov/GRASP/Fluview/FluHospRates.html) as a starting point|
| $\phi$        | 1/6.3         | 1/ (time between symptom onset and hospitalization) (days^-1^)   |  [Li et al. 2019](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6731609/)|
| $LOS$        | $LOS_1= 1/3.50$, $LOS_2= 1/3.50$, $LOS_3= 1/5.65$, $LOS_4= 1/5.75$, $LOS_5= 1/5.90$       | 1/(hospital length of stay) (days^-1^)   | CA OSHPD/HCAI data |
| $\theta$     | $\theta_1 =0.0033$, $\theta_2 =0.0063$, $\theta_3 =0.023$, $\theta_4 =0.042$, $\theta_5 =0.054$        | probability of death given hospitalization   | HCAI |
| $VE_h$      | **Optimistic:** 0.51 (0-4 y/o), 0.57 (5-17 y/o), 0.52 (18-49 y/o), 0.26 (50-64 y/o), 0.42 (65+ y/o) ; **Pessimistic:** 0.48 (0-4 y/o), 0.20 (5-17 y/o), 0.25 (18-49 y/o), 0.14 (50-64 y/o), 0.12 (65+ y/o) | Vaccine effectiveness against medically attended illness and/or hospitalization   | Scenario Specifications: [2015-2016 season VE, Jackson et al. 2017](https://pubmed.ncbi.nlm.nih.gov/28792867/); [CDC 2018-2019 season VE](https://www.cdc.gov/flu/vaccines-work/2018-2019.html)|


