::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCmDJHSL8EY5JhxobwWQMmKsCacZ+9TP4OWLsXE8WPYafIbPmp2nYMke+lfrY5Mp6mhflM4NHx5kLVyibQBU
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCmDJHSL8EY5JhxobwWQMmKsCacZ+9TP4OWLsXE8WPYafIbPmp2nYMke+lfrY5Mp6mhflM4NHx5kXx6/Sws9vWFQ5CqAL8L8
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
cd /d "%~dp0"
tasklist /FI "IMAGENAME eq dxwnd.exe" 2>nul | find /I "dxwnd.exe" >nul
if errorlevel 1 (
    start "" ".\dxwnd.exe" /R:1
) else (
    start "" ".\dxwnd.exe" /Y:#1
)
