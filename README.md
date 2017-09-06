# Bytely
Shorten and measure links by Bytely - the world's #2 link management site. Just behind bitly


## Requirements
* Ruby 2.3
* MongoDB 2.4 or above

## Running
Make sure a local instance of MongoDB is running

Install dependencies:
```
bundle install
```

Run Rails application:
```
rails s
```

## Feature
The *homepage* provides an interface for shortening URLs. 
In addition to the web interface, API is also provided to query information about the links.

### API
| Endpoint          | Explanation   |
| ---------         | ------------- |
| `GET  /:code`     | Redirects to the original URL |
| `GET  /links/:code/clicks`        | Get click resources associated with the link  |
| `GET  /links/:id` or `/links/:code` | Get the link resource | 
| `GET  /links/:code/stat`          | Get the hourly unique visit stat of the given link code   |
| `POST /links`     | Submits the original URL then returns a `Link` resource. Parameters: `{ link: { title, url }}`  | 

## Testing
### Selenium
Make sure you have **geckodriver** in your PATH to execute the _feature_ specs. Install it
from https://github.com/mozilla/geckodriver/releases

### Running
Execute all RSpec test files with:
```
rspec
```
Feature only specs:
```
rspec spec/features
```
API specs:
```
rspec spec/api`
```
Services specs:
```
rspec spec/operations
```

## Indexing
To create indices in the MongoDB database, run the following code:
```
rails db:mongoid:create_indexes
```
