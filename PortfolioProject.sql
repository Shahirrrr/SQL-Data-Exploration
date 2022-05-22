SELECT *
From PortfolioProject..CovidDeath$
order by 3,4

SELECT  *
From PortfolioProject..CovidVaccination$
order by 3,4

SELECT *
From PortfolioProject..CovidDeath$
order by 3,4

--Select data that going to used

SELECT Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeath$
Order by 1,2

-- Total cases vs Total Deaths
-- Show the likelyhood of dying if you have covid
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)
From PortfolioProject..CovidDeath$
Order by 1,2

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)
From PortfolioProject..CovidDeath$
Where location like '%Malaysia%'
Order by 1,2

--look at total cases vs population
--show the percentage of population got covid 
SELECT Location, date, population, total_cases,  (total_cases/population)*100 as DeathPercentage
From PortfolioProject..CovidDeath$
Where location like '%Malaysia%'
Order by 1,2

-- Country with highest rate of infection
SELECT Location,population, MAX(total_cases) as Highest,  MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath$
Group by Location, population
Order by PercentPopulationInfected desc

-- Country with highest death
SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath$
Where continent is not null
Group by Location
Order by TotalDeathCount desc

-- continent
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath$
Where continent is null
Group by location
Order by TotalDeathCount desc

--Showing the continent with highest death per population

SELECT date, SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeath, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath$
Where continent is not null
Group by date
Order by 1,2

-- Let take a look at vaccination table
-- looking at total population vs vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeath$ dea
Join PortfolioProject..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.location like '%Malaysia%'
order by 2,3

SELECT continent, location, date,population, new_vaccinations
From PortfolioProject..CovidVaccination$ 
Delete from PortfolioProject..CovidVaccination$ where [new_vaccinations] = 'NULL'

Select dea.continent, dea.location, dea.date, dea.population --ISNULL(vac.new_vaccinations,'0'),SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location)
From PortfolioProject..CovidDeath$ dea
Join PortfolioProject..CovidVaccination$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
where vac.new_vaccinations is not null 
order by 2,3 