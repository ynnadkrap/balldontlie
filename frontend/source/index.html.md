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

You can use our free API to access NBA related data. No email required. No API key required.

This is an [open source project](https://github.com/ynnadkrap/balldontlie). Feel free to open issues and pull requests.

Here's an example of something you can build with this API: [example](https://balldontlie-example.herokuapp.com/)

If your sole purpose is to scrape all the data, please reach out to instead of bombarding our servers. We'll give you the data.

Email us at hello@balldontlie.io with any comments or questions. We hope to build on top of this first iteration with community input. Please reach out if you want to help.

Also, please feel free to [donate](https://www.patreon.com/balldontlie) to help keep the lights on.

## Getting Started
You need a computer with internet connection.

* No email required
* No API key required
* Contains data from seasons 1979-current
* Live(ish) game stats are available (updated every ~10 minutes)
* Rate limit of 60 requests per minute

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/c51c3810db2ab3ca4ab4)

# Players

## Get All Players
```shell
curl "https://www.balldontlie.io/api/v1/players"
```

> The above command returns JSON structured like this:

```json
{
  "data":[
    {
      "id":237,
      "first_name":"LeBron",
      "last_name":"James",
      "position":"F",
      "height_feet": 6,
      "height_inches": 8,
      "weight_pounds": 250,
      "team":{
        "id":14,
        "abbreviation":"LAL",
        "city":"Los Angeles",
        "conference":"West",
        "division":"Pacific",
        "full_name":"Los Angeles Lakers",
        "name":"Lakers"
      }
    }
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
per_page | 25 | The number of results returned per call, used for pagination. Max 100.
search | | Used to filter players based on their name. For example, `?search=davis` will return players that have 'davis' in their first or last name.

## Get a Specific Player

```shell
curl "https://www.balldontlie.io/api/v1/players/237"
```

> The above command returns JSON structured like this:

```json
{
  "id":237,
  "first_name":"LeBron",
  "last_name":"James",
  "position":"F",
  "height_feet": 6,
  "height_inches": 8,
  "weight_pounds": 250,
  "team":{
    "id":14,
    "abbreviation":"LAL",
    "city":"Los Angeles",
    "conference":"West",
    "division":"Pacific",
    "full_name":"Los Angeles Lakers",
    "name":"Lakers"
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

## Considerations

<aside class="warning">Not all players will have height_feet, height_inches, or weight_pounds.</aside>

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
      "id":14,
      "abbreviation":"LAL",
      "city":"Los Angeles",
      "conference":"West",
      "division":"Pacific",
      "full_name":"Los Angeles Lakers",
      "name":"Lakers"
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
curl "https://www.balldontlie.io/api/v1/teams/14"
```

> The above command returns JSON structured like this:

```json
{
  "id":14,
  "abbreviation":"LAL",
  "city":"Los Angeles",
  "conference":"West",
  "division":"Pacific",
  "full_name":"Los Angeles Lakers",
  "name":"Lakers"
}
```

This endpoint retrieves a specific team.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/teams/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the team to retrieve

## Considerations

<aside class="warning">We only contain information on current NBA teams.</aside>

# Games

## Attributes
These attributes are worth noting:

Attribute | Type | Values | Notes
--------- | ---- | ------ | -----------
period | integer | 0, 1, 2, 3, 4 | 0 will be returned for games that have not started. 4 will be returned when a game is either complete or in the 4th quarter.
status | string |  `{start_time}`, 1st Qtr, 2nd Qtr, Halftime, 3rd Qtr, 4th Qtr, Final | `{start_time}` looks something like "7:00 pm ET", which indicates that the game has not started yet.
time | string | `{time_in_period}`, " " | `${time_in_period}` looks something like "3:44". " " is an empty string that is returned when game has not started or is complete.

## Get All Games
```shell
curl "https://www.balldontlie.io/api/v1/games"
```

> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "id":1,
      "date":"2018-10-16T00:00:00.000Z",
      "home_team_score":105,
      "visitor_team_score":87,
      "season":2018,
      "period": 4,
      "status": "Final",
      "time": " ",
      "postseason": false,
      "home_team":{
        "id":2,
        "abbreviation":"BOS",
        "city":"Boston",
        "conference":"East",
        "division":"Atlantic",
        "full_name":"Boston Celtics",
        "name":"Celtics"
      },
      "visitor_team":{
        "id":23,
        "abbreviation":"PHI",
        "city":"Philadelphia",
        "conference":"East",
        "division":"Atlantic",
        "full_name":"Philadelphia 76ers",
        "name":"76ers"
      },
    },
    ...
  ],
  "meta": {
    "total_pages": 1877,
    "current_page": 1,
    "next_page": 2,
    "per_page": 25,
    "total_count": 46911
  }
}
```

This endpoint retrieves all games.

Seasons are represented by the year they began. For example, 2018 represents season 2018-2019.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/games`

### Query Parameters

You can combine query parameters. For example: `?seasons[]=2018&team_ids[]=1` will return games for team_id 1 for the 2018-2019 season.

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 25 | The number of results returned per call, used for pagination. Max 100.
dates | | An array of dates formatted in 'YYYY-MM-DD'
seasons | | An array of seasons
team_ids | | An array of team_ids
postseason | | Boolean
start_date | | A single date in 'YYYY-MM-DD' format. This is used to select games that occur on or after this date.
end_date | | A single date in 'YYYY-MM-DD' format. This is used to select games that occur on or before this date.

## Get a Specific Game

```shell
curl "https://www.balldontlie.io/api/v1/games/1"
```

> The above command returns JSON structured like this:

```json
{
  "id":1,
  "date":"2018-10-16T00:00:00.000Z",
  "home_team_score":105,
  "visitor_team_score":87,
  "season":2018,
  "period": 4,
  "status": "Final",
  "time": " ",
  "postseason": false,
  "home_team":{
    "id":2,
    "abbreviation":"BOS",
    "city":"Boston",
    "conference":"East",
    "division":"Atlantic",
    "full_name":"Boston Celtics",
    "name":"Celtics"
  },
  "visitor_team":{
    "id":23,
    "abbreviation":"PHI",
    "city":"Philadelphia",
    "conference":"East",
    "division":"Atlantic",
    "full_name":"Philadelphia 76ers",
    "name":"76ers"
  },
}
```

This endpoint retrieves a specific game.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/games/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the game to retrieve

## Considerations

<aside class="warning">Pre-season games are not included.</aside>

<aside class="warning">Games will be updated every ~10 minutes</aside>


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
      "id":29,
      "ast":2,
      "blk":2,
      "dreb":8,
      "fg3_pct":0.25,
      "fg3a":4,
      "fg3m":1,
      "fg_pct":0.429,
      "fga":21,
      "fgm":9,
      "ft_pct":0.8,
      "fta":5,
      "ftm":4,
      "game":{
        "id":1,
        "date":"2018-10-16T00:00:00.000Z",
        "home_team_id":2,
        "home_team_score":105,
        "season":2018,
        "visitor_team_id":23,
        "visitor_team_score":87
      },
      "min":"36:49",
      "oreb":2,
      "pf":3,
      "player":{
        "id":145,
        "first_name":"Joel",
        "last_name":"Embiid",
        "position":"F-C",
        "team_id":23
      },
      "pts":23,
      "reb":10,
      "stl":1,
      "team":{
        "id":23,
        "abbreviation":"PHI",
        "city":"Philadelphia",
        "conference":"East",
        "division":"Atlantic",
        "full_name":"Philadelphia 76ers",
        "name":"76ers"
      },
      "turnover":5
    },
    ...
  ],
  "meta": {
    "total_pages": 2042,
    "current_page": 1,
    "next_page": 2,
    "per_page": 25,
    "total_count": 51045
  }
}
```

This endpoint retrieves all stats.

### HTTP Request

`GET https://www.balldontlie.io/api/v1/stats`

### Query Parameters

You can combine query parameters. For example: `?seasons[]=2018&seasons[]=2015&player_ids[]=1&player_ids[]=2&postseason=true` will return stats for player_ids 1 and 2 for the 2015-2016 and 2018-2019 postseason.

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 25 | The number of results returned per call, used for pagination. Max 100.
dates | | An array of dates formatted in 'YYYY-MM-DD'
seasons | | An array of seasons
player_ids | | An array of player_ids
game_ids | | An array of game_ids
postseason | | Boolean
start_date | | A single date in 'YYYY-MM-DD' format. This is used to select games that occur on or after this date.
end_date | | A single date in 'YYYY-MM-DD' format. This is used to select games that occur on or before this date.

## Considerations

<aside class="warning">Some records may come back with <code>min: '0'</code> despite not being true.</aside>

<aside class="warning">Stats will be updated every ~10 minutes</aside>

# Season Averages

## Get Averages
```shell
curl "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237"
```
> The above command returns JSON structured like this:

```json
{
  "data": [
    {
      "games_played":37,
      "player_id":237,
      "season":2018,
      "min":"34:46",
      "fgm":9.92,
      "fga":19.22,
      "fg3m":2.05,
      "fg3a":5.73,
      "ftm":5.08,
      "fta":7.54,
      "oreb":0.95,
      "dreb":7.59,
      "reb":8.54,
      "ast":7.38,
      "stl":1.32,
      "blk":0.65,
      "turnover":3.49,
      "pf":1.59,
      "pts":26.97,
      "fg_pct":0.516,
      "fg3_pct":0.358,
      "ft_pct":0.674
    }
  ]
}
```

### HTTP Request

`GET https://www.balldontlie.io/api/v1/season_averages`

### Query Parameters

`api/v1/season_averages?season=2018&player_ids[]=1&player_ids[]=2` will return regular season averages for player_ids 1 and 2.

Parameter | Default | Description
--------- | ------- | -----------
season | current season | A single season
player_ids | | An array of player_ids

## Considerations

<aside class="warning">Only regular season averages are available.</aside>

