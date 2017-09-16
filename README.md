Pretty Trace - Pretty Errors and Backtrace
==================================================

[![Gem](https://img.shields.io/gem/v/pretty_trace.svg?style=flat-square)](https://rubygems.org/gems/pretty_trace)
[![Travis](https://img.shields.io/travis/DannyBen/pretty_trace.svg?style=flat-square)](https://travis-ci.org/DannyBen/pretty_trace)
[![Code Climate](https://img.shields.io/codeclimate/github/DannyBen/pretty_trace.svg?style=flat-square)](https://codeclimate.com/github/DannyBen/pretty_trace)
[![Gemnasium](https://img.shields.io/gemnasium/DannyBen/pretty_trace.svg?style=flat-square)](https://gemnasium.com/DannyBen/pretty_trace)

---

Make your Ruby backtrace pretty again. Just require `pretty_trace/enable` 
in your ruby script, and errors will become clearer and more readable.

---

Install
--------------------------------------------------

```
$ gem install pretty_trace
```

Or with bundler:

```
$ gem 'pretty_trace', require: 'pretty_trace/enable'
```

Example
--------------------------------------------------

### Create this ruby file:

```ruby
# test.rb
require "pretty_trace/enable"
require "fileutils"
FileUtils.rm 'no_such_file'
```

### Run it:

![screenshot](/screenshot.png)


Usage
--------------------------------------------------

The easiest way to use Pretty Trace is to require its activation script in
your script:

```ruby
require 'pretty_trace/enable'
```

From this point on, any exception will be formatted.

If you prefer to enable/disable the formatted backtrace manually, use 
`PrettyTrace.enable` and `PrettyTrace.disable`

```ruby
require 'pretty_trace'

# Exceptions here will not be formatted

PrettyTrace.enable

# Exceptions here will be formatted

PrettyTrace.disable

# Exceptions here will not be formatted
```


Configuration
--------------------------------------------------

To filter out lines in the backtrace, use `PrettyTrace.filter`. This method
accepts a single regular expression, or an array of regular expressions.

Note that you can call this method several times, and it will aggregate all
your filters together.

```ruby
require 'pretty_trace/enable'
PrettyTrace.filter /rails/
PrettyTrace.filter [/gem/, /lib/]
```