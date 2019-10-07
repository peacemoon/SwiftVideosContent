# Tools

This repository contains content for the upcoming SwiftVideos app.

## Videos commands

### Videos - List Generation

Generate a list of videos

```bash
swift run --package-path scripts/SwiftVideosTools/ SwiftVideosTools videos generate content/
```

### Videos - Youtube Preview Images

Download preview images of youtube videos

```bash
swift run --package-path scripts/SwiftVideosTools/ SwiftVideosTools videos youtube_preview content/conferences/tryswift-nyc/2018
```

### Videos - Vimeo Preview Images

Download preview images of youtube videos

```bash
swift run --package-path scripts/SwiftVideosTools/ SwiftVideosTools videos vimeo_preview content/conferences/nsspain/2019
```

### Videos - List Validation

Validate the list of videos

```bash
swift run --package-path scripts/SwiftVideosTools/ SwiftVideosTools videos validate content/
```

## Authors commands

### Authors - List Generation

Generate a list of authors

```bash
swift run --package-path scripts/SwiftVideosTools/ SwiftVideosTools authors generate content/
```

### Authors - List Validation

Validate the list of authors

```bash
swift run --package-path scripts/SwiftVideosTools/ SwiftVideosTools authors validate content/
```
