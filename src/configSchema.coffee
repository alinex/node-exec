###
Configuration
===================================================
To configure this module to your needs, please make a new configuration file for `/exec`
context. To do so you may copy the base settings from `src/config/exec.yml` into
`var/local/config/exec.yml` and change it's values or put it into your applications
configuration directory.

Like supported by {@link alinex-config} you only have to
write the settings which differ from the defaults.

The configuration contains the following three parts:
- retry handling
- priorities
- remote connections


Specification
------------------------------------------------------
{@schema #}
###


# Node Modules
# --------------------------------------
sshSchema = require 'alinex-ssh/lib/configSchema'

module.exports =
  title: "Exec configuration"
  description: "the configuration for the external command calls"
  type: 'object'
  allowedKeys: true
  mandatoryKeys: ['retry', 'priority']
  keys:
    retry:
      title: "Retry"
      description: "the retry of the process"
      type: 'object'
      allowedKeys: true
      mandatoryKeys: true
      keys:
        connect: sshSchema.keys.retry
        vital:
          title: "Vital Sign Check"
          description: "the check for host vital data"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            interval:
              title: "Time before Recheck"
              description: "the time to wait before rechecking the host vital signs"
              type: 'interval'
              unit: 'ms'
              min: 0
            startload:
              title: "Start Limit"
              description: "the maximum load% per CPU core per second in usage to start"
              type: 'percent'
              min: 0.01
        queue:
          title: "Work Queue"
          description: "the handling of the queue if load is too high"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            interval:
              title: "Recheck Time"
              description: "the time after that the worker will retry to start queued executions"
              type: 'interval'
              min: 0
        ulimit:
          title: "Retry if ULimit"
          description: "the retry if the process limit is reached"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            interval:
              title: "Time to Wait"
              description: "the time to wait before retrying a failed attempt"
              type: 'interval'
              unit: 'ms'
              min: 0
        error:
          title: "Retry if Failed"
          description: "the retry after failed retry checks"
          type: 'object'
          allowedKeys: true
          mandatoryKeys: true
          keys:
            times:
              title: "Number of Attempts"
              description: "the number of maximal attempts to run successfully"
              type: 'integer'
              min: 0
            interval:
              title: "Time to Wait"
              description: "the time to wait before retrying a failed attempt"
              type: 'interval'
              unit: 'ms'
              min: 0
    priority:
      title: "Priorities"
      description: "the setup of priorities"
      type: 'object'
      allowedKeys: true
      mandatoryKeys: true
      keys:
        default:
          title: "Default Priority"
          description: "the default priority as reference to one of the defined list entries"
          type: 'string'
          list: '<<<data://level>>>'
        level:
          title: "Priority Levels"
          description: "the definition of all possible priorities"
          type: 'object'
          entries: [
            title: "Priority Level"
            description: "the definition of one priority level"
            type: 'object'
            allowedKeys: true
            optional: true
            keys:
              maxCpu:
                title: "Max CPU"
                description: "the maximum cpu usage, till that execution may be started"
                type: 'percent'
                min: 0
                max: 1
              maxLoad:
                title: "Max Load"
                description: "the maximum system load, till that execution may be started"
                type: 'array'
                delimiter: /\s/
                minLength: 1
                maxLength: 3
                entries:
                  title: "Max Load"
                  description: "the maximum system load for period"
                  type: 'percent'
                  min: 0
              minFreemem:
                title: "Min free Mem"
                description: "the minimum free memory needed to execute"
                type: 'percent'
                min: 0
              nice:
                title: "Nice"
                description: "the niceness of the process"
                type: 'integer'
                min: -20
                max: 19
          ]
