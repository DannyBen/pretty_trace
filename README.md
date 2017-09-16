Pretty Trace - Pretty Errors and Backtrace
==================================================

This forces any of your Ruby scripts to show a pretty backtrace.

Install
--------------------------------------------------

    $ gem install pretty_trace

Example
--------------------------------------------------

1. Create this ruby file:

```ruby
# test.rb
require "pretty_trace/enable"
require "fileutils"
FileUtils.rm 'no_such_file'
```

2. Run it:

    $ ruby test.rb

3. Get a pretty exception

![screenshot](/screenshot.png)





