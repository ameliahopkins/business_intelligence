# ISA 401 Job Scout Chat: ask questions, get SQL, a table, or a chart back

library(querychat)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat::querychat(
  con, "listings",
  client   = client,
  tools    = c("filter", "query", "visualize"),  # visualize: charts in the chat (needs ggsql)
  greeting = "Ask me about Midwest Airbnb Listings."
)

shiny::runApp(
  appDir = qc$app_obj(),
  host = "0.0.0.0",
  port = as.integer(Sys.getenv("PORT", "10000")),
  launch.browser = FALSE
)
