---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

includes:
  - errors

search: true
---

# Introduction

Welcome to the balldontlie API!
You can use our free API to access NBA related data.

We created this because we were frustrated by the lack of free, quality NBA APIs, and we want to empower the basketball community to build cool things.
We don't require an API key and there are no rate restrictions, but please try not to spam us to death.

We hope to build upon this initial release with input from users. If you have any requests, comments, or questions, please
feel free to email us at hello@balldontlie.io.

Also, here's our Patreon in case you want to support us.

## Getting Started
You need a computer with internet connection.

* no email required
* no API key required
* contains data from 1980-current
* game stats are available about 1 hour after completion

# Players

## Get All Players
```shell
curl "https://www.balldontlie.io/api/v1/players"
```

> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "id": 1,
      "first_name": "LeBron",
      "last_name": "James",
      "position": "G",
      "team": {
        "id": 1,
        "conference": "West",
        "division": "Pacific",
        "city": "Los Angeles",
        "abbreviation": "LAL",
        "name": "Lakers",
        "full_name": "Los Angeles Lakers"
      }
    },
    ...
  ],
  "meta": {
    "total_pages": 50,
    "current_page": 1,
    "next_page": 2,
    "per_page": 25,
    "total_count": 9999
  }
}
```

This endpoint retrieves all players from all seasons.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/players`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 25 | The number of results returned per call, used for pagination.
search | | Used to filter players based on their name. For example, `?search=davis` will return players that have 'davis' in their first or last name.

## Get a Specific Player

```shell
curl "https://www.balldontlie.io/api/v1/players/1"
```

> The above command returns JSON structured like this:

```json
{
  "id": 1,
  "first_name": "LeBron",
  "last_name": "James",
  "position": "G",
  "team": {
    "id": 1,
    "conference": "West",
    "division": "Pacific",
    "city": "Los Angeles",
    "abbreviation": "LAL",
    "name": "Lakers",
    "full_name": "Los Angeles Lakers"
  }
}
```

This endpoint retrieves a specific player.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/players/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the player to retrieve

# Teams

## Get All Teams
```shell
curl "https://www.balldontlie.io/api/v1/teams"
```

> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "id": 1,
      "conference": "West",
      "division": "Pacific",
      "city": "Los Angeles",
      "abbreviation": "LAL",
      "name": "Lakers",
      "full_name": "Los Angeles Lakers"
    },
    ...
  ],
  "meta": {
    "total_pages": 1,
    "current_page": 1,
    "next_page": null,
    "per_page": 30,
    "total_count": 30
  }
}
```

This endpoint retrieves all teams for the current season.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/teams`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 30 | The number of results returned per call, used for pagination.

## Get a Specific Team

```shell
curl "https://www.balldontlie.io/api/v1/teams/1"
```

> The above command returns JSON structured like this:

```json
{
  "id": 1,
  "conference": "West",
  "division": "Pacific",
  "city": "Los Angeles",
  "abbreviation": "LAL",
  "name": "Lakers",
  "full_name": "Los Angeles Lakers"
}
```

This endpoint retrieves a specific team.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/teams/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the team to retrieve

# Games

## Get All Games
```shell
curl "https://www.balldontlie.io/api/v1/games"
```

> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "id": 1,
      "date": "2019-01-22",
      "season": 2018,
      "home_team_score": 99,
      "visitor_team_score": 90,
      "home_team": {
        "id": 1,
        "conference": "West",
        "division": "Pacific",
        "city": "Los Angeles",
        "abbreviation": "LAL",
        "name": "Lakers",
        "full_name": "Los Angeles Lakers"
      },
      "visitor_team": {
        "id": 2,
        "conference": "West",
        "division": "Pacific",
        "city": "Los Angeles",
        "abbreviation": "LAC",
        "name": "Clippers",
        "full_name": "Los Angeles Clippers"
      }
    },
    ...
  ],
  "meta": {
    "total_pages": 9999,
    "current_page": 1,
    "next_page": 2,
    "per_page": 25,
    "total_count": 99999
  }
}
```

This endpoint retrieves all games. We don't support live data. Games will be posted within 1 hour of their completion.

Seasons are represented by the year they began. For example, 2018 represents season 2018-2019.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/games`

### Query Parameters

Combining multiple query parameters is the same as applying `&` boolean logic. For example, `?seasons[]=2018&team_ids[]=1` will return games played by team_id 1 for the 2018-2019 season.

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 25 | The number of results returned per call, used for pagination.
dates | | An array of dates formatted in 'YYYY-MM-DD'
seasons | | An array of seasons
team_ids | | An array of team_ids

## Get a Specific Game

```shell
curl "https://www.balldontlie.io/api/v1/games/1"
```

> The above command returns JSON structured like this:

```json
{
  "id": 1,
  "date": "2019-01-22",
  "season": 2018,
  "home_team_score": 99,
  "visitor_team_score": 90,
  "home_team": {
    "id": 1,
    "conference": "West",
    "division": "Pacific",
    "city": "Los Angeles",
    "abbreviation": "LAL",
    "name": "Lakers",
    "full_name": "Los Angeles Lakers"
  },
  "visitor_team": {
    "id": 2,
    "conference": "West",
    "division": "Pacific",
    "city": "Los Angeles",
    "abbreviation": "LAC",
    "name": "Clippers",
    "full_name": "Los Angeles Clippers"
  }
}
```

This endpoint retrieves a specific game.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/games/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the game to retrieve

# Stats

## Get All Stats
```shell
curl "https://www.balldontlie.io/api/v1/stats"
```

> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "id": 1,
      "min": "42:23",
      "fgm": 10,
      "fga": 20,
      "fg_pct": 0.50,
      "fg3m": 2,
      "fg3a": 4,
      "fg3_pct": 0.50,
      "ftm": 3,
      "fta": 3,
      "ft_pct": 1,
      "oreb": 0,
      "dreb": 4,
      "reb": 4,
      "ast": 10,
      "stl": 4,
      "blk": 1,
      "turnover": 4,
      "pf": 1,
      "pts": 30,
      "player": {
        "id": 1,
        "first_name": "LeBron",
        "last_name": "James",
        "position": "G",
        "team_id": 1
      },
      "game": {
      },
      "team": {
      }
    },
    ...
  ],
  "meta": {
    "total_pages": 9999,
    "current_page": 1,
    "next_page": 2,
    "per_page": 25,
    "total_count": 99999
  }
}
```

This endpoint retrieves all stats.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/stats`

### Query Parameters

Combining multiple query parameters is the same as applying `&` boolean logic. For example, `?seasons[]=2018&player_ids[]=1&player_ids[]=2` will return stats for player_ids 1 and 2 for the 2018-2019 season.

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 25 | The number of results returned per call, used for pagination.
dates | | An array of dates formatted in 'YYYY-MM-DD'
seasons | | An array of seasons
player_ids | | An array of player_ids
game_ids | | An array of game_ids
