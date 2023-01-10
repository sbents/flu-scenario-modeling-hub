# Data submission instructions

This page is intended to provide teams with all the information they
need to submit scenarios.  

All scenarios should be submitted directly to the [data-processed/]
(./) folder. Data in this directory should be added to the repository
through a pull request. 

Due to file size limitation, the file can be submitted in a `.zip` or
`.gz` format with the same name as the `.csv` file provided. 

All submissions will be automatically validated upon submission, for
more information please consult the validation wiki page. 

## Example

See [this file](https://github.com/midas-network/flu-scenario-modeling-hub/blob/main/data-processed/MyTeam-MyModel/2022-08-14_MyTeam-MyModel.csv)
and [this metadata file](https://github.com/midas-network/flu-scenario-modeling-hub/blob/main/data-processed/MyTeam-MyModel/metadata-MyTeam-MyModel.txt)
for an illustration of part of a (hypothetical) submission files. An
example of the “sample” format file submission is also available 
[here](https://github.com/midas-network/flu-scenario-modeling-hub/blob/main/data-processed/MyTeam-MyModel/2022-08-14-MyTeam-MyModel-sample.csv).


## Subdirectory

Each subdirectory within the [data-processed/](./) directory has the
format:

    team-model
    
where 

- `team` is the teamname and 
- `model` is the name of your model. 

Both team and model should be less than 15 characters, and not include
hyphens nor spaces.

Within each subdirectory, there should be a metadata file, a license
file (optional), and a set of scenarios. 

## Metadata 

The metadata file name should have the following format

    metadata-team-model.txt
    
where 

- `team` is the teamname and 
- `model` is the name of your model. 
    
The metadata file must follow the [documented description](https://github.com/midas-network/flu-scenario-modeling-hub/blob/master/data-processed/METADATA.md). 
An example [hypothetical metadata file](https://github.com/midas-network/flu-scenario-modeling-hub/blob/main/data-processed/MyTeam-MyModel/metadata-MyTeam-MyModel.txt) 
has been posted in the `data-processed` directory. 

## License (optional)

License information for data sharing and reuse is requested in the
metadata, including a link to the license text. If you cannot link to
the text of a standard license and have specific license text, include
a license file named

    LICENSE.txt


## Date/Epiweek information

For week-ahead scenarios, we will use the specification of epidemiological
weeks (EWs) [defined by the US CDC](https://ndc.services.cdc.gov/wp-content/uploads/MMWR_Week_overview.pdf)
which run Sunday through Saturday.

There are standard software packages to convert from dates to epidemic weeks
and vice versa. E.g. [MMWRweek](https://cran.r-project.org/web/packages/MMWRweek/) 
for R and [pymmwr](https://pypi.org/project/pymmwr/) and 
[epiweeks](https://pypi.org/project/epiweeks/) for python.


## Model Results

Each model results file within the subdirectory should have the following 
name

    YYYY-MM-DD-team-model.csv
    
where

- `YYYY` is the 4 digit year,
- `MM` is the 2 digit month,
- `DD` is the 2 digit day,
- `team` is the teamname, and
- `model` is the name of your model.


TThe date YYYY-MM-DD should correspond to the start date for scenarios
projection ("first date of simulated transmission/outcomes" as noted in the
scenario description on the main 
[README, Submission Information](https://github.com/midas-network/flu-scenario-modeling-hub#submission-information)).

The `team` and `model` in this file must match the `team` and `model` in the 
directory this file is in. Both `team` and `model` should be less than 15 
characters, alpha-numeric and underscores only, with no spaces or hyphens.

For optional addtional format, the filename of the model results is
different:
- For `"sample"` file format (individual runs), the file should be named:
  `“YYYY-MM-DD-team-model-sample.csv”`

If the size of the file is larger than 100MB, it can be submitted in a `.zip`
or `.gz` format. 

## Model results file format

The file must be a comma-separated value (csv) file with the following 
columns (in any order):

- For file format containing **quantiles** information, the output file should
  contains nine columns:
    - `model_projection_date`
    - `scenario_name` 
    - `scenario_id`
    - `target`
    - `target_end_date`
    - `location`
    - `type` 
    - `quantile` 
    - `value`

- For file format containing **sample** information, the output file should
  contains eight columns:
    - `model_projection_date`
    - `scenario_name` 
    - `scenario_id`
    - `target`
    - `target_end_date`
    - `location`
    - `sample` 
    - `value`

No additional columns are allowed.

Each row in the file is either a point or quantile scenario for a location on 
a particular date for a particular target.


### `model_projection_date`

Values in the `model_projection_date` column must be a date in the format

    YYYY-MM-DD
    
Model projections will have an associated `model_projection_date` to the start
date for scenarios (first date of simulated transmission/outcomes).
The "model_projection_date" and date in the filename should correspond.

### `scenario_name`

The standard scenario names should be used as given in the scenario 
description in the [main Readme](https://github.com/midas-network/flu-scenario-modeling-hub). 
Scenario names only include characters and no spaces, e.g., `lowVac_optImm`.


### `scenario_id`

The standard scenario id should be used as given in in the scenario 
description in the [main Readme](https://github.com/midas-network/flu-scenario-modeling-hub). 
Scenario id's include a captitalized letter and date as YYYY-MM-DD, e.g., 
`A-2022-08-14`.


### `target`

The requested targets are:
- weekly incident deaths (US level only)
- weekly cumulative deaths (US level only)
- weekly incident hospitalizations (US + State level)
- weekly cumulative hospitalizations (US + State level)
- peak size hospitalizations (US + State level)
- weekly peak timing hospitalizations (US + State level)

Values in the `target` column must be a character (string) and be one of 
the following specific targets:

- "N wk ahead inc death"  where N is a number between 1 and 42 (or 29 or 26, depending on the round)
- "N wk ahead cum death"  where N is a number between 1 and 42 (or 29 or 26, depending on the round)
- "N wk ahead inc hosp"  where N is a number between 1 and 42 (or 29 or 26, depending on the round)
- "N wk ahead cum hosp"  where N is a number between 1 and 42 (or 29 or 26, depending on the round)
- "peak size hosp"  
- "N wk ahead peak time hosp"  where N is a number between 1 and 42 (or 29 or 26, depending on the round)

<b>For the optional "sample" file format:</b> Only the two incident targets are requested: 
- weekly incident deaths
- weekly incident hospitalizations

For week-ahead scenarios, we will use the specification of epidemiological weeks (EWs) defined by the US CDC which run Sunday through Saturday.


#### N wk ahead inc death

This target is the national incident (weekly) number of deaths predicted
by the model during the week that is N weeks after
`model_projection_date`. There should not be any death projections at
the state level. 

A week-ahead scenario should represent the total number of new deaths
reported during a given epiweek (from Sunday through Saturday,
inclusive).

Predictions for this target will be evaluated compared to the number of
new deaths derived from the CDC multiplier model, which inflates flu
deaths reported in the hospital by a factor accounting for
underreporting and out-of-hospital mortality.These estimates are
published in real time starting a few weeks into the influenza
season. 


#### N wk ahead cum death

This target is the national cumulative number of deaths predicted by the
model up to and including N weeks after `model_projection_date`. There
should be 0 cumulative deaths on week 0 of projection.

A week-ahead scenario should represent the cumulative number of deaths
reported on the Saturday of a given epiweek.

Predictions for this target will be evaluated compared to the number of
cumulative deaths derived from the CDC multiplier model, which inflates
flu deaths reported in the hospital by a factor accounting for
underreporting and out-of-hospital mortality.These estimates are
published in real time starting a few weeks into the influenza season.


#### N wk ahead inc hosp

This target is the incident (weekly) number of hospitalized cases
predicted by the model during the week that is N weeks after
`model_projection_date`.

A week-ahead scenario should represent the total number of new
hospitalized cases reported during a given epiweek (from Sunday through
Saturday, inclusive).

Predictions for this target will be evaluated against the weekly number
of new hospitalized cases, as recorded by the U.S. Department of
Health & Human Services Flu and COVID-19 system (derived from the prior
day influenza admissions variable). 


#### N wk ahead cum hosp

This target is the cumulative number of incident (weekly) number of
hospitalized cases predicted by the model during the week that is N
weeks after `model_projection_date`.  There should be 0 cumulative
hospitalization on week 0 of projection.

A week-ahead scenario should represent the cumulative number of
hospitalized cases reported up to the Saturday of a given epiweek.

Predictions for this target will be evaluated against the cumulative
number of hospitalized cases since the start of the projection period,
as recorded by the U.S. Department of Health & Human Services Flu and
COVID-19 system (derived from the prior day influenza admissions
variable)


#### N wk ahead peak time hosp

This target is the cumulative probability of the incident
hospitalization peak occurring before or during the week that is N
weeks after `model_projection_date`. For instance "22 wk ahead peak
time hosp" is the probability that hospitalizations peak within the
first 22 weeks of the projection period. This cumulative probability
will be 1 on the last week of the projection period.

Further, we do not expect a full distribution of quantiles, only “point”
values for this target.

Predictions for this target will be evaluated against the week of the
peak number of hospitalized cases in 2022-23, as recorded by the U.S.
Department of Health & Human Services Flu and COVID-19 system
(derived from the prior day influenza admissions variable).

#### peak size hosp

This target is the magnitude of the peak of weekly incident
hospitalizations in the model, when considering the full projection
period. 

Further, we do not expect a full time series, the `target_end_date`
column associated with this value should be set to `NA`.

Predictions for this target will be evaluated against the size of the
peak number of weekly hospitalized cases in 2022-23, as recorded by the
U.S. Department of Health & Human Services Flu and COVID-19 system
(derived from the prior day influenza admissions variable).


### `target_end_date`

Values in the `target_end_date` column must be a date in the format

```
YYYY-MM-DD
``` 

This is the date for the scenario `target`.

The target and target_end_date columns are associated. For "# wk" targets,
`target_end_date` will be the Saturday at the end of the week time period. A
week-ahead projection should represent the total number of incident deaths or
hospitalizations within a given epiweek (from Sunday through Saturday,
inclusive) or the cumulative number of deaths reported on the Saturday of a
given epiweek. Model projection dates in the Flu Scenario Modeling Hub
are equivelent to the model projection dates in the 
[COVID-19 Scenario Modeling Hub](covid19scenariomodelinghub.org/).

It can be calculated as:

- in days: `model_projection_date` - `1` (as model_projection_date is the
start (first) day of projection) + `(N * 7)` days (N being the number of
week ahead in the associated target, e.g `"1 wk ahead"`, `"2 wk ahead"`)
to have it in days.

- in epiweek: `model_projection_date` epiweek - `1` + `N`. In this case the last day
(Saturday) of the epiweek should be reported in the column
`target_end_date`
 

The start and end date information of the whole expected timeseries are in the main README
("Start date for scenarios" and "Simulation end date").

For example, if a round is defined with:
* Start date for scenarios: October 30, 2022 (first date of simulated transmission/outcomes)
* Simulation end date: April 29, 2023 (26-week horizon)

Then the weeks ahead projection would corresponds to:
- target `1 wk ahead`: `2022-10-30 - 1 + (1 * 7)` equals target_end_date: `"2022-11-05"`
(Saturday), and corresponds to EW44
- target `2 wk ahead`: `2022-10-30 - 1 + (2 * 7)` equals target_end_date: `"2022-11-12"`
(Saturday), and corresponds to EW45
- etc.
- until target `26 wk ahead`, target_end_date: `"2023-04-29" `

### `location`

Values in the `location` column must be one of the "locations" in this 
[FIPS numeric code file](../data-locations/locations.csv) which includes 
numeric FIPS codes for U.S. states, counties, territories, and districts as 
well as "US" for national scenarios. 

Please note that when writing FIPS codes, they should be written in as a 
character string to preserve any leading zeroes.


### `type`

Values in the `type` column are either

- "point" or
- "quantile".

This value indicates whether that row corresponds to a point scenario or a 
quantile scenario. Point scenarios are used in visualization while quantile 
scenarios are used in visualization and in ensemble construction. 

The "point" value for the `"cum death"`, `"inc death"`, `"cum hosp"`, 
`"inc hosp"` and `"peak size hosp"` targets is optional. If no "point" values 
are provided, the quantiles values will be used for visualization


### `quantile`

Values in the `quantile` column are either "NA" (if `type` is "point") or a 
quantile in the format

    0.###
    
For quantile scenarios, this value indicates the quantile for the `value` in 
this row. 

Teams should provide the following 23 quantiles:

``` 
0.010 0.025 0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500
0.550 0.600 0.650 0.700 0.750, 0.800 0.850 0.900 0.950 0.975 0.990 
```

Two optionals additional quantiles can also be submitted: `0`(min) and `1`
(max). 

### `sample`

For the optional simulation samples format only. Values in the `sample` column 
are numeric between `1` and `100` indicating an id sample number.


### `value`

Values in the `value` column are non-negative numbers indicating the "point" or 
"quantile" prediction for this row. For a "point" prediction, `value` is simply 
the value of that point prediction for the `target` and `location` associated 
with that row. For a "quantile" prediction, `value` is the inverse of the cumulative 
distribution function (CDF) for the `target`, `location`, and `quantile` associated 
with that row.

#### Peak time hosp

For the `peak time hosp` target, the values in the `value` column are non-negative 
numbers between 0 and 1.  


### `age_group ` 

Values in the  `age_group` column are:

- "0-4"
- "5-17"
- "18-49"
- "50-64"
- "65-130"
Or any aggregation of the previous list, for example: "0-17". 
If the submissions files contain projections for the overall population, 
please use `0-130` as age-group. 

The `age_group` are optionals, however, the submission should contain at least 
one age group: `0-130`, if multiples `age_group` are provided the overall 
population should still be provided with the age group `0-130`. 

For the `peak` targets, only the age-group `0-130` is required.

## Scenario validation

To ensure proper data formatting, pull requests for new data or updates in
data-processed/ will be automatically validated

When a pull request is submitted, the data are validated by running the
scripts in [validation.R](./code/validation/validation.R). The intent for
these tests are to validate the requirements above and all checks are 
specifically enumerated [on the wiki](https://github.com/midas-network/flu-scenario-modeling-hub/wiki/Scenario-File-Checks).

Please [let us know](https://github.com/midas-network/flu-scenario-modeling-hub/issues) if
the wiki is inaccurate.

#### Workflow

When a pull request is submitted, the validation will be 
automatically triggered.

- If the pull request (PR) contains update on metadata 
and/or abstract file(s):
    - These files are manually validated, the automatic validation
    will only returns a message indicating it did not run any
    validation. 

- If the PR contains model output submission file(s). The validation 
automatically runs and output a message and a PDF file containing the 
projections of the requested targets at national and State level, 
plus some information on calibration.

    - The validation has 3 possible output:
        - "Error": the validation has failled and returned a message 
        indicating the error(s). The error(s) should be fixed to have the PR 
        accepted
        - "Warning": the PR can be accepted. However, it might be necessary 
        for the submitting team to validate if the warning(s) is expected or 
        not before merging the PR.
        - "Success": the validation did not found any issue and returns a message 
        indicating that the validation is a success and the PR can be merged.

    - The PDF file containing the visualization is accessible has an artifact of 
    the GitHub Actions. 
    For more information, please see [here](https://docs.github.com/en/actions/managing-workflow-runs/downloading-workflow-artifacts)



#### Run checks locally

To run these checks locally rather than waiting for the results from a pull
request, follow [these instructions](https://github.com/midas-network/flu-scenario-modeling-hub/wiki/Scenario-File-Checks#file-checks-running-locally)
(section File Checks Run Locally).




