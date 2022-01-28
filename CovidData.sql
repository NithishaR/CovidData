Select *
from CovidData..CovidDeaths
where continent is not null
Order by 3,4

--Select *
--from CovidData..CovidVaccinations
--Order by 3,4

-- Select the data

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidData..CovidDeaths
order by 1,2

-- Total cases and total deaths: Probability of dying if the person contracts covid in United states

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidData..CovidDeaths
where location like '%states%'
and continent is not null
order by 1,2

-- Total cases Vs Population: Percentage of population contracted covid

Select Location, date, Population, total_cases, (total_deaths/Population)*100 as PercentPopulationInfected
From CovidData..CovidDeaths
--where location like '%states%'
order by 1,2

-- Countries with highest infection rate compared to population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_deaths/Population))*100 as 
PercentPopulationInfected
From CovidData..CovidDeaths
--where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with highest death count per population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidData..CovidDeaths
--where location like '%states%'
Where continent is not null
Group by Location
order by TotalDeathCount desc

--By continent: Highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidData..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

-- Global Numbers:

Select SUM(New_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(New_deaths as int))/SUM(New_cases)*100
as DeathPercentage
from CovidData..CovidDeaths
--Where location like '%states%'
Where continent is not null
--Group by date
order by 1,2

--Total population vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidData..CovidDeaths dea
Join CovidData..CovidVaccinations vac
     on dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3







