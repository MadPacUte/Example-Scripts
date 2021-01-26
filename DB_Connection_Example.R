require(RCurl)
require(tidyverse)
require(lubridate)
require(DBI)
require(odbc)


# unique(odbcListDrivers())


conn <- 
  dbConnect(
    odbc(),
    UID = "example@example.com",
    Driver = 'ODBC Driver 17 for SQL Server',
    Server = 'server location',
    Database = 'database',
    Authentication = 'ActiveDirectoryInteractive'
  )

query <- 
  "
  SELECT TOP 100 l.LeadID
  FROM dbo.Lead l
"

results <- 
  dbSendQuery(
    conn,
    query
  )

df <- 
  as_tibble(data.fram(dbFetch(results)))

dbClearResult(results)