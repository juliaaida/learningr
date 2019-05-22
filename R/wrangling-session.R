source(here::here("R/package-loading.R"))

glimpse(NHANES)


#these two commands are the same

NHANES %>%
  colnames() %>%
  length()

length(colnames(NHANES))

#other functions

NHANES %>%
mutate(Height = Height / 100,
       Testing = "yes",
       HeighActive = if_else(
        PhysActiveDays >= 5,
        "yes",
        "no"
       ))

# Pipe the data into mutate function and:
NHANES_modified <- NHANES %>% # dataset
  mutate(
    # 1. Calculate average urine volume
    UrineVolAverage =(UrineVol1+UrineVol2)/2,
    # 2. Modify Pulse variable
    Pulse = Pulse / 60,
    # 3. Create YoungChild variable using a condition
    YoungChild = if_else(Age < 5, "yes", "no")
  )

str(NHANES_modified)
NHANES_modified$UrineVolAverage
attach(NHANES_modified)
summay(UrineVolAverage)

# Selecting variables -----------------------------------------------------

NHANES %>%
  select(Age, Gender, BMI)

NHANES %>%
  select(-BMI)

NHANES %>%
  select(start_with("Smoke"),
         contains("Vol"),
         matches("[123]")) #select variables with at least 1 2 or 3

NHANES %>%
  rename(#Newname = Oldname
    NumberBabies = nBabies,
    Sex = Gender)

NHANES %>%
  select(BMI,
         NumberBabies = nBabies,
         Sex = Gender, Height)

NHANES %>%
  filter(Gender == "female")

NHANES %>%
  filter(Gender != "female") # not equal

NHANES %>%
  filter(BMI >= 25 & Gender == "female" & Age < 20)   # and =&, or = |

NHANES %>%
  arrange(desc(Age), Gender) %>%    # desc: sort in descending
  select(Age, Gender)



# Exercice ----------------------------------------------------------------


# To see values of categorical data
str(NHANES)

# 1. BMI between 20 and 40 and who have diabetes
NHANES %>%
  # format: variable >= number
  filter(BMI >= 20 & BMI <= 40 & Diabetes == 1)

# 2. Working or renting, and not diabetes
NHANES %>%
  filter((Work == 3 | HomeOwn == 2) & Diabetes != 1) %>%
  select(Work, HomeOwn, Diabetes)

# 3. How old is person with most number of children.
NHANES %>%
  arrange(desc(nBabies)) %>%
  select(Age, nBabies)

NHANES %>%
  select(Age, nBabies) %>%
  filter(nBabies==max(nBabies, na.rm = TRUE))





# Group and summarize -----------------------------------------------------



NHANES %>%
  summarise(
    MaxAge = max(Age, na.rm = TRUE
                 MinBMI = min(BMI, na.rm = TRUE))
    #na.rm remove missing value

    NHANES %>%
      group_by(Gender) %>%
      summarise(MeanBMI = mean(BMI, na.rm = TRUE))

    NHANES %>%
      group_by(Gender, Work) %>%
      summarise(
        MeanBMI = mean(BMI, na.rm = TRUE),
        MeanAge = mean(Age, na.rm = TRUE)
      )


    # Gathering ---------------------------------------------------------------

    # Original data
    table4b


    # Convert to long form by stacking population by each year
    # Use minue to exclude a variable (country) from being "gathered"

    table4b %>%
      gather(year, population, -country)

    #country : remains the same so we dont use it as it is the identifier
    #year and population have to be transposed

    ? gather #F1 for help


    # This does the same:
    table4b %>%
      gather(year, population, `1999`, `2000`)

    nhanes_simple <- NHANES %>%
      select(SurveyYr, Gender, Age, Weight, Height, BMI, BPSysAve)

    str(nhanes_simple)

    nhanes_long <- nhanes_simple %>%
      gather(Measure, Value,-SurveyYr,-Gender)

    str(nhanes_long)

  nhanes_summary  <- nhanes_long %>%
      group_by(SurveyYr,Gender, Measure) %>%
      summarise(MeanValue=mean(Value, na.rm=T))

  nhanes_summary %>%
    spread(Gender, MeanValue)

  nhanes_summary %>%
    spread(SurveyYr, MeanValue)


# Exercice wrangling ------------------------------------------------------



  nhanes_wrangled <- NHANES %>%

    mutate(MoreThan5DaysActive = if_else(PhysActiveDays >= 5, TRUE, FALSE)) %>%
    select(
      SurveyYr,
      Gender,
      Age,
      Poverty,
      BMI,
      BPSysAve,
      BPDiaAve,
      TotChol,
      DiabetesAge,
      nBabies,
      MoreThan5DaysActive,
      AlcoholDay
    ) %>%
    rename(
      TotalCholesterol = TotChol,
      NumberOfBabies = nBabies,
      DrinksOfAlcoholInDay = AlcoholDay,
      AgeDiabetesDiagnosis = DiabetesAge
    ) %>%

    filter(Age >= 18, Age <= 75)
  nhanes_wrangled

  nhanes_wrangled %>%
    gather(Measure, Value,-SurveyYr,-Gender) %>%
    group_by(SurveyYr, Gender, Measure) %>%
    summarise(Mean = round(mean(Value, na.rm = TRUE), 2)) %>%
    arrange(Measure, Gender, SurveyYr) %>%
    spread(SurveyYr, Mean)
