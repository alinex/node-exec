Package: alinex-exec
=================================================

[![Build Status](https://travis-ci.org/alinex/node-exec.svg?branch=master)](https://travis-ci.org/alinex/node-exec)
[![Coverage Status](https://coveralls.io/repos/alinex/node-exec/badge.png?branch=master)](https://coveralls.io/r/alinex/node-exec?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-exec.png)](https://gemnasium.com/alinex/node-exec)

This is module should be used to call external commands. It is an extended
wrapper arround the core `process.spawn` command. It's benefits are:

- automatic error control
- automatic retry in case of error
- automatic delaying in case of high server load
- completely adjustable
- supports remote execution (comes later)

> It is one of the modules of the [Alinex Universe](http://alinex.github.io/code.html)
> following the code standards defined in the [General Docs](http://alinex.github.io/node-alinex).


Install
-------------------------------------------------

[![NPM](https://nodei.co/npm/alinex-exec.png?downloads=true&downloadRank=true&stars=true)
 ![Downloads](https://nodei.co/npm-dl/alinex-exec.png?months=9&height=3)
](https://www.npmjs.com/package/alinex-exec)

The easiest way is to let npm add the module directly to your modules
(from within you node modules directory):

``` sh
npm install alinex-exec --save
```

And update it to the latest version later:

``` sh
npm update alinex-exec --save
```

Always have a look at the latest [changes](Changelog.md).


Usage
-------------------------------------------------
You may connect to the process using a callback method on the `run()` call or
use the events.

First you have to load the class package.

``` coffee
Exec = require 'alinex-exec'
Exec.init() # this will setup the config class
```
### Run an external command

Now you may setup an external process like:

``` coffee
proc = new Exec
  cmd: 'date'
```

You may also change the configuration afterwards like:

``` coffee
proc.setup.cmd = 'date'
```

To run this simple process call the run-method:

``` coffee
proc.run (err) ->
  # work with the results
```

After the process has completed it's task the callback will get only an error
obect and the process instance which you don't need. You may access all details
through the `proc.result` and `proc.process` objects.

### Simplified run

You may call all of this directly using:

``` coffee
Exec.proc
  cmd: 'date'
, (err, proc) ->
  # work with the results within the process instance
```





### Check the results

To check the response some predefined methods can be used by configuring:

``` coffee

```






### Run using Events

With events you can monitor what's going on while the process works.

``` coffee
proc.run()

stdout = ''
proc.on 'stdout', (data) ->
  stdout += data
proc.on 'done', ->
  # analyse the results
```








License
-------------------------------------------------

Copyright 2015 Alexander Schilling

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

>  <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
