# CompanysRanks

This is a simple API built with Flask framework and PostgreSQL database.

## Preparing the ambient to run
1. Download and install [Python 3.7+](https://www.python.org/downloads/)
   * Make sure to have the command __python__ working in your _terminal/cmd_
   * Make sure to have __PIP__ working as well!

2. In your _terminal/cmd_ change the folder to the Server project root;
   * Run `pip install -r requirements.txt`;
   
3. Download and install [PostgreSQL 9.5+](https://www.postgresql.org/download/);
   * (Windows) Make sure to have your PostgreSQL bin folder added in your enviroment variables;
   * In your _terminal/cmd_, run `pg_restore --clean -U postgres --dbname companiesranks ./database/companiesranks.psql`;
   
## To run the API you'll need to set some enviroment variables
* Run `export FLASK_APP=app.py`;  
* Run `export FLASK_ENV=development`;  
* On Windows cmd, you'll have to use `set` instead of `export`;  
* Then, to start the aplication you can run `flask run --host 0.0.0.0 --port 5000`;  
* If you have the 'make tool' working, then you just need to run `make run` in the project root folder;  

## APIs breakdown
* `/companies` -> This GET endpoint returns all the companies available in the database;  
* `/company_reports/<company_id>` -> this GET endpoing returns a list of the performed calculations from a specific company;   
* `/companiesNames` -> This GET endpoint returns the list of company's names;  
* `/importData` -> This POST endpoint receives a .csv file and reads it in order to update the company score.
