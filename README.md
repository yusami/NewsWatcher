# NewsWatcher

## Overview

* Show the latest news.


## Description

1. Fetch the news from each url.
2. Parse it and show the result.

## Requirement

* Ruby
* [nokogiri](http://www.nokogiri.org)

## Usage

* Run the script.

~~~
./watcher.rb
~~~

* Latest news is shown as below.

~~~
-----------
Yahoo!ニュース
https://news.yahoo.co.jp/
- ...
-----------
日本経済新聞
https://www.nikkei.com/
- ...
~~~

## Tips

* [nokogiri](http://www.nokogiri.org) is powerful tool for parsing HTML, rather than using regex.

## Licence

* Copyright &copy; 2016-2020 yusami
* Licensed under the [Apache License, Version 2.0][Apache]

[Apache]: http://www.apache.org/licenses/LICENSE-2.0


## Author

* [yusami](https://github.com/yusami)
