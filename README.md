# Covid-19 Data Exploaration
(Data between 1/22/2020 to 12/13/2021)


## 1. Project Description
This project aims to describes the definitions and calculations of various covid related indicators present on the national corona dashboard. Supplementary information can be found at https://ourworldindata.org/covid-deaths. A variety of data sources is used to calculate the various indicators. Some indicators are calculated using a single data source, others require a combination of data sources. 

### 1.1 Language used:
    * T-SQL

### 1.2 Tools used:
    * Microsoft SQL Server 2019
    * Tableau Public 2021

### 1.3 Skills used:
    * Joins
    * CTE's
    * Window Functions
    * Aggregate Functions
    * Creating Views

## 2. Project Definition
SQL queries are made on database to retrieve data to indicate variuos covid indicators

### 2.1 Covid indicators
    * Percent population infected
    * Death percentage
    * 7days new cases average
    * 7days new deaths average
    * Death rate comparision between 2020 and 2021 wrt countries
    * Percent population vaccinated

### 2.1 Results

    Death percentage = Total deaths in a country/population of the country
    Death rate = Total deaths in a country/total cases of the country

    * Country with highest infection percentage is found be Montenegro i.e, 24.5% of its population are infected with covid-19.

    * Country with highest death percentage is found be Peru i.e, 0.604% of its population are died due to covid-19

    * Continent with highest death count is found to be North America contributing to 35.2% of the deaths in entire world

    * Country with atleast 1 lakh covid cases and having highest death rate is found be Peru i.e, 8.95% of people who got infected are died in this 
      country.

    * Death rate comparision between 2020 and 2021
    
        Singapore seems to have the highest negative improvment having 0.049% of death rate in 2020 and 0.357%  in 2021 having a increase in death rate by 7.22 times from 2020 to 2021!!

        China seems to have the highest positive improvment having 5.33% of death rate in 2020 and 0.0156%  in 2021 having a decrease in death rate by 341.6 times from 2020 to 2021!!
      
      
      
  ## Appendix

link for Tableau portfolio

https://public.tableau.com/app/profile/mahadev.jayaram/viz/COVID-19DATAANALYSIS_16406260262990/Dashboard1
