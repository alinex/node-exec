Version changes
=================================================

The following list gives a short overview about what is changed between
individual versions:

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

