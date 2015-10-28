Package: alinex-exec
=================================================

[![Build Status](https://travis-ci.org/alinex/node-exec.svg?branch=master)](https://travis-ci.org/alinex/node-exec)
[![Coverage Status](https://coveralls.io/repos/alinex/node-exec/badge.png?branch=master)](https://coveralls.io/r/alinex/node-exec?branch=master)
[![Dependency Status](https://gemnasium.com/alinex/node-exec.png)](https://gemnasium.com/alinex/node-exec)

This module should be used to call external commands. It is an extended
wrapper arround the core `process.spawn` command. It's benefits are:

- automatic error control
- automatic retry in case of error
- completely adjustable
- supports remote execution
- pipes between processes (comes later)
- detachable execution (comes later)

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

You may also run the same command but only after the first run has finished.

### Simplified run

You may call all of this directly using:

``` coffee
Exec.run
  cmd: 'date'
, (err, proc) ->
  # work with the results within the process instance
```

### Closeup

If you used remote executions, there may be some open server connections in the pool
which prevent your program from ending. To end them call:

``` coffee
Exec.close()
```


Configuration
-------------------------------------------------

To configure this to your needs, please make a new configuration file for `/exec`
context. To do so you may copy the base settings from `src/config/exec.yml` into
`var/local/config/exec.yml` and change it's values or put it into your applications
configuration directory.

Like supported by [Config](http://alinex.github.io/node-config) you only have to
write the settings which differ from the defaults.

The configuration contains the following three parts:

### Retry if failed

In this part you define the number of retries and timeouts used for rechecking in
all parts which prevent the execution to start or run successfully.

``` yaml
retry:
  # check for host vital signs
  vital:
    # time to recheck host vital signs
    interval: 5s
    # maximum load% per CPU core per second in usage to start
    startload: 80%
  # too much processes opened on system
  ulimit:
    # time to sleep till next try
    interval: 1s
  # a queue will be created if host is overloaded
  queue:
    # specify the time after that a retry for queued executions should run
    interval: 3s
  # process failed retry check
  error:
    # number of attempts
    times: 3
    # time to sleep till next try
    interval: 3s
```

All `interval` settings can be set as a time range in milliseconds or with the
unit appended. Use something like '1.5s' (possible units: ms, s, m, h, d).

### Priority Levels

This defines the possible priority levels to be used. The following configuration
shows the default.

``` yaml
priority:
  # specify the default priority
  default: medium
  # specify the possible priorities with their checks
  level:
    anytime:
      maxCpu: 20%
      maxLoad: 20%
      nice: 19
    low:
      maxCpu: 40%
      maxLoad: 60%
      nice: 10
    medium:
      maxCpu: 60%
      maxLoad: 100%
      nice: 5
    high:
      maxCpu: 90%
      maxLoad: 150%
    immediately:
      nice: -20
```

You may add other values or remove some of them to get your very own set of priorities:

``` yaml
priority:
  # specify the possible priorities with their checks
  level:
    low: null
    medium: null
    high: null
    1:
      maxCpu: 40%
      maxLoad: 100%
      nice: 15
    2:
      maxCpu: 50%
      maxLoad: 120%
      nice: 5
    3:
      maxCpu: 60%
      maxLoad: 140%
      nice: 0
```

### Remote Servers

This section shows you how to setup remote servers:

``` yaml
# Define remote hosts or host pools to be used through ssh.
remote:
  server:
    # virtual name for server
    server1:
      # hostname or ip to connect to
      host: localhost
      # connection port
      port:  ssh
      # user to login as
      username: alex
      # (optionally) login using password
      #password: 'geheim'
      # (optionally) private key for login
      privateKey: <<<file:///home/alex/.ssh/id_rsa>>>
      # the passphrase for the key (if necessary)
      #passphrase: '.....'
      # the host used for hostbased authentication
      #localHostname: '...'
      # the username for host based authentcation
      #localUsername: '...'
      # time for sending keepalive packets
      keepaliveIntervall: 1s
      # the maximum time for the ssh handshake
      readyTimeout: 20s
      # maximum load to start here per each cpu
      startload: 2.4
      # debug also server communication
      debug: false
    server2:
      host: 127.0.0.1
      port:  ssh
      username: alex
      password: dontknow
      maxConnections: 5
  group:
    testpool:
      - host: server1
        weight: 0.4
      - host: server2
        weight: 0.6
```

As seen above there are two servers defined to access as `server1` and `server2`
both are the localhost for test purpose.

The `group` area can be used to define some server groups. commands which should
be executed in a group will be run on one server of the group. Which one will
be decided based on load balancing.

To use one of these send it's name (key) or that of an group as `remote` parameter
in the constructor.

If you use this module in your app call the `Exec.setup()` method before initialization
of the config module:

``` coffee
config = require 'alinex-config'
Exec = require 'alinex-exec'
schema = require './configSchema'

class App

  @setup: (cb) ->
    # setup module configs first
    async.each [Exec], (mod, cb) ->
      mod.setup cb
    , (err) ->
      return cb err if err
      # add schema for app's configuration
      config.setSchema '/app', schema
      # extend module search path
      config.register 'app', fspath.dirname __dirname
      cb()

  @init: (cb) ->
    config.init (err) =>
      return cb err if err
      @conf = config.get '/app'
      cb()
```


Setup Execution
-------------------------------------------------

To specify your executable you give an object with the following settings.

### Execution

The basic settings needed are which command to start and with which parameter.
Keep in mind that here no shell execution is possible so don't use bash basics
without specifying 'sh' or 'bash' as the command.

- cmd - (string) giving the command to call with path if needed
- args - (array) list of arguments to use in the given order

You can give both separately but you may also give attributes in the command
string. If you do so the arguments will be extracted automatically so you need
to use proper quoting.

### Remote

To run on a remote machine you only need the virtual name which has to correspond
to the configuration (see above).

- remote - (string) reference to configuration

### Environment

- cwd - (absolute path) the current working directory
- uid - (integer) the userid under which to run
- gid - (integer) the group id under which to run
- env - environment object for key-value-pairs

If you want to use different user and/or group id you have to be root first.

### Priority

The priority defines which command to run first in case of multiple commands.

- priority - (string) name of configured priority to use

By default the following priorities are possible: anytime, low, medium, high,
immediately.

### Retry/Checks

- check - name of the check with
  - 'true' as value if no args
  - args - (array) list of arguments for the check if possible
  - retry - (boolean) should retry on this failure
- retry - specify if not use the default
  - times - (integer) maximum number of retries
  - interval - (milliseconds)

The following checks may be used:

- `noExitCode` - check that the exit code is 0
- `exitCode code` - check that the exit code is in allowed list
- `noStderr` - check that STDERR is empty
- `noStdout` - check that STDOUT is empty
- `matchStdout ok, report` - check that the given `ok` RegExp succeeds,
  if not output the result of the report RegExp
- `matchStderr ok, report` - check that the given `ok` RegExp succeeds,
  if not output the result of the report RegExp
- `notMatchStderr fail` - check that the `fail` RegExp don't match

This are only the general checks. There may be more command specific matches
which you may use.

As an example you may use:

``` coffee
Exec.run
  cmd: 'ffmpeg'
  args: ['001.wma', '001.mp3']
  priority: medium
  check:
    noExitCode: true
    matchStdErr: [/Succedded/, /Failed: (\w+)/]
```

### Streams

To concat execution with other exec instances  or other objects you may concat
the following streams;

- input
- output
- error

> But this is not implemented, yet.


Access Results
-------------------------------------------------

### Process

With this attribute you may get the following information:

- exec.process.host - remote host identifier
- exec.process.pid - process id
- exec.process.start - start time
- exec.process.end - end time
- exec.process.error - system error

### Tries

If multiple tries are done you may access the information of each try:

- exec.tries[n].process - first calls
- exec.tries[n].result . first calls
- exec.process - last run
- exec.result - last run

### Results

The result code and maybe error of the defined checks may be red directly:

- exec.result.code
- exec.result.error

But to get one of the outputs better use the functions:

- exec.stdout()
- exec.stderr()

They will give you a complete text out of the line data which lists all channels
in the proper order. If order of messages matters better directly access them:

- exec.result.lines
  - 0 - stdin
  - 1 - stdout
  - 2 - stderr

You may also use the above methods on previous tries:

- exec.stdout(exec.tries[0].result)
- exec.stderr(exec.tries[0].result)




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
