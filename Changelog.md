Version changes
=================================================

The following list gives a short overview about what is changed between
individual versions:

Version 1.1.2 (2016-05-04)
-------------------------------------------------
- Fixed alinex-util include.
- Update util and async calls.
- Upgraded async, config, util, carrier, chalk, ssh2, validator and builder packages.
- Added v6 for travis but didn't activate, yet.
- Add test for missing remote.
- Fixed general link in README.

Version 1.1.1 (2016-02-05)
-------------------------------------------------
- Updated alinex packages.
- updated ignore files.
- Fixed style of test cases.
- Fixed lint warnings in code.
- Updated meta data of package and travis build versions.

Version 1.1.0 (2016-01-14)
-------------------------------------------------
- Finished implementation of session limit on ssh connections.
- Fixed immediately remote test.
- Merge branch 'master' of http://github.com/alinex/node-exec
- Fixed line length of code.
- Fixed stdoutLines check to work with min, max values.
- Prevent vital check if no restrictions in priority.
- Optimized failure text on checks.
- Don't run vital check on immediate priority calls.
- Add session limit on remote connections.
- Merge branch 'master' of http://github.com/alinex/node-exec
- Add more checks for containing output or specific number of lines.
- Fixed reference to timeout variable causing access to undefined.
- Merge branch 'master' of https://github.com/alinex/node-exec
- Fix access to timeout setting.
- Merge branch 'master' of http://github.com/alinex/node-exec
- Remove KILL timer after process ended.
- Merge branch 'master' of http://github.com/alinex/node-exec
- Implement timeout through commandline in both spawn and ssh.

Version 1.0.6 (2015-11-10)
-------------------------------------------------
- Test for ulimit need more time.
- Fixed timeout by sending kill/close one second after timeout.

Version 1.0.5 (2015-11-02)
-------------------------------------------------
- Fix running callback twice on timeout.

Version 1.0.4 (2015-11-02)
-------------------------------------------------
- Implement timeout parameter to stop execution after this time with SIGTERM.

Version 1.0.3 (2015-10-28)
-------------------------------------------------
- Support closing remote connections after everything done per command.
- Report connection error with server location.
- Allow remote-key in configuration to be missing.

Version 1.0.2 (2015-10-28)
-------------------------------------------------
- Try to fix connection problem reporting and extend documentation.

Version 1.0.1 (2015-10-27)
-------------------------------------------------
- Small fixes on debugging.
- Fixed problem with ssh execution on working vital test.
- Upgraded carrier submodule (speed optimization).
- Fixed bug in handling connection problems.
- Removed demo servers in base config.
- Better explain remote use.
- Wording fix in docs.
- Fix documentation style.
- Fixed format of README.
- Removed unused dependencies.

Version 1.0.0 (2015-07-29)
-------------------------------------------------
- Move test config into test folder.
- Allow rerun but prevent parallel run of the same object.
- Update properties in mindmap.
- Updated documentation.
- Disable remote checks if not on my pc.
- Small bug fixes to make complete test suit runnable again.
- Make ssh execution run for simple date command.
- Extend commandline creation to allow set uid/gid using sudo.
- Added env and dir support for remote.
- Get vital data on remote server.
- Reduce code to only use one ssh connection with parallel execution.
- Allow remote host to have different startLoad setting.
- Fill up spare sessions.
- Add connection to spare if possible.
- Display connection stats per host.
- Close ssh connections.
- Extend debug functionality.
- Added more configuration values for ssh connections.
- Added first tests for remote connections using ssh.
- Stderr stdout while running.
- Added ssh configuration example.
- Start adding ssh support.

Version 0.2.0 (2015-07-18)
-------------------------------------------------
- Enable all tests.
- Document current API.
- Added simplified call of arguments within command string.
- Fixed worker handling and added startload test.
- Added startload handling and fixed queue cleanup.
- Made queue worker running.
- Fixed messages for overload display.
- Calculate cpu load over 1sec.
- Make check errors more descriptive.
- Updated Mindmap..
- Added to queue on overload.
- Added correct coveralls call.
- Removed lag because this doesn't bring better check results.
- Use the js-only version of toobusy.
- Added node.js lag checking.
- Check vital data after new ones collected.
- Collect vital data.

Version 0.1.0 (2015-07-15)
-------------------------------------------------
- Fixed returning errors on any problem.
- Planing for statistics.
- Add retry and allow stderr() and stdout() on previouzs tries.
- Finished check integration.
- Change checks to be more descriptive.
- Optimizes check structure.
- Fixed direct call to automatically init before running constructor.
- Store joined stdout and stderr for further calls.
- Set environment language defaults to english.
- Add check possibilities.
- Added nice support.
- Updated mindmap.
- Allow handling of ulimit without failure.
- Fix schema and configuration for nice level.
- Added nice setting to priority configuration.
- Run command directly.
- Added ulimit retry interval to config.
- Made simple spawn call running.
- Module for local process added.
- Updated mindmap.
- Updated mindmap.
- Updated planning.
- Finished loading of config.
- Added init method.
- Added configuration and schema definition.
- Added schema file.
- Initial planing.
- Initial commit
