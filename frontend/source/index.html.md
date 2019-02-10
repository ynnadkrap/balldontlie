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

We were frustrated by the lack of free basketball APIs, so we decided to build this. In doing so we hope the basketball community can build some cool things.

We don't require an API key and there are no rate restrictions. If your sole purpose is to scrape all of the data, reach out to us instead of bombarding our servers. We'll probably just give it to you for free if you ask nicely.

Each section has some considerations (read: limitations) that are worth noting.

We hope to build upon this initial release with input from users. If you have any requests, comments, or questions, please
feel free to email us at hello@balldontlie.io.

Also, please feel free to [donate](https://www.patreon.com/balldontlie) to help keep the lights on.

## Getting Started
You need a computer with internet connection.

* no email required
* no API key required
* contains data from 1979-1980 season to current
* semi-live game stats are available (updated ~10 minutes)

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
per_page | 25 | The number of results returned per call, used for pagination.
search | | Used to filter players based on their name. For example, `?search=davis` will return players that have 'davis' in their first or last name.

## Get a Specific Player

```shell
curl "https://www.balldontlie.io/api/v1/players/237"
```

> The above command returns JSON structured like this:

```json
{
  {
    "id":237,
    "first_name":"LeBron",
    "last_name":"James",
    "position":"F",
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

You can combine query parameters. For example: `?seasons[]=2018&team_ids[]=1` will returns games for team_id 1 for the 2018-2019 season.

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
  {
    "id":1,
    "date":"2018-10-16T00:00:00.000Z",
    "home_team_score":105,
    "visitor_team_score":87,
    "season":2018,
    "period": 4,
    "status": "Final",
    "time": " ",
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

<aside class="warning">Playoff games are included in the data set. There is currently no attribute that indicates whether a game is for regular or post season. Pre-season games are not included.</aside>

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

You can combine query parameters. For example: `?seasons[]=2018&seasons[]=2015&player_ids[]=1&player_ids[]=2` will returns stats for player_ids 1 and 2 for the 2015-2016 and 2018-2019 season.

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | The page number, used for pagination.
per_page | 25 | The number of results returned per call, used for pagination.
dates | | An array of dates formatted in 'YYYY-MM-DD'
seasons | | An array of seasons
player_ids | | An array of player_ids
game_ids | | An array of game_ids

## Considerations

<aside class="warning">Some records may come back with <code>min: '0'</code> despite not being true.</aside>

<aside class="warning">Stats will be updated every ~10 minutes</aside>
