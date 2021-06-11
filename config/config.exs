import Config

config :disney_toilet, Toilet.Repo,
  database: "disney_toilet_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
  config :disney_toilet, ecto_repos: [Toilet.Repo]
