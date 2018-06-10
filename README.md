Pretty Trace - Pretty Errors and Backtrace
==================================================

[![Gem Version](https://badge.fury.io/rb/pretty_trace.svg)](https://badge.fury.io/rb/pretty_trace)
[![Build Status](https://travis-ci.com/DannyBen/pretty_trace.svg?branch=master)](https://travis-ci.com/DannyBen/pretty_trace)
[![BCH compliance](https://bettercodehub.com/edge/badge/DannyBen/pretty_trace?branch=master)](https://bettercodehub.com/results/DannyBen/pretty_trace)
[![Maintainability](https://api.codeclimate.com/v1/badges/c9db6ec58ec7ac1484aa/maintainability)](https://codeclimate.com/github/DannyBen/pretty_trace/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c9db6ec58ec7ac1484aa/test_coverage)](https://codeclimate.com/github/DannyBen/pretty_trace/test_coverage)

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

```ruby
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
require "pretty_trace/enable-trim"
require "fileutils"
FileUtils.rm 'no_such_file'
```

### Run it:

![screenshot](/screenshot.gif)


Usage
--------------------------------------------------

The easiest way to use Pretty Trace is to require its activation script in
your script:

```ruby
require 'pretty_trace/enable'
```

From this point on, any exception will be formatted.

If you wish to show a trimmed version of the backtrace (where errors from the
same file are collapsed into one line), require this script instead:

```ruby
require 'pretty_trace/enable-trim'
```

If you prefer to have more control, you can configure these settings 
manually:

```ruby
require 'pretty_trace'

# Exceptions here will not be formatted

PrettyTrace.enable
# Exceptions here will be formatted

PrettyTrace.disable
# Exceptions here will not be formatted

PrettyTrace.enable
PrettyTrace.trim
# Exceptions here will be formatted and trimmed

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

