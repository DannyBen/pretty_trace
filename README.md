Pretty Trace - Pretty Errors and Backtrace
==================================================

[![Gem](https://img.shields.io/gem/v/pretty_trace.svg?style=flat-square)](https://rubygems.org/gems/pretty_trace)
[![Travis](https://img.shields.io/travis/DannyBen/pretty_trace.svg?style=flat-square)](https://travis-ci.org/DannyBen/pretty_trace)
[![Code Climate](https://img.shields.io/codeclimate/github/DannyBen/pretty_trace.svg?style=flat-square)](https://codeclimate.com/github/DannyBen/pretty_trace)
[![Gemnasium](https://img.shields.io/gemnasium/DannyBen/pretty_trace.svg?style=flat-square)](https://gemnasium.com/DannyBen/pretty_trace)

---

This gem makes your Ruby scripts show a pretty backtrace.

Install
--------------------------------------------------

```
$ gem install pretty_trace
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





