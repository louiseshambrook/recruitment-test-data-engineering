#!/usr/bin/env Rscript

library(tidyverse)
library(jsonlite)
library(DBI)

# connect to the database
database <- dbConnect(RMySQL::MySQL(),
                      user = 'codetest',
                      password = 'swordfish',
                      dbname = 'codetest',
                      host = 'database')

# reading the CSV data files into the tables
my_test_schema.people <- read_csv("data/people.csv")
my_test_schema.places <- read_csv("data/places.csv")

# this is incomplete - I have not used apply in combination with SQL before
apply(example_data, c(1, 2), function(x) dbSendQuery(database, paste0("insert into examples(name) values('", x, "')")))

# to be able to join the datasets, renaming place_of_birth on the people dataset
people <- people %>%
  rename(city = "place_of_birth")

# joining the tables, using an inner join to include all rows in both datasets
people_places <- people %>%
  inner_join(places, by = "city")

# wrangling and calculating the total count
summary_people_places <- people_places %>%
  group_by(country) %>%
  count()

# output the table to a JSON file (this is likely also incomplete)
res <- dbSendQuery(database, "select * from examples")
output = dbFetch(res)
dbClearResult(res)

write_json(summary_people_places, '/data/example_r.json', pretty = FALSE)
