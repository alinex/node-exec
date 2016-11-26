Version changes
=================================================

The following list gives a short overview about what is changed between
individual versions:

Version 2.0.0 (2016-11-26)
-------------------------------------------------
Complete restructuring with complete use of alinex-ssh for remote connections.

- Update alinex-validator@2.1.1
- Add schema checking on debug.
- Optimize debug calls if not used.
- Update alinex-ssh@2.1.2 async@2.1.4 debug@2.3.3
- Use new conn() method from next bugfix version of alinex-ssh.
- Passing all tests again.
- Fix code error if no connection could be established.
- Setup tests for remote connections.
- More time for timeout test.
- Repair vital check for local commands.
- Restructure but with problems in vital check.
- Update alinex-ssh@2.1.1
- Update description of new remote calls.
- Upgrade alinex-ssh@2.1.0
- Change code to support groups and collect multiple vital data.
- Remove debugging in response checking.
- Fix response checking.
- Update documentation.
- Run simple execution.
- Run simple execution.
- Change configuration.
- Update packages to new ssh module.
- Replace sshtunnel with newer ssh module.
- Allow all tests to run.
- Fix noExitCode check which was broken.
- Fix to work with new list of connections for remote servers.
- Fix schema definition.
- Changed data reference.
- Merge changes.
- Documented helper methods.
- Extend internal documentation.
- Document check routines.
- Update internal documentation of Exec class.
- Set immediately processing as default.
- Change structure for new documentation.
- Don't break on undefined environment setting.
- Rename links to Alinex Namespace.
- Add copyright sign.
- Fix commandline output for environment settings containing whitespace.
- Add last 5 lines of error code as description on noExitCode check.
- Enlarge timeouts.
- Test travis build with full env.
- Try to detect problems in travis.
- Updated alinex-builder package.
- Add verbose mode to default test because travis may stop otherwise.

Version 1.1.3 (2016-05-18)
-------------------------------------------------
Better event support.

- Enhance test timeouts.
- Upgraded config, util and builder package.
- Upgraded config, util and builder package.
- Optimize event support to get process output.
- Add events to documentation.

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
