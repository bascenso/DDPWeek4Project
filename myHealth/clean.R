
# Getting and preparing the data

health_raw <- read.csv("HealthData.csv")

health <- health_raw

names(health) <- c("start", "finish", "calories", "hrate", "steps")

health$start <- sub("Jan", "jan", health$start)
health$start <- sub("Feb", "fev", health$start)
health$start <- sub("Mar", "mar", health$start)
health$start <- sub("Apr", "abr", health$start)
health$start <- sub("May", "mai", health$start)
health$start <- sub("Jun", "jun", health$start)
health$start <- sub("Jul", "jul", health$start)
health$start <- sub("Aug", "ago", health$start)
health$start <- sub("Sep", "set", health$start)
health$start <- sub("Oct", "out", health$start)
health$start <- sub("Nov", "nov", health$start)
health$start <- sub("Dec", "dez", health$start)

health$finish <- sub("Jan", "jan", health$finish)
health$finish <- sub("Feb", "fev", health$finish)
health$finish <- sub("Mar", "mar", health$finish)
health$finish <- sub("Apr", "abr", health$finish)
health$finish <- sub("May", "mai", health$finish)
health$finish <- sub("Jun", "jun", health$finish)
health$finish <- sub("Jul", "jul", health$finish)
health$finish <- sub("Aug", "ago", health$finish)
health$finish <- sub("Sep", "set", health$finish)
health$finish <- sub("Oct", "out", health$finish)
health$finish <- sub("Nov", "nov", health$finish)
health$finish <- sub("Dec", "dez", health$finish)

health$start <- strptime(health$start, format = "%d-%b-%Y %H:%M", tz = "Europe/Lisbon")
health$finish <- strptime(health$finish, format = "%d-%b-%Y %H:%M", tz = "Europe/Lisbon")

saveRDS(health, file = "health.RDS")

