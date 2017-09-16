Pretty Trace - Pretty Errors and Backtrace
==================================================

This forces any of your Ruby scripts to show a pretty backtrace.

Install
--------------------------------------------------

```
$ gem install pretty_trace
```

Example
--------------------------------------------------

Create this ruby file:

```ruby
# test.rb
require "pretty_trace/enable"
require "fileutils"
FileUtils.rm 'no_such_file'
```

2. Run it:

![screenshot](/screenshot.png)





