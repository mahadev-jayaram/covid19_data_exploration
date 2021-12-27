/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

Select *
From covid..deaths
Where continent is not null 
order by 3,4


-- Selecting data that we are going to be starting with

Select Location, date, total_cases, new_cases, total_deaths, population
From covid..deaths
Where continent is not null 
order by 1,2


--Tableau 1,2
/*
""rows 6 preceding""  is same as ""between 6 preceding and current row""........just a shorthand notation 
when we have any bound in window frame as current row

its not possible to use round() function with window function,so i have created a cte
*/

--new_cases,new_cases_last_7days_average,new_deaths, new_deaths_last_7days_average using widow functions
with cte
as
(
	Select location, date,new_cases,new_deaths
	,avg(new_cases) over(
	partition by location 
	order by date
	rows 6 preceding
	) as new_cases_last_7days_average

	,avg(cast(new_deaths as float)) over(
	partition by location 
	order by date
	rows 6 preceding
	) as new_deaths_last_7days_average
	From covid..deaths
)

select location, date,new_cases,round(cte.new_cases_last_7days_average,0) as new_cases_last_7days_average
,new_deaths,round(cte.new_deaths_last_7days_average,0) as new_deaths_last_7days_average
from cte
WHERE location = 'India'




--Tableau 3
-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid..deaths
Group by Location, Population
order by PercentPopulationInfected desc

--------------------------------------------------------------------------------------------------

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contacted covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid..deaths
--Where location = 'India'
Where continent is not null 
order by 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From covid..deaths
--Where location = 'India'
order by 1,2


-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From covid..deaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc

---------------------------------------------------------------------------------------------------


--Tableau 4
-- Showing contintents with the highest death count per population


Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From covid..deaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


--Tableau 5

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid..deaths
Group by  Location, Population, date
order by PercentPopulationInfected desc



-- GLOBAL NUMBERS

Select SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as Death_percentage
From covid..deaths
where continent is not null 
--Group By date
order by 1,2



--Finding cummulative vaccinations w.r.t locations by using WINDOW FUNCTIONS
--By using order by clause inside window function we are making the default window frame as ""Range between unbounded preceeding and current row""

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as cummulative_vaccinations
From covid..deaths dea
Join covid..vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3



-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one dose of Covid Vaccine USING CTE


With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, cummulative_vaccinations)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as cummulative_vaccinations
From covid..deaths dea
Join covid..vac 
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (cummulative_vaccinations/Population)*100 as cummulative_vac_perc
From PopvsVac




-- Creating View to store data for later visualizations

Create View vwPercentPopulationVaccinated 
as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as cummulative_vac_perc
From covid..deaths dea
Join covid..vac 
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null



--To see the created view

select * from vwPercentPopulationVaccinated

/*
link for Tableau portfolio
https://public.tableau.com/app/profile/mahadev.jayaram/viz/COVID-19DATAANALYSIS_16406260262990/Dashboard1?publish=yes
*/