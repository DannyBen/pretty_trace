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
# Just install, do not activate
gem 'pretty_trace'

# Or, install and enable
gem 'pretty_trace', require: 'pretty_trace/enable'

# Or, install, enable and enable trimming
gem 'pretty_trace', require: 'pretty_trace/enable-trim'
```

Example
--------------------------------------------------

### Create this ruby file:

```ruby
# test.rb
require "pretty_trace/enable-enable"
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

If you wish to show a trimmed version of the backtrace (only the first and 
last line), require this script instead:

```ruby
require 'pretty_trace/enable-trim'
```

If you prefer to have more control, you can use configure these settings 
manually:

```ruby
require 'pretty_trace'

# Exceptions here will not be formatted

PrettyTrace.enable

# Exceptions here will be formatted

PrettyTrace.disable

# Exceptions here will not be formatted

PrettyTrace.trim

# Exceptions here will be trimmed

PrettyTrace.no_trim

# Exceptions here will not be trimmed
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

If you wish to temporarily disable Pretty Trace (for example, when you need 
to see the full trace paths), you can set the environment variable 
`PRETTY_TRACE=off` before running your script:

```
$ PRETTY_TRACE=off ruby myscript.rb
```

If you wish to temporarily disable trimming, you can set the environment 
variable `PRETTY_TRACE=full` before running your script:

```
$ PRETTY_TRACE=full ruby myscript.rb
```

